title_tw = current_time * 0.001;

var _w = room_width;
var _h = room_height;
var mx = device_mouse_x(0);
var my = device_mouse_y(0);
btn_hover = point_in_rectangle(mx, my, btn_x1, btn_y1, btn_x2, btn_y2);

var _go = keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space);
if (!_go && mouse_check_button_pressed(mb_left)) {
	_go = btn_hover || point_in_rectangle(mx, my, panel_x1, panel_y1, panel_x2, panel_y2);
}

if (_go) {
	room_goto(Room1);
}
