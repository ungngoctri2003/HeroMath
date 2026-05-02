if (!variable_global_exists("quiz_active") || !global.quiz_active) return;
if (variable_global_exists("game_over") && global.game_over) return;

var pick = -1;
if (keyboard_check_pressed(ord("1")) || keyboard_check_pressed(vk_numpad1)) pick = 0;
if (keyboard_check_pressed(ord("2")) || keyboard_check_pressed(vk_numpad2)) pick = 1;
if (keyboard_check_pressed(ord("3")) || keyboard_check_pressed(vk_numpad3)) pick = 2;
if (keyboard_check_pressed(ord("4")) || keyboard_check_pressed(vk_numpad4)) pick = 3;

var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);
var gw = display_get_gui_width();
var gh = display_get_gui_height();

// Trùng layout với Draw_64.gml
var side_m = 20;
var pw = min(540, floor(gw) - side_m * 2);
pw = max(pw, 280);
var px = floor((gw - pw) * 0.5);
var ph = 392;
var py = floor((gh - ph) * 0.5);
var pad = (pw < 400) ? 18 : 24;
var gap = (pw < 400) ? 10 : 12;
var opt_h = 50;
var opt_inner = pw - pad * 2 - gap;
var opt_w = opt_inner div 2;
var opt_x0 = px + pad;
var opt_y0 = py + 174;

if (pick < 0 && mouse_check_button_pressed(mb_left)) {
	var x1a = opt_x0;
	var x1b = opt_x0 + opt_w + gap;
	var y1a = opt_y0;
	var y1b = opt_y0 + opt_h + gap;
	if (point_in_rectangle(mx, my, x1a, y1a, x1a + opt_w, y1a + opt_h)) pick = 0;
	else if (point_in_rectangle(mx, my, x1b, y1a, x1b + opt_w, y1a + opt_h)) pick = 1;
	else if (point_in_rectangle(mx, my, x1a, y1b, x1a + opt_w, y1b + opt_h)) pick = 2;
	else if (point_in_rectangle(mx, my, x1b, y1b, x1b + opt_w, y1b + opt_h)) pick = 3;
}

if (pick < 0) return;

var eid = global.quiz_enemy;
var ok = (pick == global.quiz_correct);

global.quiz_active = false;
global.quiz_enemy = noone;
global.quiz_cooldown = ok ? 28 : 60;

if (ok) {
	if (instance_exists(eid)) {
		global.quiz_face_x = eid.x;
	}
	global.quiz_pending_attack = true;
	if (variable_global_exists("score")) {
		global.score += 10;
	}
	if (instance_exists(eid)) {
		instance_destroy(eid);
	}
} else {
	with (obj_character) {
		hp -= 22;
		if (hp <= 0) {
			hp = 0;
			dead = true;
			hurt_timer = 0;
			global.game_over = true;
		} else {
			hurt_timer = 52;
		}
		global.hp = hp;
	}
}
