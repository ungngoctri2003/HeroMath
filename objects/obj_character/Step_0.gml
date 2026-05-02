if (mouse_check_button_pressed(mb_left) && !attacking) {
	attacking = true;
	sprite_index = spr_charater_danh;
	image_index = 0;
	image_speed = attack_image_speed;
	attack_timer = ceil(sprite_get_number(spr_charater_danh) / attack_image_speed);
} else if (attacking) {
	attack_timer -= 1;
	if (attack_timer <= 0) {
		attacking = false;
		sprite_index = spr_idle;
		image_index = 0;
		image_speed = idle_image_speed;
	}
}

var move = keyboard_check(vk_right) - keyboard_check(vk_left);
var hsp = move * move_speed;

if (!attacking) {
	if (sprite_index != spr_idle) {
		sprite_index = spr_idle;
		image_index = 0;
	}
	image_speed = idle_image_speed;
}

x += hsp;
if (hsp != 0) {
	var _hiter = 0;
	while (place_meeting(x, y, obj_ground) && _hiter < 64) {
		x -= sign(hsp);
		_hiter++;
	}
}

if (keyboard_check_pressed(vk_space) && place_meeting(x, y + 1, obj_ground)) {
	vsp = jump;
} else if (place_meeting(x, y + 1, obj_ground) && vsp >= 0) {
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

if (place_meeting(x, y + 1, obj_ground)) {
	x = round(x);
}
