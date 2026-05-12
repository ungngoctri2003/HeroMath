// Màn giới thiệu / hướng dẫn / cốt truyện — GUI, đồng bộ phong cách màn title & ending
var _w = display_get_gui_width();
var _h = display_get_gui_height();
if (_w < 8) {
	_w = room_width;
	_h = room_height;
}

var _t = pregame_tw;
var _px = _w * 0.5;
var _py = _h * 0.44;
var _pw = min(720, _w - 48);
var _ph = min(400, _h * 0.58);
var x1 = _px - _pw * 0.5;
var y1 = _py - _ph * 0.5;
var x2 = _px + _pw * 0.5;
var y2 = _py + _ph * 0.5;
var rad = 26;

var _head = "";
var _body = "";
if (room == RoomIntro) {
	_head = "Giới thiệu";
	_body = "Chào mừng bạn đến với Anh Hùng Toán Học – cuộc phiêu lưu nơi trí tuệ và lòng dũng cảm song hành!#"
		+ "Trong game, bạn sẽ hóa thân thành hoàng tử dũng cảm, vượt qua những cạm bẫy nguy hiểm, chiến đấu với quái vật và chinh phục các thử thách toán học đầy thú vị để mở ra con đường phía trước.#"
		+ "Mỗi màn chơi không chỉ đòi hỏi sự nhanh nhẹn mà còn cần khả năng tư duy và tính toán thông minh.#"
		+ "Hãy sẵn sàng bước vào hành trình vừa giải trí vừa rèn luyện trí não ngay bây giờ!";
} else if (room == RoomHowToPlay) {
	_head = "Cách chơi";
	_body = "• Phím trái / phải: di chuyển.#"
		+ "• Chuột trái hoặc phải: tấn công quái.#"
		+ "• Khi gặp quái: làm đúng phép toán để gây sát thương và tiếp tục. Nếu làm sai sẽ bị trừ máu.#"
		+ "• Bảo vệ thanh máu — nếu hết máu, bạn sẽ thua và có thể chơi lại từ đầu màn.#"
		+ "• Tiến hết các màn để tới đích cứu công chúa.";
} else if (room == RoomStory) {
	_head = "Cốt truyện";
	_body = "Tại một vương quốc yên bình, công chúa bất ngờ bị quái vật bắt cóc và đưa đến vùng đất bóng tối. Để giải cứu nàng, hoàng tử dũng cảm đã lên đường phiêu lưu qua nhiều thử thách nguy hiểm.#"
		+ "Trên hành trình ấy, hoàng tử phải chiến đấu với quái vật, vượt qua chướng ngại vật và giải các câu đố toán học để mở đường tiến về lâu đài cuối cùng. Liệu bạn có đủ trí tuệ và bản lĩnh để giúp hoàng tử cứu được công chúa?";
}

draw_set_circle_precision(32);

draw_set_alpha(0.12);
draw_rectangle_color(0, 0, _w, _h,
	make_color_rgb(8, 12, 28), make_color_rgb(8, 12, 28),
	make_color_rgb(20, 28, 48), make_color_rgb(20, 28, 48), false);
draw_set_alpha(1);

var s;
for (s = 3; s >= 1; s--) {
	draw_set_alpha(0.06 * (4 - s));
	draw_set_color(c_black);
	draw_roundrect_ext(x1 + s * 3, y1 + s * 3, x2 + s * 3, y2 + s * 3, rad + s, rad + s, false);
}
draw_set_alpha(1);

draw_set_color(make_color_rgb(8, 10, 22));
draw_roundrect_ext(x1 - 1, y1 - 1, x2 + 1, y2 + 1, rad + 1, rad + 1, true);

draw_set_alpha(0.1);
draw_set_color(c_white);
draw_roundrect_ext(x1, y1, x2, y2, rad, rad, false);
draw_set_alpha(1);

draw_roundrect_colour_ext(x1, y1, x2, y2, rad, rad,
	make_color_rgb(255, 254, 252), make_color_rgb(246, 242, 235), false);

draw_set_alpha(0.2);
draw_set_color(c_white);
draw_roundrect_ext(x1 + 8, y1 + 6, x2 - 8, y1 + 68, rad - 6, rad - 6, false);
draw_set_alpha(1);

draw_roundrect_colour_ext(x1, y1, x2, y2, rad, rad,
	make_color_rgb(36, 48, 82), make_color_rgb(210, 95, 20), true);
draw_set_alpha(0.5);
draw_set_color(c_white);
draw_roundrect_ext(x1 + 2, y1 + 2, x2 - 2, y2 - 2, rad - 3, rad - 3, true);
draw_set_alpha(1);

