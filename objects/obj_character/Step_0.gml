if (dead) {
	if (variable_instance_exists(id, "run_snd_voice") && run_snd_voice >= 0) {
		if (audio_is_playing(run_snd_voice)) {
			audio_stop_sound(run_snd_voice);
		}
		run_snd_voice = -1;
	}
	if (!die_sfx_played) {
		audio_play_sound(sound_game_over, 40, false);
		die_sfx_played = true;
	}
	sprite_index = spr_character_die;
	image_index = 0;
	image_speed = 0.15;
	attacking = false;
	global.hp = 0;
	global.hp_max = hp_max;
	if (keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space)) {
		global.game_over = false;
		global.score = 0;
		room_restart();
	}
	return;
}

if (hurt_timer > 0) {
	if (variable_instance_exists(id, "run_snd_voice") && run_snd_voice >= 0) {
		if (audio_is_playing(run_snd_voice)) {
			audio_stop_sound(run_snd_voice);
		}
		run_snd_voice = -1;
	}
	if (!hurt_was_active) {
		audio_play_sound(sound_bi_quai_can, 50, false);
		hurt_was_active = true;
	}
	hurt_timer -= 1;
	if (hurt_timer <= 0) {
		hurt_was_active = false;
	}
	sprite_index = spr_character_bi_danh;
	image_index = 0;
	image_speed = 0.25;
	attacking = false;
	global.hp = hp;
	global.hp_max = hp_max;
	return;
}

if (variable_global_exists("quiz_pending_attack") && global.quiz_pending_attack) {
	global.quiz_pending_attack = false;
	if (variable_global_exists("quiz_face_x")) {
		image_xscale = (global.quiz_face_x >= x) ? 1 : -1;
	}
	attacking = true;
	attack_damage_done = true;
	sprite_index = spr_charater_danh;
	image_index = 0;
	image_speed = attack_image_speed;
	audio_play_sound(sound_kiem_chem, 50, false);
}

if (variable_global_exists("quiz_cooldown") && global.quiz_cooldown > 0) {
	global.quiz_cooldown--;
}

if (variable_global_exists("quiz_active") && global.quiz_active) {
	if (variable_instance_exists(id, "run_snd_voice") && run_snd_voice >= 0) {
		if (audio_is_playing(run_snd_voice)) {
			audio_stop_sound(run_snd_voice);
		}
		run_snd_voice = -1;
	}
	global.hp = hp;
	global.hp_max = hp_max;
	return;
}

if (room == RoomStart) {
	if (variable_instance_exists(id, "run_snd_voice") && run_snd_voice >= 0) {
		if (audio_is_playing(run_snd_voice)) {
			audio_stop_sound(run_snd_voice);
		}
		run_snd_voice = -1;
	}
	sprite_index = spr_character_dung_yen;
	image_speed = idle_image_speed;
	attacking = false;
	image_xscale = 1;
	global.hp = hp;
	global.hp_max = hp_max;
	return;
}

