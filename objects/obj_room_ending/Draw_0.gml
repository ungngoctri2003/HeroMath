// Hoang hon cung dien — nen canh, dong bo mau dapper voi obj_title
var _w = room_width;
var _h = room_height;
var _t = ending_tw;

draw_set_circle_precision(36);

// Troi hoang hon tim — vang
draw_rectangle_color(0, 0, _w, _h * 0.42,
	make_color_rgb(42, 32, 92), make_color_rgb(42, 32, 92),
	make_color_rgb(118, 58, 140), make_color_rgb(118, 58, 140), false);
draw_rectangle_color(0, _h * 0.32, _w, _h * 0.72,
	make_color_rgb(118, 58, 140), make_color_rgb(118, 58, 140),
	make_color_rgb(188, 86, 120), make_color_rgb(188, 86, 120), false);
draw_rectangle_color(0, _h * 0.58, _w, _h,
	make_color_rgb(188, 86, 120), make_color_rgb(188, 86, 120),
	make_color_rgb(92, 40, 72), make_color_rgb(92, 40, 72), false);

// Mat troi / hao quang sau lau dai
var _sx = _w * 0.78;
var _sy = _h * 0.22;
draw_set_alpha(0.35);
draw_set_color(make_color_rgb(255, 220, 140));
draw_circle(_sx, _sy, 120 + sin(_t * 1.2) * 8, false);
draw_set_alpha(0.55);
draw_set_color(make_color_rgb(255, 190, 90));
draw_circle(_sx, _sy, 72, false);
draw_set_alpha(1);

// Tia sang mem
draw_set_alpha(0.12);
draw_set_color(c_white);
for (var r = 0; r < 10; r++) {
	var ang = (r / 10) * 360 + _t * 14;
	draw_triangle(_sx, _sy,
		_sx + lengthdir_x(_h * 1.2, ang), _sy + lengthdir_y(_h * 1.2, ang),
		_sx + lengthdir_x(_h * 1.2, ang + 14), _sy + lengthdir_y(_h * 1.2, ang + 14),
		false);
}
draw_set_alpha(1);

// Cung dien xa — silhouette
draw_set_color(make_color_rgb(28, 18, 58));
draw_rectangle(0, _h * 0.38, _w * 0.38, _h * 0.62, false);
draw_triangle(_w * 0.05, _h * 0.38, _w * 0.15, _h * 0.22, _w * 0.28, _h * 0.38, false);
draw_triangle(_w * 0.22, _h * 0.38, _w * 0.32, _h * 0.18, _w * 0.42, _h * 0.38, false);

// Cot & vom trang tri (kenh phai — khu cong chua)
draw_set_color(make_color_rgb(55, 38, 88));
for (var c = 0; c < 5; c++) {
	var cx = _w * 0.56 + c * 72;
	var ch = 140 + (c mod 2) * 22;
	draw_rectangle(cx - 18, _h * 0.48 - ch, cx + 18, _h * 0.48, false);
	draw_roundrect_ext(cx - 32, _h * 0.48 - ch - 36, cx + 32, _h * 0.48 - ch + 6, 12, 12, false);
}

// San nhung do — tham
draw_set_color(make_color_rgb(120, 28, 58));
draw_rectangle(0, _h * 0.72, _w, _h, false);
draw_set_color(make_color_rgb(168, 42, 78));
draw_rectangle(0, _h * 0.72, _w, _h * 0.748, false);
draw_set_color(make_color_rgb(200, 158, 68));
for (var g = 0; g < 28; g++) {
	var gx = (g * 137 + _t * 18) mod (_w + 30) - 15;
	var gy = _h * 0.728;
	draw_line_width(gx, gy, gx + 8, gy + 10, 2);
}

// Vong sang chan chan cong chua (vi tri gan inst_RoomEnd_CongChua)
var _px = 930;
var _py = _h * 0.81;
draw_set_alpha(0.45);
draw_set_color(make_color_rgb(255, 235, 160));
draw_ellipse(_px - 140, _py - 28, _px + 140, _py + 38, false);
draw_set_alpha(0.22);
draw_set_color(make_color_rgb(255, 255, 255));
draw_ellipse(_px - 100, _py - 18, _px + 100, _py + 28, false);
draw_set_alpha(1);

// Hat vang bay
draw_set_color(make_color_rgb(255, 220, 100));
for (var p = 0; p < 32; p++) {
	var px = (p * 163 + _t * 35 + p * 19) mod (_w + 40) - 20;
	var py = _h * 0.25 + (p * 97) mod floor(_h * 0.55);
	var ps = 0.4 + 0.6 * abs(sin(_t * 3.1 + p * 0.7));
	draw_set_alpha(ps * 0.7);
	draw_circle(px, py, 2 + (p mod 2), false);
}
draw_set_alpha(1);

// Sao lap lanh
draw_set_color(c_white);
for (var s = 0; s < 24; s++) {
	var sx = (s * 113 + s * 31) mod _w;
	var sy = (s * 41) mod max(1, floor(_h * 0.38));
	var tw = 0.25 + 0.75 * abs(sin(_t * 2.4 + s * 0.9));
	draw_set_alpha(tw * 0.75);
	draw_circle(sx, sy, 1 + (s mod 2), false);
}
draw_set_alpha(1);

// Long lay goc man hinh
draw_set_alpha(0.18);
draw_rectangle_color(0, 0, 90, _h, c_white, c_white, c_black, c_black, false);
draw_rectangle_color(_w - 90, 0, _w, _h, c_white, c_black, c_black, c_white, false);
draw_set_alpha(1);