draw_roundrect_colour_ext(x1 + 14, y1 + 8, x2 - 14, y1 + 11, 2, 2,
	make_color_rgb(125, 211, 252), make_color_rgb(14, 165, 233), false);

draw_set_halign(fa_center);
draw_set_valign(fa_middle);
if (global.font_start_vn != -1) {
	draw_set_font(global.font_start_vn);
}

var _pulse = 1.35 + 0.04 * sin(_t * 3.2);
var _ty = y1 + 44;
draw_set_color(make_color_rgb(8, 16, 40));
draw_text_transformed(_px + 2, _ty + 3, _head, _pulse, _pulse, 0);
draw_set_color(make_color_rgb(30, 58, 120));
draw_text_transformed(_px + 1, _ty + 1, _head, _pulse, _pulse, 0);
draw_set_color(make_color_rgb(56, 189, 248));
draw_text_transformed(_px, _ty, _head, _pulse, _pulse, 0);

var _tw = _pw - 56;
var _body_left = (room == RoomHowToPlay);
var _tx = _body_left ? (x1 + 28) : _px;
var _ty_body = y1 + 96;
draw_set_halign(_body_left ? fa_left : fa_center);
draw_set_valign(fa_top);
var _f_body = (variable_global_exists("font_pregame_body") && global.font_pregame_body != -1)
	? global.font_pregame_body : global.font_start_vn;
if (_f_body != -1) {
	draw_set_font(_f_body);
}
var _sep = max(10, string_height("Ágjpq"));
draw_set_color(make_color_rgb(51, 65, 85));
// draw_text_ext không coi '#' là xuống dòng (khác draw_text cổ điển); dùng LF thật
var _body_wrapped = string_replace_all(_body, "#", chr(10));
draw_text_ext(_tx, _ty_body, _body_wrapped, _sep, _tw);

// —— Nút Tiếp ——
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
var br = 22;
var pulse = 0.88 + 0.12 * sin(_t * 3.2);
var col_o = make_color_rgb(251, 146, 60);
var col_i = make_color_rgb(234, 88, 12);
var col_e = make_color_rgb(124, 45, 18);
if (btn_hover) {
	col_o = make_color_rgb(253, 186, 116);
	col_i = make_color_rgb(251, 146, 60);
	col_e = make_color_rgb(154, 52, 18);
}

draw_set_alpha(0.25 * pulse);
draw_set_color(c_black);
draw_roundrect_ext(bx1 + 4, by1 + 6, bx2 + 4, by2 + 6, br + 2, br + 2, false);
draw_set_alpha(1);

draw_set_alpha(0.42 * pulse);
draw_set_color(make_color_rgb(254, 249, 195));
draw_roundrect_ext(bx1 - 8, by1 - 6, bx2 + 8, by2 + 10, br + 6, br + 6, false);
draw_set_alpha(1);

draw_roundrect_colour_ext(bx1, by1, bx2, by2, br, br, col_o, col_i, false);
draw_set_alpha(0.55);
draw_set_color(c_white);
draw_roundrect_ext(bx1 + 6, by1 + 4, bx2 - 6, by1 + 20, br - 4, br - 4, false);
draw_set_alpha(1);
draw_set_alpha(0.25);
draw_set_color(make_color_rgb(120, 40, 10));
draw_roundrect_ext(bx1 + 6, by2 - 12, bx2 - 6, by2 - 4, 10, 10, false);
draw_set_alpha(1);
draw_set_color(col_e);
draw_roundrect_ext(bx1, by1, bx2, by2, br, br, true);

draw_set_halign(fa_center);
draw_set_valign(fa_middle);

var _btn_label = (room == RoomStory) ? "Bắt đầu chơi (Space)" : "Tiếp (Space)";
var _btn_my = by1 + (by2 - by1) * 0.5;
var _bsc = 1.15;
var _inner_w = (bx2 - bx1) - 32;
if (global.font_start_vn != -1) {
	draw_set_font(global.font_start_vn);
}
var _tw0 = string_width(_btn_label);
if (_tw0 * _bsc > _inner_w) {
	_bsc = _inner_w / max(4, _tw0);
}
_bsc = clamp(_bsc, 0.75, 1.15);

draw_set_color(make_color_rgb(40, 18, 6));
draw_text_transformed(_px + 2, _btn_my + 2, _btn_label, _bsc, _bsc, 0);
draw_set_color(make_color_rgb(120, 55, 20));
draw_text_transformed(_px + 1, _btn_my + 1, _btn_label, _bsc, _bsc, 0);
draw_set_color(make_color_rgb(255, 251, 235));
draw_text_transformed(_px, _btn_my, _btn_label, _bsc, _bsc, 0);

draw_set_halign(fa_left);
draw_set_valign(fa_top);
if (global.font_start_vn != -1) {
	draw_set_font(-1);
}
