// Nền spr_backgroud_start. UI màn start — thẻ cao cấp + CTA
var _w = room_width;
var _h = room_height;
var _t = title_tw;

var _px = _w * 0.5;
var _py = _h * 0.36;
var _pw = min(620, _w - 64);
var _ph = 248;
var x1 = _px - _pw * 0.5;
var y1 = _py - _ph * 0.5;
var x2 = _px + _pw * 0.5;
var y2 = _py + _ph * 0.5;
var rad = 28;

// Bóng nhiều lớp
var s;
for (s = 4; s >= 1; s--) {
	draw_set_alpha(0.07 * (5 - s));
	draw_set_color(c_black);
	draw_roundrect_ext(x1 + s * 3, y1 + s * 3, x2 + s * 3, y2 + s * 3, rad + s, rad + s, false);
}
draw_set_alpha(1);

draw_set_color(make_color_rgb(8, 10, 22));
draw_roundrect_ext(x1 - 1, y1 - 1, x2 + 1, y2 + 1, rad + 1, rad + 1, true);

draw_set_alpha(0.12);
draw_set_color(c_white);
draw_roundrect_ext(x1, y1, x2, y2, rad, rad, false);
draw_set_alpha(0.14);
draw_roundrect_ext(x1, y1, x2, y2, rad, rad, false);
draw_set_alpha(1);

draw_roundrect_colour_ext(x1, y1, x2, y2, rad, rad,
	make_color_rgb(255, 254, 252), make_color_rgb(244, 238, 228), false);

draw_set_alpha(0.22);
draw_set_color(c_white);
draw_roundrect_ext(x1 + 6, y1 + 5, x2 - 6, y1 + 72, rad - 5, rad - 5, false);
draw_set_alpha(1);

draw_roundrect_colour_ext(x1, y1, x2, y2, rad, rad,
	make_color_rgb(36, 48, 82), make_color_rgb(234, 88, 12), true);
draw_set_alpha(0.58);
draw_set_color(make_color_rgb(255, 255, 255));
draw_roundrect_ext(x1 + 2, y1 + 2, x2 - 2, y2 - 2, rad - 3, rad - 3, true);
draw_set_alpha(1);

draw_roundrect_colour_ext(x1 + 16, y1 + 10, x2 - 16, y1 + 13, 2, 2,
	make_color_rgb(125, 211, 252), make_color_rgb(14, 165, 233), false);

// Góc trang trí (hình thoi nhỏ)
draw_set_alpha(0.55);
draw_set_color(make_color_rgb(251, 191, 36));
var d = 7;
draw_triangle(x1 + 22, y1 + 22 - d, x1 + 22 - d, y1 + 22, x1 + 22 + d, y1 + 22, false);
draw_triangle(x2 - 22, y1 + 22 - d, x2 - 22 - d, y1 + 22, x2 - 22 + d, y1 + 22, false);
draw_triangle(x1 + 22, y2 - 22 + d, x1 + 22 - d, y2 - 22, x1 + 22 + d, y2 - 22, false);
draw_triangle(x2 - 22, y2 - 22 + d, x2 - 22 - d, y2 - 22, x2 - 22 + d, y2 - 22, false);
draw_set_alpha(1);

draw_set_halign(fa_center);
draw_set_valign(fa_middle);
if (global.font_start_vn != -1) {
	draw_set_font(global.font_start_vn);
}

var _tit = "Anh hùng toán học";
var _tit_scale = 1.92;
var _ty = _py - 46;
var _tit_h = string_height(_tit) * _tit_scale;

// Gạch trang trí — đặt phía trên mép chữ, tránh chồng lên tiêu đề
var line_w = min(280, _pw - 120);
var lx1 = _px - line_w * 0.5;
var line_gap = 12;
var line_th = 3;
var ly = _ty - _tit_h * 0.5 - line_gap - line_th;
draw_set_alpha(0.9);
draw_rectangle_color(lx1, ly, _px, ly + line_th,
	make_color_rgb(14, 165, 233), make_color_rgb(56, 189, 248),
	make_color_rgb(56, 189, 248), make_color_rgb(14, 165, 233), false);
