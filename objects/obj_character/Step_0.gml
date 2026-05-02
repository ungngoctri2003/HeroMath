if (dead) {
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
	hurt_timer -= 1;
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
}

if (variable_global_exists("quiz_cooldown") && global.quiz_cooldown > 0) {
	global.quiz_cooldown--;
}

if (variable_global_exists("quiz_active") && global.quiz_active) {
	global.hp = hp;
	global.hp_max = hp_max;
	return;
}

if (!attacking && mouse_check_button_pressed(mb_right)
	&& !(variable_global_exists("game_over") && global.game_over)) {
	attacking = true;
	attack_damage_done = true;
	sprite_index = spr_charater_danh;
	image_index = 0;
	image_speed = attack_image_speed;
	image_xscale = (mouse_x >= x) ? 1 : -1;
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

var feet_on_bac_surface = false;
with (obj_bac_thang) {
	if ((other.bbox_right > bbox_left) && (other.bbox_left < bbox_right)) {
		var _ptop = bbox_top;
		if (other.bbox_bottom >= _ptop - 10 && other.bbox_bottom <= _ptop + 14) {
			feet_on_bac_surface = true;
		}
	}
}

if (keyboard_check_pressed(vk_space) && (place_meeting(x, y + 1, obj_ground) || feet_on_bac_surface)) {
	vsp = jump;
} else if ((place_meeting(x, y + 1, obj_ground) || feet_on_bac_surface) && vsp >= 0) {
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

// Bậc thang một chiều: chỉ đậu khi rơi/xuống từ phía trên mặt bục; đi ngang xuyên qua
if (vsp >= 0) {
	var inst_bt = instance_place(x, y, obj_bac_thang);
	if (inst_bt != noone) {
		var plat_top = inst_bt.bbox_top;
		var prev_bottom = bbox_bottom - vsp;
		var horiz_ok = (bbox_right > inst_bt.bbox_left && bbox_left < inst_bt.bbox_right);
		var on_surface = (bbox_bottom >= plat_top - 6 && bbox_bottom <= plat_top + 22);
		if (horiz_ok && on_surface && prev_bottom <= plat_top + 14) {
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

feet_on_bac_surface = false;
with (obj_bac_thang) {
	if ((other.bbox_right > bbox_left) && (other.bbox_left < bbox_right)) {
		var _ptop2 = bbox_top;
		if (other.bbox_bottom >= _ptop2 - 10 && other.bbox_bottom <= _ptop2 + 14) {
			feet_on_bac_surface = true;
		}
	}
}

if (place_meeting(x, y + 1, obj_ground) || feet_on_bac_surface) {
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

if (!attacking && !dead && hurt_timer <= 0 && !(variable_global_exists("game_over") && global.game_over) && (!variable_global_exists("quiz_cooldown") || global.quiz_cooldown <= 0)) {
	var e = instance_place(x, y, obj_par_enemy);
	if (e != noone) {
		if (!variable_global_exists("quiz_opt") || !is_array(global.quiz_opt) || array_length(global.quiz_opt) < 4) {
			global.quiz_opt = [0, 0, 0, 0];
		}
		global.quiz_active = true;
		global.quiz_enemy = e;
		image_xscale = (e.x >= x) ? 1 : -1;

		var n1 = irandom_range(2, 12);
		var n2 = irandom_range(2, 12);
		var ans = 0;
		if (random(1) < 0.5) {
			global.quiz_question = string(n1) + " + " + string(n2) + " = ?";
			ans = n1 + n2;
		} else {
			if (n2 > n1) {
				var _t = n1;
				n1 = n2;
				n2 = _t;
			}
			global.quiz_question = string(n1) + " - " + string(n2) + " = ?";
			ans = n1 - n2;
		}
		var ci = irandom(3);
		global.quiz_correct = ci;
		for (var i = 0; i < 4; i++) {
			if (i == ci) {
				global.quiz_opt[i] = ans;
			} else {
				var w = ans;
				var guard = 0;
				do {
					w = ans + irandom_range(-8, 8);
					guard++;
				} until (((w != ans) && (w >= 0) && (w < 100)) || guard > 45);
				if (guard > 45) {
					w = ans + 3 + i * 2;
				}
				global.quiz_opt[i] = w;
			}
		}
		for (var j = 0; j < 4; j++) {
			for (var kk = j + 1; kk < 4; kk++) {
				if (global.quiz_opt[j] == global.quiz_opt[kk]) {
					global.quiz_opt[kk] = ans + 7 + kk * 4;
				}
			}
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

if (room == Room1 && hp > 0 && !dead) {
	var _en = 0;
	with (obj_par_enemy) {
		_en += 1;
	}
	if (_en <= 0) {
		room_goto(Room2);
	}
}
