// GUI kết thúc — cùng phong cách thẻ kem + navy + cyan như màn title (obj_title)
var _w = display_get_gui_width();
var _h = display_get_gui_height();
if (_w < 8) {
	_w = room_width;
	_h = room_height;
}

var _t = ending_tw;
var _px = _w * 0.5;
var _py = _h * 0.125;
var _pw = min(640, _w - 56);
var _ph = 172;
var x1 = _px - _pw * 0.5;
var y1 = _py - _ph * 0.5;
var x2 = _px + _pw * 0.5;
var y2 = _py + _ph * 0.5;
var rad = 26;

draw_set_circle_precision(32);

// Nền vignette rất nhẹ phía trên (không chói)
draw_set_alpha(0.14);
draw_rectangle_color(0, 0, _w, y2 + 40,
	make_color_rgb(8, 12, 28), make_color_rgb(8, 12, 28),
	make_color_rgb(28, 36, 52), make_color_rgb(28, 36, 52), false);
draw_set_alpha(1);

// Bóng thẻ (mềm, ít lớp)
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
draw_roundrect_ext(x1 + 8, y1 + 6, x2 - 8, y1 + 56, rad - 6, rad - 6, false);
draw_set_alpha(1);

draw_roundrect_colour_ext(x1, y1, x2, y2, rad, rad,
	make_color_rgb(36, 48, 82), make_color_rgb(210, 95, 20), true);
draw_set_alpha(0.5);
draw_set_color(c_white);
draw_roundrect_ext(x1 + 2, y1 + 2, x2 - 2, y2 - 2, rad - 3, rad - 3, true);
draw_set_alpha(1);

// Sọc accent (cùng dòng title)
draw_roundrect_colour_ext(x1 + 14, y1 + 8, x2 - 14, y1 + 11, 2, 2,
	make_color_rgb(125, 211, 252), make_color_rgb(14, 165, 233), false);

draw_set_halign(fa_center);
draw_set_valign(fa_middle);
if (global.font_start_vn != -1) {
	draw_set_font(global.font_start_vn);
}

var _title = "Chúc mừng!";
var _victory = "Chiến thắng!";
var _sub = "Bạn đã giải cứu thành công — công chúa an toàn.";
var _pulse = 1.52 + 0.04 * sin(_t * 3.2);

var _ty1 = _py - 48;
var _ty2 = _py - 6;
var _ty3 = _py + 30;
var _ty4 = _py + 64;

// Tiêu đề: 3 lớp giống title screen (dễ đọc, không nghiêng mạnh)
draw_set_color(make_color_rgb(8, 16, 40));
draw_text_transformed(_px + 2, _ty1 + 3, _title, _pulse, _pulse, 0);
draw_set_color(make_color_rgb(30, 58, 120));
draw_text_transformed(_px + 1, _ty1 + 1, _title, _pulse, _pulse, 0);
draw_set_color(make_color_rgb(56, 189, 248));
draw_text_transformed(_px, _ty1, _title, _pulse, _pulse, 0);

// Dòng chiến thắng — vàng cam ấm, viền tối (không cầu vồng)
var _sv = 1.02 + 0.04 * sin(_t * 3.6);
draw_set_color(make_color_rgb(60, 28, 8));
draw_text_transformed(_px + 1, _ty2 + 1, _victory, _sv, _sv, 0);
draw_set_color(make_color_rgb(253, 186, 116));
draw_text_transformed(_px, _ty2, _victory, _sv, _sv, 0);

// Gạch mảnh dưới dòng chiến thắng
var _lw = min(280, _pw - 120);
var _lx = _px - _lw * 0.5;
var _lyl = _ty2 + 20;
draw_set_alpha(0.85);
draw_rectangle_color(_lx, _lyl, _lx + _lw * 0.5, _lyl + 2,
	make_color_rgb(14, 165, 233), make_color_rgb(56, 189, 248),
	make_color_rgb(56, 189, 248), make_color_rgb(14, 165, 233), false);
draw_rectangle_color(_lx + _lw * 0.5, _lyl, _lx + _lw, _lyl + 2,
	make_color_rgb(56, 189, 248), make_color_rgb(14, 165, 233),
	make_color_rgb(14, 165, 233), make_color_rgb(56, 189, 248), false);
draw_set_alpha(1);

// Phụ đề: xám chì (đồng bộ HUD), không tím
draw_set_color(make_color_rgb(51, 65, 85));
draw_text_transformed(_px, _ty3, _sub, 0.88, 0.88, 0);

var _sc = variable_global_exists("score") ? string(global.score) : "0";
var _score_str = "Điểm  " + _sc;
draw_set_color(make_color_rgb(120, 53, 15));
draw_text_transformed(_px + 1, _ty4 + 1, _score_str, 0.92, 0.92, 0);
draw_set_color(make_color_rgb(180, 120, 48));
draw_text_transformed(_px, _ty4, _score_str, 0.92, 0.92, 0);

// —— Nút VỀ MENU —— (cùng style nút CHƠI NGAY màn title)
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

var _btn_my = by1 + (by2 - by1) * 0.5;
var _btn = "VỀ MENU (Space)";
var _bsc = 1.22;
var _inner_w = (bx2 - bx1) - 32;
if (global.font_start_vn != -1) {
	var _tw0 = string_width(_btn);
	if (_tw0 * _bsc > _inner_w) {
		_bsc = _inner_w / max(4, _tw0);
	}
}
_bsc = clamp(_bsc, 0.82, 1.22);

draw_set_color(make_color_rgb(40, 18, 6));
draw_text_transformed(_px + 2, _btn_my + 2, _btn, _bsc, _bsc, 0);
draw_set_color(make_color_rgb(120, 55, 20));
draw_text_transformed(_px + 1, _btn_my + 1, _btn, _bsc, _bsc, 0);
draw_set_color(make_color_rgb(255, 251, 235));
draw_text_transformed(_px, _btn_my, _btn, _bsc, _bsc, 0);

draw_set_halign(fa_left);
draw_set_valign(fa_top);
if (global.font_start_vn != -1) {
	draw_set_font(-1);
}