if (room == RoomEnding) {
	vsp = 0;
	attacking = false;
	global.hp = hp;
	global.hp_max = hp_max;

	var _cc = instance_nearest(x, y, obj_congchua);
	if (_cc == noone) {
		if (variable_instance_exists(id, "run_snd_voice") && run_snd_voice >= 0) {
			if (audio_is_playing(run_snd_voice)) {
				audio_stop_sound(run_snd_voice);
			}
			run_snd_voice = -1;
		}
		sprite_index = spr_idle;
		image_speed = idle_image_speed;
		ending_arrived = true;
		return;
	}

	if (!variable_instance_exists(id, "ending_side_initialized")) {
		ending_side_from_left = (x < _cc.x);
		ending_side_initialized = true;
	}

	var _margin = 20;
	var _dx_r = bbox_right - x;
	var _dx_l = x - bbox_left;
	var _tx;
	if (ending_side_from_left) {
		_tx = _cc.bbox_left - _margin - _dx_r;
	} else {
		_tx = _cc.bbox_right + _margin + _dx_l;
	}
	_tx = clamp(_tx, 48, room_width - 48);

	if (abs(x - _tx) > 2) {
		x += sign(_tx - x) * min(move_speed, abs(_tx - x));
		image_xscale = (x < _tx) ? 1 : -1;
		sprite_index = spr_walk;
		image_speed = walk_image_speed;
		ending_arrived = false;
	} else {
		x = _tx;
		ending_arrived = true;
		sprite_index = spr_idle;
		image_speed = idle_image_speed;
		image_xscale = (_cc.x >= x) ? 1 : -1;
	}
	if (sprite_index == spr_walk) {
		if (run_snd_voice < 0 || !audio_is_playing(run_snd_voice)) {
			run_snd_voice = audio_play_sound(sound_chay_bo, 100, true);
		}
	} else if (variable_instance_exists(id, "run_snd_voice") && run_snd_voice >= 0) {
		if (audio_is_playing(run_snd_voice)) {
			audio_stop_sound(run_snd_voice);
		}
		run_snd_voice = -1;
	}
	return;
}

if (!attacking && (mouse_check_button_pressed(mb_left) || mouse_check_button_pressed(mb_right))
	&& !(variable_global_exists("game_over") && global.game_over)) {
	attacking = true;
	attack_damage_done = true;
	sprite_index = spr_charater_danh;
	image_index = 0;
	image_speed = attack_image_speed;
	image_xscale = (mouse_x >= x) ? 1 : -1;
	audio_play_sound(sound_kiem_chem, 50, false);
}

var move = keyboard_check(vk_right) - keyboard_check(vk_left);
var hsp = move * move_speed;

x += hsp;
if (hsp != 0) {
	var _hiter = 0;
	while (place_meeting(x, y, obj_ground) && _hiter < 64) {
		x -= sign(hsp);
		_hiter++;
	}
}

var feet_on_jump_surface = false;
with (obj_bac_thang) {
	if ((other.bbox_right > bbox_left) && (other.bbox_left < bbox_right)) {
		var _ptop = bbox_top;
		var _pbot = bbox_bottom;
		var _feet_lo = _ptop - 14;
		var _feet_hi = (abs(image_angle) > 0.01) ? (_pbot + 14) : (_ptop + 18);
		if (other.bbox_bottom >= _feet_lo && other.bbox_bottom <= _feet_hi) {
			feet_on_jump_surface = true;
		}
	}
}
with (obj_dat) {
	if ((other.bbox_right > bbox_left) && (other.bbox_left < bbox_right)) {
		var _ptopd = bbox_top;
		if (other.bbox_bottom >= _ptopd - 14 && other.bbox_bottom <= _ptopd + 18) {
			feet_on_jump_surface = true;
		}
	}
}

if ((keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_up)) && (place_meeting(x, y + 1, obj_ground) || feet_on_jump_surface)) {
	vsp = jump;
} else if ((place_meeting(x, y + 1, obj_ground) || feet_on_jump_surface) && vsp >= 0) {
	vsp = 0;
} else {
	vsp += grav;
}

y += vsp;
if (place_meeting(x, y, obj_ground)) {
	var _viter = 0;
	while (place_meeting(x, y, obj_ground) && _viter < 64) {
		if (vsp != 0) {
			y -= sign(vsp);
		} else {
			y -= 1;
		}
		_viter++;
	}
	vsp = 0;
}

