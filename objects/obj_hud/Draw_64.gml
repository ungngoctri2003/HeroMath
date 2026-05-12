/// Draw GUI — HUD cao cấp: HP, điểm, thời gian, game over
var gw = display_get_gui_width();
var gh = display_get_gui_height();
var pad_o = 22;
var panel_h = 82;
var r = 20;
var x1 = pad_o;
var y1 = 14;
var x2 = gw - pad_o;
var y2 = y1 + panel_h;

draw_set_circle_precision(48);

// Glow nhẹ sau panel
draw_set_alpha(0.14);
draw_set_color(make_color_rgb(56, 189, 248));
draw_roundrect_ext(x1 - 4, y1 - 2, x2 + 4, y2 + 12, r + 8, r + 8, false);
draw_set_alpha(1);

// Bóng
var s;
for (s = 3; s >= 1; s--) {
	draw_set_alpha(0.08 * (4 - s));
	draw_set_color(c_black);
	draw_roundrect_ext(x1 + s * 2, y1 + s * 2, x2 + s * 2, y2 + s * 2, r + 2, r + 2, false);
}
draw_set_alpha(1);

draw_set_color(make_color_rgb(10, 12, 24));
draw_roundrect_ext(x1 - 1, y1 - 1, x2 + 1, y2 + 1, r + 1, r + 1, true);

draw_roundrect_colour_ext(x1, y1, x2, y2, r, r,
	make_color_rgb(255, 254, 251), make_color_rgb(244, 239, 230), false);

draw_set_alpha(0.2);
draw_set_color(c_white);
draw_roundrect_ext(x1 + 5, y1 + 4, x2 - 5, y1 + 36, r - 4, r - 4, false);
draw_set_alpha(1);

draw_roundrect_colour_ext(x1, y1, x2, y2, r, r,
	make_color_rgb(30, 41, 70), make_color_rgb(217, 119, 6), true);
draw_set_alpha(0.5);
draw_set_color(c_white);
draw_roundrect_ext(x1 + 2, y1 + 2, x2 - 2, y2 - 2, r - 3, r - 3, true);
draw_set_alpha(1);

draw_roundrect_colour_ext(x1 + 14, y1 + 8, x2 - 14, y1 + 11, 2, 2,
	make_color_rgb(165, 243, 252), make_color_rgb(14, 165, 233), false);

var _hm = variable_global_exists("hp_max") ? global.hp_max : 100;
var _hp = variable_global_exists("hp") ? global.hp : _hm;
_hm = max(1, _hm);
_hp = clamp(_hp, 0, _hm);
var sc = variable_global_exists("score") ? global.score : 0;
var _hpf = _hp / _hm;

var _t0 = variable_global_exists("run_start_ms") ? global.run_start_ms : level_start_ms;
var elapsed = (current_time - _t0) / 1000;
var mm = floor(elapsed / 60);
var ss = floor(elapsed mod 60);
var sec_str = string(ss);
if (ss < 10) sec_str = "0" + sec_str;

var f = global.font_start_vn;
if (f != -1) draw_set_font(f);

var inner_l = x1 + 20;
var inner_r = x2 - 20;

// —— HP + tim trang trí ——
var hp_label_y = y1 + 14;
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(make_color_rgb(48, 52, 70));
draw_text_transformed(inner_l + 18, hp_label_y, "Máu", 0.76, 0.76, 0);

// Tim nhỏ
var hx = inner_l;
var hy = hp_label_y + 4;
draw_set_color(make_color_rgb(251, 113, 133));
draw_circle(hx + 4, hy + 2, 5, false);
draw_circle(hx + 10, hy + 2, 5, false);
draw_triangle(hx + 2, hy + 5, hx + 12, hy + 5, hx + 7, hy + 12, false);

var hp_label_h = string_height("Máu") * 0.76;
var bar_y = hp_label_y + hp_label_h + 6;
var hp_block_w = min(340, (inner_r - inner_l) * 0.4);
var bar_h = 22;
var bar_x1 = inner_l;
var bar_x2 = inner_l + hp_block_w;

draw_roundrect_colour_ext(bar_x1, bar_y, bar_x2, bar_y + bar_h, 10, 10,
	make_color_rgb(28, 24, 34), make_color_rgb(40, 34, 46), false);
draw_set_color(make_color_rgb(16, 14, 22));
draw_roundrect_ext(bar_x1, bar_y, bar_x2, bar_y + bar_h, 10, 10, true);

