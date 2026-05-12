pregame_tw = current_time * 0.001;

var _w = display_get_gui_width();
var _h = display_get_gui_height();
if (_w < 8) {
	_w = room_width;
	_h = room_height;
}

var _px = _w * 0.5;

var _btn_half = min(235, floor(_w * 0.5 - 20));
if (_btn_half < 128) {
	_btn_half = max(96, floor(_w * 0.5 - 14));
}
var bx1 = _px - _btn_half;
var bx2 = _px + _btn_half;
if (bx2 - bx1 > _w - 24) {
	bx1 = 12;
	bx2 = _w - 12;
}
var _bcy = _h * 0.87;
var by1 = _bcy - 28;
var by2 = _bcy + 28;

var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);
btn_hover = point_in_rectangle(mx, my, bx1, by1, bx2, by2);

var _go = keyboard_check_pressed(vk_space);
if (!_go && mouse_check_button_pressed(mb_left)) {
	_go = btn_hover;
}

if (_go) {
	if (room == RoomIntro) {
		room_goto(RoomHowToPlay);
	} else if (room == RoomHowToPlay) {
		room_goto(RoomStory);
	} else if (room == RoomStory) {
		room_goto(Room1);
	}
}