// Bậc thang / mặt đá (obj_bac_thang + obj_dat): đậu từ phía trên như một chiều
if (vsp >= 0) {
	var inst_plat = instance_place(x, y, obj_bac_thang);
	if (inst_plat == noone) {
		inst_plat = instance_place(x, y, obj_dat);
	}
	if (inst_plat == noone && vsp > 0.25) {
		var _scan = min(ceil(vsp) + 14, 56);
		for (var _si = 1; _si <= _scan && inst_plat == noone; _si++) {
			inst_plat = instance_place(x, y - _si, obj_bac_thang);
			if (inst_plat == noone) {
				inst_plat = instance_place(x, y - _si, obj_dat);
			}
		}
	}
	if (inst_plat != noone) {
		var plat_top = inst_plat.bbox_top;
		var plat_bot = inst_plat.bbox_bottom;
		var prev_bottom = bbox_bottom - vsp;
		var horiz_ok = (bbox_right > inst_plat.bbox_left && bbox_left < inst_plat.bbox_right);
		var _ang = inst_plat.image_angle;
		var top_lo = plat_top - 8;
		var top_hi = plat_top + 26;
		var prev_max = plat_top + 20;
		if (abs(_ang) > 0.01) {
			top_hi = plat_bot + 20;
			prev_max = plat_bot + 16;
		}
		var on_surface = (bbox_bottom >= top_lo && bbox_bottom <= top_hi);
		var from_above = (prev_bottom <= prev_max);
		if (horiz_ok && on_surface && from_above) {
			y += plat_top - bbox_bottom;
			vsp = 0;
		}
	}
}

if (move != 0 && image_xscale != move) {
	var old_s = image_xscale;
	image_xscale = move;
	var ox = sprite_get_xoffset(mask_index);
	var cx = (sprite_get_bbox_left(mask_index) + sprite_get_bbox_right(mask_index)) * 0.5;
	x += (old_s - image_xscale) * (cx - ox);
	var _fiter = 0;
	while (place_meeting(x, y, obj_ground) && _fiter < 64) {
		x -= sign(move);
		_fiter++;
	}
}

feet_on_jump_surface = false;
with (obj_bac_thang) {
	if ((other.bbox_right > bbox_left) && (other.bbox_left < bbox_right)) {
		var _ptop2 = bbox_top;
		var _pbot2 = bbox_bottom;
		var _feet_lo2 = _ptop2 - 14;
		var _feet_hi2 = (abs(image_angle) > 0.01) ? (_pbot2 + 14) : (_ptop2 + 18);
		if (other.bbox_bottom >= _feet_lo2 && other.bbox_bottom <= _feet_hi2) {
			feet_on_jump_surface = true;
		}
	}
}
with (obj_dat) {
	if ((other.bbox_right > bbox_left) && (other.bbox_left < bbox_right)) {
		var _ptop2d = bbox_top;
		if (other.bbox_bottom >= _ptop2d - 14 && other.bbox_bottom <= _ptop2d + 18) {
			feet_on_jump_surface = true;
		}
	}
}

if (place_meeting(x, y + 1, obj_ground) || feet_on_jump_surface) {
	x = round(x);
}

var _enemy_count = 0;
with (obj_par_enemy) {
	_enemy_count += 1;
}
if (_enemy_count > 0) {
	if (bbox_left < 0) {
		x -= bbox_left;
	}
	if (bbox_right > room_width) {
		x -= (bbox_right - room_width);
	}
}