var fill_a = make_color_rgb(129, 230, 126);
var fill_b = make_color_rgb(34, 197, 94);
if (_hpf < 0.55) {
	fill_a = make_color_rgb(254, 240, 138);
	fill_b = make_color_rgb(245, 158, 11);
}
if (_hpf < 0.3) {
	fill_a = make_color_rgb(254, 202, 202);
	fill_b = make_color_rgb(220, 38, 38);
}
var pwidth = (bar_x2 - bar_x1 - 6) * _hpf;
if (pwidth > 2) {
	draw_roundrect_colour_ext(bar_x1 + 3, bar_y + 3, bar_x1 + 3 + pwidth, bar_y + bar_h - 3, 7, 7, fill_a, fill_b, false);
	draw_set_alpha(0.55);
	draw_set_color(c_white);
	draw_roundrect_ext(bar_x1 + 5, bar_y + 4, bar_x1 + 3 + pwidth - 2, bar_y + 9, 4, 4, false);
	draw_set_alpha(1);
}
draw_set_color(make_color_rgb(62, 56, 70));
draw_roundrect_ext(bar_x1, bar_y, bar_x2, bar_y + bar_h, 10, 10, true);

var hp_txt = string(floor(_hp)) + " / " + string(floor(_hm));
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
draw_text_transformed(bar_x2 + 11, bar_y + 2, hp_txt, 0.7, 0.7, 0);
draw_set_color(make_color_rgb(48, 52, 70));
draw_text_transformed(bar_x2 + 10, bar_y + 1, hp_txt, 0.7, 0.7, 0);

// —— Điểm ——
var cx = gw * 0.5;
var pill_w = min(240, gw * 0.24);
var pill_h = 44;
var py1 = y1 + (panel_h - pill_h) * 0.5;
var px1 = cx - pill_w * 0.5;
var px2 = cx + pill_w * 0.5;

draw_set_alpha(0.22);
draw_set_color(c_black);
draw_roundrect_ext(px1 + 3, py1 + 4, px2 + 3, py1 + pill_h + 4, pill_h * 0.5, pill_h * 0.5, false);
draw_set_alpha(1);

draw_roundrect_colour_ext(px1, py1, px2, py1 + pill_h, pill_h * 0.5, pill_h * 0.5,
	make_color_rgb(224, 242, 254), make_color_rgb(191, 219, 254), false);
draw_set_alpha(0.65);
draw_set_color(c_white);
draw_roundrect_ext(px1 + 5, py1 + 4, px2 - 5, py1 + 16, 12, 12, false);
draw_set_alpha(1);
draw_roundrect_colour_ext(px1, py1, px2, py1 + pill_h, pill_h * 0.5, pill_h * 0.5,
	make_color_rgb(14, 116, 175), make_color_rgb(3, 105, 161), true);
draw_set_alpha(0.45);
draw_set_color(make_color_rgb(186, 230, 253));
draw_roundrect_ext(px1 + 2, py1 + 2, px2 - 2, py1 + pill_h - 2, pill_h * 0.5 - 2, pill_h * 0.5 - 2, true);
draw_set_alpha(1);

var score_line_scale = 0.8;
var score_lbl = "ĐIỂM  ";
var score_val = string_upper(string(sc));
var w_lbl = string_width(score_lbl) * score_line_scale;
var w_val = string_width(score_val) * score_line_scale;
var score_row_y = py1 + pill_h * 0.5;
var score_x0 = cx - (w_lbl + w_val) * 0.5;

draw_set_halign(fa_left);
draw_set_valign(fa_middle);
draw_set_color(make_color_rgb(12, 42, 72));
draw_text_transformed(score_x0 + 1, score_row_y + 1, score_lbl, score_line_scale, score_line_scale, 0);
draw_set_color(make_color_rgb(241, 249, 255));
draw_text_transformed(score_x0, score_row_y, score_lbl, score_line_scale, score_line_scale, 0);

draw_set_color(make_color_rgb(10, 40, 70));
draw_text_transformed(score_x0 + w_lbl + 1, score_row_y + 1, score_val, score_line_scale * 1.14, score_line_scale * 1.14, 0);
draw_set_color(make_color_rgb(125, 211, 252));
draw_text_transformed(score_x0 + w_lbl, score_row_y, score_val, score_line_scale * 1.14, score_line_scale * 1.14, 0);

// —— Thời gian ——
draw_set_halign(fa_right);
draw_set_valign(fa_top);
var time_ty = y1 + 14;
draw_set_color(make_color_rgb(48, 52, 70));
draw_text_transformed(inner_r, time_ty, "Thời gian", 0.76, 0.76, 0);
var time_lbl_h = string_height("Thời gian") * 0.76;
var clock_y = time_ty + time_lbl_h + 5;
var twbox_w = 118;
var twbox_h = 38;
var tw_x2 = inner_r;
var tw_x1 = tw_x2 - twbox_w;

