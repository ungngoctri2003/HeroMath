ending_tw = current_time * 0.001;

var gw = display_get_gui_width();
var gh = display_get_gui_height();
if (gw < 8) {
	gw = room_width;
	gh = room_height;
}

var _px = gw * 0.5;
var _py = gh * 0.13;
var _pw = min(640, gw - 48);
var _ph = 138;
var panel_l = _px - _pw * 0.5;
var panel_t = _py - _ph * 0.5;
var panel_r = _px + _pw * 0.5;
var panel_b = _py + _ph * 0.5;

var bx1 = _px - 150 * (gw / max(1, room_width));
var bx2 = _px + 150 * (gw / max(1, room_width));
if (bx2 - bx1 > gw - 24) {
	bx1 = 12;
	bx2 = gw - 12;
}
var by1 = gh * 0.88 - 36;
var by2 = gh * 0.88 + 32;

var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);
btn_hover = point_in_rectangle(mx, my, bx1, by1, bx2, by2);

var _go = keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space);
if (!_go && mouse_check_button_pressed(mb_left)) {
	_go = btn_hover || point_in_rectangle(mx, my, panel_l, panel_t, panel_r, panel_b);
}

if (_go) {
	global.new_run_from_menu = true;
	global.quiz_active = false;
	global.quiz_enemy = noone;
	global.quiz_cooldown = 0;
	global.quiz_pending_attack = false;
	global.game_over = false;
	room_goto(RoomStart);
}