if (!dead && hurt_timer <= 0 && !(variable_global_exists("game_over") && global.game_over) && (!variable_global_exists("quiz_cooldown") || global.quiz_cooldown <= 0)) {
	var e = instance_place(x, y, obj_par_enemy);
	if (e == noone) {
		var _padx = 24;
		var _pady = 40;
		e = collision_rectangle(bbox_left - _padx, bbox_top - _pady, bbox_right + _padx, bbox_bottom + _pady, obj_par_enemy, false, true);
	}
	if (e != noone && e.object_index == obj_dat) {
		var _standing_on_dat = false;
		if (bbox_right > e.bbox_left && bbox_left < e.bbox_right) {
			var _dtop = e.bbox_top;
			if (bbox_bottom >= _dtop - 10 && bbox_bottom <= _dtop + 14) {
				_standing_on_dat = true;
			}
		}
		if (_standing_on_dat) {
			e = noone;
		}
	}
	if (e != noone) {
		attacking = false;
		attack_damage_done = false;
		if (!variable_global_exists("quiz_opt") || !is_array(global.quiz_opt) || array_length(global.quiz_opt) < 4) {
			global.quiz_opt = [0, 0, 0, 0];
		}
		global.quiz_active = true;
		global.quiz_enemy = e;
		image_xscale = (e.x >= x) ? 1 : -1;

		var _tier = 0;
		if (room == Room3) {
			_tier = 2;
		} else if (room == Room2) {
			_tier = 1;
		}

		var _rf = global._quiz_reduce_frac_str;
		var _frac_q = false;
		var qt = irandom(3);
		var n1 = 0;
		var n2 = 0;
		var ans = 0;

		if (qt == 0) {
			if (_tier == 0) {
				n1 = irandom_range(5, 30);
				n2 = irandom_range(5, 30);
			} else if (_tier == 1) {
				n1 = irandom_range(8, 50);
				n2 = irandom_range(8, 50);
			} else {
				n1 = irandom_range(12, 99);
				n2 = irandom_range(12, 99);
			}
			global.quiz_question = string(n1) + " + " + string(n2) + " = ?";
			ans = n1 + n2;
		} else if (qt == 1) {
			if (_tier == 0) {
				n1 = irandom_range(14, 40);
				n2 = irandom_range(2, n1 - 2);
			} else if (_tier == 1) {
				n1 = irandom_range(25, 80);
				n2 = irandom_range(5, n1 - 5);
			} else {
				n1 = irandom_range(35, 99);
				n2 = irandom_range(8, n1 - 8);
			}
			if (n2 >= n1) {
				n2 = max(1, n1 - 1);
			}
			global.quiz_question = string(n1) + " - " + string(n2) + " = ?";
			ans = n1 - n2;
		} else if (qt == 2) {
			if (_tier == 0) {
				n1 = irandom_range(2, 5);
				n2 = irandom_range(2, 5);
			} else if (_tier == 1) {
				n1 = irandom_range(2, 9);
				n2 = irandom_range(2, 9);
			} else {
				n1 = irandom_range(2, 10);
				n2 = irandom_range(2, 10);
			}
			global.quiz_question = string(n1) + " × " + string(n2) + " = ?";
			ans = n1 * n2;
		} else if (qt == 3) {
			var _div = 0;
			var _q = 0;
			if (_tier == 0) {
				_div = irandom_range(2, 5);
				_q = irandom_range(2, 10);
			} else if (_tier == 1) {
				_div = irandom_range(2, 9);
				_q = irandom_range(2, 10);
			} else {
				_div = irandom_range(2, 10);
				_q = irandom_range(2, 10);
			}
			var _prod = _div * _q;
			global.quiz_question = string(_prod) + " : " + string(_div) + " = ?";
			ans = _q;
		} else if (qt == 4) {
			var a = 0;
			var b = 0;
			var c = 0;
			if (_tier == 0) {
				a = irandom_range(3, 18);
				b = irandom_range(4, 12);
				c = irandom_range(3, 12);
			} else if (_tier == 1) {
				a = irandom_range(8, 35);
				b = irandom_range(6, 18);
				c = irandom_range(5, 16);
			} else {
				a = irandom_range(15, 55);
				b = irandom_range(8, 24);
				c = irandom_range(7, 19);
			}
			ans = a + b * c;
			global.quiz_question = "Tính: " + string(a) + " + " + string(b) + " × " + string(c) + " = ?";
		} else if (qt == 5) {
			var _k = 0;
			var N = 0;
			var tries = 0;
			do {
				if (_tier == 0) {
					N = irandom_range(20, 180) * irandom_range(1, 2);
				} else if (_tier == 1) {
					N = irandom_range(12, 180) * 2;
				} else {
					N = irandom_range(15, 260) * 2;
				}
				_k = choose(5, 8, 10, 12, 15, 16, 20, 24, 25, 30, 32, 40, 45, 48, 50);
				tries++;
			} until (((N * _k) mod 100 == 0 && N * _k > 0) || tries > 80);
			if ((N * _k) mod 100 != 0) {
				N = 200;
				_k = 15;
			}
			ans = (N * _k) div 100;
			global.quiz_question = string(_k) + "% của " + string(N) + " bằng bao nhiêu?";
		} else if (qt == 6) {
			var nv = 0;
			if (_tier == 0) {
				nv = irandom_range(8, 15);
			} else if (_tier == 1) {
				nv = irandom_range(10, 22);
			} else {
				nv = irandom_range(14, 28);
			}
			var sq = nv * nv;
			ans = nv;
			global.quiz_question = "√" + string(sq) + " bằng bao nhiêu?";
		} else if (qt == 7) {
			var coef = 0;
			var bn = 0;
			var xv = 0;
			if (_tier == 0) {
				coef = irandom_range(2, 6);
				xv = irandom_range(3, 18);
				bn = irandom_range(2, 28);
			} else if (_tier == 1) {
				coef = irandom_range(3, 9);
				xv = irandom_range(5, 28);
				bn = irandom_range(5, 42);
			} else {
				coef = irandom_range(4, 12);
				xv = irandom_range(8, 38);
				bn = irandom_range(8, 55);
			}
			var rhs = coef * xv + bn;
			ans = xv;
			global.quiz_question = string(coef) + "x + " + string(bn) + " = " + string(rhs) + " — x bằng?";
		} else if (qt == 8) {
			_frac_q = true;
			var d = irandom_range(6 + _tier * 2, 18 + _tier * 4);
			var na = irandom_range(1, d - 2);
			var nb = irandom_range(1, d - 2);
			if (irandom(1) == 0) {
				global.quiz_question = "Tính: " + string(na) + "/" + string(d) + " + " + string(nb) + "/" + string(d) + " = ?";
				ans = na + nb;
				var _fr_s = _rf(ans, d);
				var _wtab = [
					_rf(ans + 1, d),
					_rf(ans - 1, d),
					_rf(ans, d + 1),
					_rf(ans + 2, d),
					_rf(max(1, ans - 2), d),
				];
				var _ws = [];
				for (var _wi = 0; _wi < array_length(_wtab); _wi++) {
					var _c = _wtab[_wi];
					if (_c == _fr_s) {
						continue;
					}
					var _dup = false;
					for (var _wj = 0; _wj < array_length(_ws); _wj++) {
						if (_ws[_wj] == _c) {
							_dup = true;
							break;
						}
					}
					if (!_dup) {
						array_push(_ws, _c);
					}
				}
				var _g2 = 0;
				while (array_length(_ws) < 3 && _g2 < 20) {
					array_push(_ws, _rf(ans + 3 + _g2, d));
					_g2++;
				}
				while (array_length(_ws) < 3) {
					array_push(_ws, _rf(ans + 11 + array_length(_ws) * 4, d));
				}
				global.quiz_correct = irandom(3);
				var _wix = 0;
				for (var _oi = 0; _oi < 4; _oi++) {
					if (_oi == global.quiz_correct) {
						global.quiz_opt[_oi] = _fr_s;
					} else {
						global.quiz_opt[_oi] = _ws[_wix];
						_wix++;
					}
				}
			} else {
				if (na <= nb) {
					var _swp = na;
					na = nb;
					nb = _swp;
				}
				global.quiz_question = "Tính: " + string(na) + "/" + string(d) + " - " + string(nb) + "/" + string(d) + " = ?";
				ans = na - nb;
				var _fr_s2 = _rf(ans, d);
				var _wtab2 = [
					_rf(ans + 1, d),
					_rf(max(0, ans - 1), d),
					_rf(ans, d + 1),
					_rf(ans + 2, d),
				];
				var _ws2 = [];
				for (var _wi2 = 0; _wi2 < array_length(_wtab2); _wi2++) {
					var _c2 = _wtab2[_wi2];
					if (_c2 == _fr_s2) {
						continue;
					}
					var _dup2 = false;
					for (var _wj2 = 0; _wj2 < array_length(_ws2); _wj2++) {
						if (_ws2[_wj2] == _c2) {
							_dup2 = true;
							break;
						}
					}
					if (!_dup2) {
						array_push(_ws2, _c2);
					}
				}
				var _g3 = 0;
				while (array_length(_ws2) < 3 && _g3 < 20) {
					array_push(_ws2, _rf(ans + 2 + _g3, max(2, d - 1)));
					_g3++;
				}
				while (array_length(_ws2) < 3) {
					array_push(_ws2, _rf(ans + 7 + array_length(_ws2), max(2, d)));
				}
				global.quiz_correct = irandom(3);
				var _wix2 = 0;
				for (var _oi2 = 0; _oi2 < 4; _oi2++) {
					if (_oi2 == global.quiz_correct) {
						global.quiz_opt[_oi2] = _fr_s2;
					} else {
						global.quiz_opt[_oi2] = _ws2[_wix2];
						_wix2++;
					}
				}
			}
		} else if (qt == 9) {
			_frac_q = true;
			var fa = irandom_range(2 + _tier, 9 + _tier * 2);
			var fb = irandom_range(2 + _tier, 9 + _tier * 2);
			var fc = irandom_range(2 + _tier, 9 + _tier * 2);
			var fd = irandom_range(2 + _tier, 9 + _tier * 2);
			var Nn = fa * fc;
			var Nd = fb * fd;
			global.quiz_question = "Tính: " + string(fa) + "/" + string(fb) + " × " + string(fc) + "/" + string(fd) + " = ?";
			var _fr_s3 = _rf(Nn, Nd);
			var _wtab3 = [
				_rf(Nn + 1, Nd),
				_rf(max(1, Nn - 1), Nd),
				_rf(Nn, Nd + 1),
				_rf(Nn + fc, Nd),
				_rf(fa, fb),
			];
			var _ws3 = [];
			for (var _wi3 = 0; _wi3 < array_length(_wtab3); _wi3++) {
				var _c3 = _wtab3[_wi3];
				if (_c3 == _fr_s3) {
					continue;
				}
				var _dup3 = false;
				for (var _wj3 = 0; _wj3 < array_length(_ws3); _wj3++) {
					if (_ws3[_wj3] == _c3) {
						_dup3 = true;
						break;
					}
				}
				if (!_dup3) {
					array_push(_ws3, _c3);
				}
			}
			var _g4 = 0;
			while (array_length(_ws3) < 3 && _g4 < 20) {
				array_push(_ws3, _rf(Nn + 2 + _g4, max(2, Nd - 1)));
				_g4++;
			}
			while (array_length(_ws3) < 3) {
				array_push(_ws3, _rf(Nn + 9 + array_length(_ws3) * 2, max(2, Nd)));
			}
			global.quiz_correct = irandom(3);
			var _wix3 = 0;
			for (var _oi3 = 0; _oi3 < 4; _oi3++) {
				if (_oi3 == global.quiz_correct) {
					global.quiz_opt[_oi3] = _fr_s3;
				} else {
					global.quiz_opt[_oi3] = _ws3[_wix3];
					_wix3++;
				}
			}
		} else if (qt == 10) {
			var A = irandom_range(18 + _tier * 8, 72 + _tier * 36);
			var B = irandom_range(18 + _tier * 8, 72 + _tier * 36);
			var gca = A;
			var gcb = B;
			while (gcb != 0) {
				var gt2 = gca mod gcb;
				gca = gcb;
				gcb = gt2;
			}
			gca = max(1, gca);
			if (irandom(1) == 0) {
				ans = gca;
				global.quiz_question = "ƯCLN(" + string(A) + ", " + string(B) + ") bằng?";
			} else {
				ans = (A div gca) * B;
				global.quiz_question = "BCNN(" + string(A) + ", " + string(B) + ") bằng?";
			}
		}

		if (!_frac_q) {
			var _wrong_hi = max(220, abs(ans) + 80 + _tier * 50);
			var _wrong_lo = -120;
			var _spread = max(10, abs(ans) div 3 + 8 + _tier * 8);
			var ci = irandom(3);
			global.quiz_correct = ci;
			for (var i = 0; i < 4; i++) {
				if (i == ci) {
					global.quiz_opt[i] = ans;
				} else {
					var w = ans;
					var guard = 0;
					do {
						w = ans + irandom_range(-_spread, _spread);
						guard++;
					} until (((w != ans) && (w >= _wrong_lo) && (w < _wrong_hi)) || guard > 55);
					if (guard > 55) {
						w = ans + 4 + i * 3 + _tier * 6;
					}
					global.quiz_opt[i] = w;
				}
			}
			for (var j = 0; j < 4; j++) {
				for (var kk = j + 1; kk < 4; kk++) {
					if (global.quiz_opt[j] == global.quiz_opt[kk]) {
						global.quiz_opt[kk] = ans + 9 + kk * 5 + _tier;
					}
				}
			}
		} else {
			for (var j2 = 0; j2 < 4; j2++) {
				for (var kk2 = j2 + 1; kk2 < 4; kk2++) {
					if (string(global.quiz_opt[j2]) == string(global.quiz_opt[kk2])) {
						global.quiz_opt[kk2] = string(global.quiz_opt[kk2]) + " ";
					}
				}
			}
		}
		if (variable_instance_exists(id, "run_snd_voice") && run_snd_voice >= 0) {
			if (audio_is_playing(run_snd_voice)) {
				audio_stop_sound(run_snd_voice);
			}
			run_snd_voice = -1;
		}
		global.hp = hp;
		global.hp_max = hp_max;
		return;
	}
}