draw_roundrect_colour_ext(tw_x1, clock_y, tw_x2, clock_y + twbox_h, 12, 12,
	make_color_rgb(22, 26, 42), make_color_rgb(10, 12, 26), false);
draw_set_alpha(0.85);
draw_set_color(make_color_rgb(40, 48, 78));
draw_roundrect_ext(tw_x1, clock_y, tw_x2, clock_y + twbox_h, 12, 12, true);
draw_set_alpha(0.35);
draw_set_color(make_color_rgb(56, 189, 248));
draw_roundrect_ext(tw_x1 + 3, clock_y + 3, tw_x2 - 3, clock_y + 8, 8, 8, false);
draw_set_alpha(1);

var mm_str = string(mm);
if (mm < 10) mm_str = "0" + mm_str;
var time_str = mm_str + " : " + sec_str;
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(make_color_rgb(8, 18, 38));
draw_text_transformed(tw_x1 + twbox_w * 0.5 + 1, clock_y + twbox_h * 0.5 + 1, time_str, 1.08, 1.08, 0);
draw_set_color(make_color_rgb(165, 243, 252));
draw_text_transformed(tw_x1 + twbox_w * 0.5, clock_y + twbox_h * 0.5, time_str, 1.08, 1.08, 0);

draw_set_halign(fa_left);
draw_set_valign(fa_top);
if (f != -1) draw_set_font(-1);

// —— Game Over ——
if (variable_global_exists("game_over") && global.game_over) {
	draw_set_circle_precision(48);
	draw_set_alpha(0.82);
	draw_rectangle_color(0, 0, gw, gh,
		make_color_rgb(8, 10, 22), make_color_rgb(8, 10, 22),
		make_color_rgb(18, 10, 20), make_color_rgb(18, 10, 20), false);
	draw_set_alpha(1);

	var _cx = gw * 0.5;
	var _cy = gh * 0.48;
	var box_w = min(520, gw - 56);
	var box_h = 228;
	var bx1 = _cx - box_w * 0.5;
	var by1 = _cy - box_h * 0.5;
	var br = 26;

	draw_set_alpha(0.38);
	draw_set_color(c_black);
	draw_roundrect_ext(bx1 + 14, by1 + 18, bx1 + box_w + 14, by1 + box_h + 18, br + 2, br + 2, false);
	draw_set_alpha(1);

	draw_roundrect_colour_ext(bx1, by1, bx1 + box_w, by1 + box_h, br, br,
		make_color_rgb(255, 252, 248), make_color_rgb(238, 226, 220), false);
	draw_set_alpha(0.18);
	draw_set_color(c_white);
	draw_roundrect_ext(bx1 + 6, by1 + 5, bx1 + box_w - 6, by1 + 48, br - 4, br - 4, false);
	draw_set_alpha(1);
	draw_roundrect_colour_ext(bx1, by1, bx1 + box_w, by1 + box_h, br, br,
		make_color_rgb(190, 24, 24), make_color_rgb(115, 20, 26), true);
	draw_set_alpha(0.55);
	draw_set_color(c_white);
	draw_roundrect_ext(bx1 + 3, by1 + 3, bx1 + box_w - 3, by1 + box_h - 3, br - 4, br - 4, true);
	draw_set_alpha(1);

	if (f != -1) draw_set_font(f);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);

	var _go_y = by1 + 78;
	draw_set_color(make_color_rgb(40, 6, 6));
	draw_text_transformed(_cx + 3, _go_y + 3, "THUA CUỘC", 1.58, 1.58, 0);
	draw_set_color(make_color_rgb(120, 20, 24));
	draw_text_transformed(_cx + 1, _go_y + 1, "THUA CUỘC", 1.58, 1.58, 0);
	draw_set_color(make_color_rgb(255, 107, 107));
	draw_text_transformed(_cx, _go_y, "THUA CUỘC", 1.58, 1.58, 0);

	draw_set_color(make_color_rgb(60, 52, 50));
	draw_text_transformed(_cx + 1, by1 + 148 + 1, "Enter hoặc Space — chơi lại màn", 0.78, 0.78, 0);
	draw_set_color(make_color_rgb(252, 245, 240));
	draw_text_transformed(_cx, by1 + 148, "Enter hoặc Space — chơi lại màn", 0.78, 0.78, 0);

	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	if (f != -1) draw_set_font(-1);
}
