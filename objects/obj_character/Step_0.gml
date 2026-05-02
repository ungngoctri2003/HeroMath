if (mouse_check_button_pressed(mb_left) && !attacking) {
	attacking = true;
	sprite_index = spr_charater_danh;
	image_index = 0;
	image_speed = attack_image_speed;
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

if (attacking && sprite_index == spr_charater_danh) {
	image_speed = 0;
	var n = image_number;
	image_index += attack_image_speed;
	if (image_index >= n) {
		attacking = false;
		image_index = 0;
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