if (attacking && sprite_index == spr_charater_danh) {
	image_speed = 0;
	var n = image_number;
	image_index += attack_image_speed;
	if (image_index >= n) {
		attacking = false;
		image_index = 0;
		attack_damage_done = false;
	}
}

if (!attacking) {
	var spr_target = (move != 0) ? spr_walk : spr_idle;
	if (sprite_index != spr_target) {
		sprite_index = spr_target;
		image_index = 0;
	}
	if (sprite_index == spr_walk) {
		image_speed = walk_image_speed;
	} else {
		image_speed = idle_image_speed;
	}
}

var _grounded_run = place_meeting(x, y + 1, obj_ground) || feet_on_jump_surface;
var _want_run_sfx = !attacking && (move != 0) && _grounded_run;
if (_want_run_sfx) {
	if (run_snd_voice < 0 || !audio_is_playing(run_snd_voice)) {
		run_snd_voice = audio_play_sound(sound_chay_bo, 100, true);
	}
} else {
	if (variable_instance_exists(id, "run_snd_voice") && run_snd_voice >= 0) {
		if (audio_is_playing(run_snd_voice)) {
			audio_stop_sound(run_snd_voice);
		}
		run_snd_voice = -1;
	}
}

global.hp = hp;
global.hp_max = hp_max;

if (hp <= 0 && !dead) {
	dead = true;
	hp = 0;
	global.hp = 0;
	global.game_over = true;
	hurt_timer = 0;
	sprite_index = spr_character_die;
	image_index = 0;
	image_speed = 0.15;
	attacking = false;
	return;
}

if (hp > 0 && !dead) {
	var _en = 0;
	with (obj_par_enemy) {
		_en += 1;
	}
	if (_en <= 0) {
		if (room == Room1) {
			room_goto(Room2);
		} else if (room == Room2) {
			room_goto(Room3);
		} else if (room == Room3) {
			global.quiz_active = false;
			global.quiz_enemy = noone;
			global.quiz_cooldown = 0;
			global.quiz_pending_attack = false;
			room_goto(RoomEnding);
		}
	}
}
