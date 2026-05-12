// Nen: spr_backgroud_start tren layer Background (RoomStart). Day chi ve UI.
var _w = room_width;
var _h = room_height;
var _t = title_tw;

// Khung tieu de
var _px = _w * 0.5;
var _py = _h * 0.36;
var _pw = 560;
var _ph = 210;
var x1 = _px - _pw * 0.5;
var y1 = _py - _ph * 0.5;
var x2 = _px + _pw * 0.5;
var y2 = _py + _ph * 0.5;
var rad = 24;

draw_set_alpha(0.2);
draw_set_color(c_black);
draw_roundrect_colour_ext(x1 + 10, y1 + 14, x2 + 10, y2 + 14, rad, rad, c_black, c_black, false);
draw_set_alpha(1);

var _cream = make_color_rgb(255, 251, 232);
var _cream_d = make_color_rgb(245, 230, 210);
draw_roundrect_colour_ext(x1, y1, x2, y2, rad, rad, _cream, _cream_d, false);
draw_roundrect_colour_ext(x1, y1, x2, y2, rad, rad, make_color_rgb(228, 118, 52), make_color_rgb(175, 78, 32), true);

draw_set_halign(fa_center);
draw_set_valign(fa_middle);
if (global.font_start_vn != -1) {
	draw_set_font(global.font_start_vn);
}
draw_set_color(make_color_rgb(82, 155, 235));
draw_text_transformed(_px, _py - 38, "Anh hùng toán học", 1.85, 1.85, 0);
draw_set_color(make_color_rgb(92, 82, 70));
draw_text_ext(_px, _py + 44, "Tiêu diệt quái thú & Giải cứu công chúa", -1, _pw - 48);

// Nut choi ngay
var bx1 = btn_x1;
var by1 = btn_y1;
var bx2 = btn_x2;
var by2 = btn_y2;
var br = 18;
var glow = 0.85 + 0.15 * sin(_t * 3.6);
var col_o = make_color_rgb(248, 152, 58);
var col_e = make_color_rgb(188, 86, 34);
if (btn_hover) {
	col_o = make_color_rgb(255, 188, 88);
	col_e = make_color_rgb(210, 112, 48);
}
draw_set_alpha(glow * 0.26);
draw_set_color(make_color_rgb(255, 230, 120));
draw_roundrect_colour_ext(bx1 - 5, by1 - 3, bx2 + 5, by2 + 6, br + 3, br + 3, c_white, c_white, false);
draw_set_alpha(1);
draw_roundrect_colour_ext(bx1, by1, bx2, by2, br, br, col_o, col_o, false);
draw_roundrect_colour_ext(bx1, by1, bx2, by2, br, br, col_e, col_e, true);
draw_set_color(c_white);
draw_text_transformed(_px, by1 + 29, "CHƠI NGAY", 1.28, 1.28, 0);

draw_set_halign(fa_left);
draw_set_valign(fa_top);
if (global.font_start_vn != -1) {
	draw_set_font(-1);
}
