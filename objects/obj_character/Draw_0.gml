draw_self();

if (room != RoomEnding || !ending_arrived) {
	exit;
}

var _cc = instance_nearest(x, y, obj_congchua);
if (_cc == noone) {
	exit;
}

var t = current_time * 0.001;
// Ngay trên đầu (bbox) — hai cụm riêng hoàng tử / công chúa
var _hero_hx = (bbox_left + bbox_right) * 0.5;
var _hero_hy = bbox_top - 4;
var _prin_hx = (_cc.bbox_left + _cc.bbox_right) * 0.5;
var _prin_hy = _cc.bbox_top - 4;

draw_set_circle_precision(24);

// Bay thấp: quãng bay ngắn, cụm hẹp quanh từng đầu
var _rise_max = 44;
var _spread = 11;

for (var i = 0; i < 6; i++) {
	var cyc = (t * 0.9 + i * 0.21) mod 1;
	var rise = cyc * _rise_max;
	var wob = sin(t * 3.4 + i * 1.1) * 5;
	var hxx = _hero_hx + wob + (i - 2.5) * _spread;
	var hyy = _hero_hy - rise + sin(t * 2.2 + i * 0.7) * 2;
	var sc = 0.36 + 0.22 * (1 - cyc);
	var al = 0.82 * (1 - power(cyc, 0.72));
	if (al < 0.05) continue;

	var rr = 12 * sc;
	draw_set_alpha(al);
	draw_set_color(make_color_rgb(255, 82, 128));
	draw_circle(hxx - rr * 0.38, hyy - rr * 0.22, rr * 0.48, false);
	draw_circle(hxx + rr * 0.38, hyy - rr * 0.22, rr * 0.48, false);
	draw_triangle(hxx - rr * 0.9, hyy + rr * 0.1, hxx + rr * 0.9, hyy + rr * 0.1, hxx, hyy + rr * 1.05, false);
	draw_set_alpha(al * 0.35);
	draw_set_color(c_white);
	draw_circle(hxx - rr * 0.32, hyy - rr * 0.28, rr * 0.2, false);
}

for (var j = 0; j < 6; j++) {
	var cyc2 = (t * 0.9 + j * 0.21 + 0.47) mod 1;
	var rise2 = cyc2 * _rise_max;
	var wob2 = sin(t * 3.4 + j * 1.1 + 1.7) * 5;
	var hxx2 = _prin_hx + wob2 + (j - 2.5) * _spread;
	var hyy2 = _prin_hy - rise2 + sin(t * 2.2 + j * 0.7 + 0.9) * 2;
	var sc2 = 0.36 + 0.22 * (1 - cyc2);
	var al2 = 0.82 * (1 - power(cyc2, 0.72));
	if (al2 < 0.05) continue;

	var rr2 = 12 * sc2;
	draw_set_alpha(al2);
	draw_set_color(make_color_rgb(255, 82, 128));
	draw_circle(hxx2 - rr2 * 0.38, hyy2 - rr2 * 0.22, rr2 * 0.48, false);
	draw_circle(hxx2 + rr2 * 0.38, hyy2 - rr2 * 0.22, rr2 * 0.48, false);
	draw_triangle(hxx2 - rr2 * 0.9, hyy2 + rr2 * 0.1, hxx2 + rr2 * 0.9, hyy2 + rr2 * 0.1, hxx2, hyy2 + rr2 * 1.05, false);
	draw_set_alpha(al2 * 0.35);
	draw_set_color(c_white);
	draw_circle(hxx2 - rr2 * 0.32, hyy2 - rr2 * 0.28, rr2 * 0.2, false);
}

draw_set_alpha(1);
draw_set_color(c_white);
