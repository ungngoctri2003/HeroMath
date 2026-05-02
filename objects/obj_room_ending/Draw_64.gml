// UI overlay — luon ve tren obj_congchua
var _w = display_get_gui_width();
var _h = display_get_gui_height();
if (_w < 8) {
	_w = room_width;
	_h = room_height;
}

var _t = ending_tw;
var _px = _w * 0.5;
var _py = _h * 0.13;
var _pw = min(640, _w - 48);
var _ph = 138;
var x1 = _px - _pw * 0.5;
var y1 = _py - _ph * 0.5;
var x2 = _px + _pw * 0.5;
var y2 = _py + _ph * 0.5;
var rad = 22;

draw_set_circle_precision(28);

// Bong khung
draw_set_alpha(0.22);
draw_set_color(c_black);
draw_roundrect_colour_ext(x1 + 10, y1 + 12, x2 + 10, y2 + 12, rad, rad, c_black, c_black, false);
draw_set_alpha(1);

var _gold_l = make_color_rgb(255, 244, 198);
var _gold_d = make_color_rgb(230, 196, 130);
draw_roundrect_colour_ext(x1, y1, x2, y2, rad, rad, _gold_l, _gold_d, false);
draw_roundrect_colour_ext(x1, y1, x2, y2, rad, rad,
	make_color_rgb(140, 72, 148), make_color_rgb(88, 42, 108), true);

draw_set_halign(fa_center);
draw_set_valign(fa_middle);
if (global.font_start_vn != -1) {
	draw_set_font(global.font_start_vn);
}

// Tieu de chinh
draw_set_color(make_color_rgb(48, 32, 72));
draw_text_transformed(_px + 3, _py - 42 + 3, "Chúc mừng!", 1.95, 1.95, -2);
draw_set_color(make_color_rgb(130, 68, 168));
draw_text_transformed(_px, _py - 38, "Chúc mừng!", 1.95, 1.95, -2);

// Phu de — giai cuu cong chua
draw_set_color(make_color_rgb(72, 48, 92));
draw_text_transformed(_px, _py + 18, "Bạn đã giải cứu được công chúa!", 1.12, 1.12, 0);

var _sc = variable_global_exists("score") ? string(global.score) : "0";
draw_set_color(make_color_rgb(118, 86, 58));
draw_text_transformed(_px, _py + 56, "Điểm: " + _sc, 0.88, 0.88, 0);

// Nut tro ve
var bx1 = _px - min(150, (_w * 0.22));
var bx2 = _px + min(150, (_w * 0.22));
if (bx2 - bx1 > _w - 24) {
	bx1 = 12;
	bx2 = _w - 12;
}
var by1 = _h * 0.88 - 36;
var by2 = _h * 0.88 + 32;
var br = 18;
var glow = 0.82 + 0.18 * sin(_t * 3.8);
var col_o = make_color_rgb(132, 210, 118);
var col_e = make_color_rgb(58, 132, 72);
if (btn_hover) {
	col_o = make_color_rgb(168, 238, 150);
	col_e = make_color_rgb(72, 168, 92);
}
draw_set_alpha(glow * 0.28);
draw_set_color(make_color_rgb(255, 255, 200));
draw_roundrect_colour_ext(bx1 - 6, by1 - 4, bx2 + 6, by2 + 8, br + 4, br + 4, c_white, c_white, false);
draw_set_alpha(1);
draw_roundrect_colour_ext(bx1, by1, bx2, by2, br, br, col_o, col_o, false);
draw_roundrect_colour_ext(bx1, by1, bx2, by2, br, br, col_e, col_e, true);
draw_set_color(c_white);
draw_text_transformed(_px, by1 + 30, "VỀ MENU (Space)", 1.05, 1.05, 0);

draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_font(-1);
