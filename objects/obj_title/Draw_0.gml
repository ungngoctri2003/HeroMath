// Ve canh & UI phong cach Kenney (platformer vector pack trong du an)
var _w = room_width;
var _h = room_height;
var _t = title_tw;

draw_set_circle_precision(28);

// Troi
draw_rectangle_color(0, 0, _w, _h * 0.55,
	make_color_rgb(120, 195, 245), make_color_rgb(120, 195, 245),
	make_color_rgb(175, 228, 252), make_color_rgb(175, 228, 252), false);
draw_rectangle_color(0, _h * 0.42, _w, _h * 0.76,
	make_color_rgb(175, 228, 252), make_color_rgb(175, 228, 252),
	make_color_rgb(210, 240, 252), make_color_rgb(210, 240, 252), false);

// Doi xa
draw_set_color(make_color_rgb(105, 178, 118));
draw_triangle(-80, _h + 50, _w * 0.35, _h * 0.56, _w * 0.62, _h + 50, false);
draw_triangle(_w * 0.28, _h + 50, _w * 0.68, _h * 0.52, _w + 120, _h + 50, false);

draw_set_color(make_color_rgb(82, 158, 92));
draw_triangle(-120, _h + 50, _w * 0.42, _h * 0.64, _w * 0.82, _h + 50, false);

// Tham co
draw_set_color(make_color_rgb(92, 188, 82));
draw_rectangle(0, _h * .76, _w, _h, false);
draw_set_color(make_color_rgb(118, 212, 98));
draw_rectangle(0, _h * .76, _w, _h * .805, false);
draw_set_color(make_color_rgb(68, 148, 65));
for (var g = 0; g < 40; g++) {
	var gx = (g * 131 + _t * 28) mod (_w + 24) - 12;
	var gy = _h * 0.762;
	draw_triangle(gx, gy + 12, gx + 5, gy, gx + 10, gy + 12, false);
}

// May
draw_set_alpha(0.94);
draw_set_color(c_white);
for (var c = 0; c < 6; c++) {
	var cx = (c * 265 + sin(_t * 0.75 + c * 1.1) * 38 + _t * 22 + c * 44) mod (_w + 140) - 70;
	var cy = 26 + (c mod 3) * 20;
	draw_circle(cx, cy, 28, false);
	draw_circle(cx + 34, cy + 7, 36, false);
	draw_circle(cx + 74, cy, 30, false);
	draw_circle(cx + 30, cy - 11, 22, false);
}
draw_set_alpha(1);

// Dong xu trang tri
for (var u = 0; u < 6; u++) {
	var ox = 110 + u * 210;
	var oy = _h * 0.51 + sin(_t * 2 + u * 0.7) * 7;
	var bob = sin(_t * 2.8 + u * 1.2) * 4;
	draw_set_color(make_color_rgb(235, 188, 45));
	draw_circle(ox + bob, oy, 17, false);
	draw_set_color(make_color_rgb(255, 238, 130));
	draw_circle(ox + bob - 4, oy - 4, 6, false);
	draw_set_color(make_color_rgb(195, 135, 28));
	draw_circle(ox + bob, oy, 17, true);
}

// Sao
draw_set_color(c_white);
for (var s = 0; s < 18; s++) {
	var sx = (s * 101 + s * 17) mod _w;
	var sy = (s * 47) mod max(1, floor(_h * 0.38));
	var tw = 0.35 + 0.65 * abs(sin(_t * 2.8 + s));
	draw_set_alpha(tw * 0.8);
	draw_circle(sx, sy, 1 + (s mod 3), false);
}
draw_set_alpha(1);

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