draw_rectangle_color(_px, ly, lx1 + line_w, ly + line_th,
	make_color_rgb(56, 189, 248), make_color_rgb(14, 165, 233),
	make_color_rgb(14, 165, 233), make_color_rgb(56, 189, 248), false);
draw_set_alpha(1);

draw_set_color(make_color_rgb(8, 16, 40));
draw_text_transformed(_px + 3, _ty + 4, _tit, _tit_scale, _tit_scale, 0);
draw_set_color(make_color_rgb(30, 58, 120));
draw_text_transformed(_px + 1, _ty + 1, _tit, _tit_scale, _tit_scale, 0);
draw_set_color(make_color_rgb(56, 189, 248));
draw_text_transformed(_px, _ty, _tit, _tit_scale, _tit_scale, 0);

// Subtitle trong chip (cao theo số dòng, không cố định 44px)
var _sub = "Tiêu diệt quái thú - Game anh hùng giải cứu công chúa";
var sub_w = min(480, _pw - 48);
var sub_x1 = _px - sub_w * 0.5;
var sub_y1 = _py + 18;
var _sub_inner = sub_w - 28;
var _sub_pad_v = 14;
var _sub_txt_h = string_height_ext(_sub, -1, _sub_inner);
var sub_y2 = sub_y1 + max(48, _sub_txt_h + _sub_pad_v * 2);
draw_set_alpha(0.35);
draw_set_color(c_black);
draw_roundrect_ext(sub_x1 + 2, sub_y1 + 2, sub_x1 + sub_w + 2, sub_y2 + 2, 14, 14, false);
draw_set_alpha(1);
draw_roundrect_colour_ext(sub_x1, sub_y1, sub_x1 + sub_w, sub_y2, 14, 14,
	make_color_rgb(248, 250, 252), make_color_rgb(226, 232, 240), false);
draw_set_color(make_color_rgb(100, 116, 139));
draw_roundrect_ext(sub_x1, sub_y1, sub_x1 + sub_w, sub_y2, 14, 14, true);

draw_set_color(make_color_rgb(255, 255, 255));
draw_set_valign(fa_middle);
draw_text_ext(_px + 1, (sub_y1 + sub_y2) * 0.5 + 1, _sub, -1, _sub_inner);
draw_set_color(make_color_rgb(51, 65, 85));
draw_text_ext(_px, (sub_y1 + sub_y2) * 0.5, _sub, -1, _sub_inner);

// Nút CHƠI NGAY
var bx1 = btn_x1;
var by1 = btn_y1;
var bx2 = btn_x2;
var by2 = btn_y2;
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
// Vạch bóng dưới (bevel)
draw_set_alpha(0.25);
draw_set_color(make_color_rgb(120, 40, 10));
draw_roundrect_ext(bx1 + 6, by2 - 12, bx2 - 6, by2 - 4, 10, 10, false);
draw_set_alpha(1);
draw_set_color(col_e);
draw_roundrect_ext(bx1, by1, bx2, by2, br, br, true);

var _btn_my = by1 + (by2 - by1) * 0.5;
var _btn = "CHƠI NGAY";
draw_set_color(make_color_rgb(40, 18, 6));
draw_text_transformed(_px + 2, _btn_my + 2, _btn, 1.34, 1.34, 0);
draw_set_color(make_color_rgb(120, 55, 20));
draw_text_transformed(_px + 1, _btn_my + 1, _btn, 1.34, 1.34, 0);
draw_set_color(make_color_rgb(255, 251, 235));
draw_text_transformed(_px, _btn_my, _btn, 1.34, 1.34, 0);

draw_set_halign(fa_left);
draw_set_valign(fa_top);
if (global.font_start_vn != -1) {
	draw_set_font(-1);
}
