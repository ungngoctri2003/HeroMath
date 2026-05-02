title_tw = current_time * 0.001;

var mx = device_mouse_x(0);
var my = device_mouse_y(0);
btn_hover = point_in_rectangle(mx, my, btn_x1, btn_y1, btn_x2, btn_y2);

var _go = keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space);
if (!_go && mouse_check_button_pressed(mb_left)) {
	_go = btn_hover;
}

if (_go) {
	global.score = 0;
	global.new_run_from_menu = true;
	global.quiz_active = false;
	global.quiz_enemy = noone;
	global.quiz_cooldown = 0;
	global.quiz_pending_attack = false;
	global.game_over = false;
	room_goto(Room1);
}
