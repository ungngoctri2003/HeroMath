/// Draw GUI — HUD đồng bộ phong cách title (Kenney / cream–cam)
var gw = display_get_gui_width();
var pad_o = 14;
var panel_h = 70;
var r = 14;
var x1 = pad_o;
var y1 = 10;
var x2 = gw - pad_o;
var y2 = y1 + panel_h;

draw_set_circle_precision(28);

// Đổ bóng nhẹ
draw_set_alpha(0.22);
draw_set_color(c_black);
draw_roundrect_ext(x1 + 3, y1 + 4, x2 + 3, y2 + 4, r, r, false);
draw_set_alpha(1);

// Nền panel
var _crm = make_color_rgb(255, 251, 236);
var _crm2 = make_color_rgb(248, 238, 218);
draw_roundrect_colour_ext(x1, y1, x2, y2, r, r, _crm, _crm2, false);
draw_roundrect_colour_ext(x1, y1, x2, y2, r, r, make_color_rgb(232, 118, 54), make_color_rgb(176, 82, 34), true);

// Viền trong sáng
draw_set_alpha(0.35);
draw_set_color(c_white);
draw_roundrect_ext(x1 + 3, y1 + 3, x2 - 3, y2 - 3, r - 3, r - 3, true);
draw_set_alpha(1);

var _hm = variable_global_exists("hp_max") ? global.hp_max : 100;
var _hp = variable_global_exists("hp") ? global.hp : _hm;
_hm = max(1, _hm);
_hp = clamp(_hp, 0, _hm);
var sc = variable_global_exists("score") ? global.score : 0;

var elapsed = (current_time - level_start_ms) / 1000;
var mm = floor(elapsed / 60);
var ss = floor(elapsed mod 60);
var sec_str = string(ss);
if (ss < 10) sec_str = "0" + sec_str;

var f = global.font_start_vn;
if (f != -1) draw_set_font(f);

var inner_l = x1 + 16;
var inner_r = x2 - 16;

// —— Cột trái: Máu + thanh ——
var hp_label_y = y1 + 10;
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(make_color_rgb(88, 78, 92));
draw_text_transformed(inner_l, hp_label_y, "Máu (HP)", 0.72, 0.72, 0);
var hp_label_h = string_height("Máu (HP)") * 0.72;
var bar_y = hp_label_y + hp_label_h + 6;
var hp_block_w = min(340, (inner_r - inner_l) * 0.4);
var bar_h = 18;
var bar_x1 = inner_l;
var bar_x2 = inner_l + hp_block_w;

var track = make_color_rgb(48, 36, 42);
var fill_a = make_color_rgb(86, 196, 102);
var fill_b = make_color_rgb(58, 168, 90);
draw_roundrect_colour_ext(bar_x1, bar_y, bar_x2, bar_y + bar_h, 8, 8, track, track, false);
var pw = (bar_x2 - bar_x1) * (_hp / _hm);
if (pw > 2) {
	draw_roundrect_colour_ext(bar_x1 + 2, bar_y + 2, bar_x1 + pw - 2, bar_y + bar_h - 2, 6, 6, fill_a, fill_b, false);
	draw_set_alpha(0.45);
	draw_set_color(c_white);
	draw_roundrect_ext(bar_x1 + 4, bar_y + 3, bar_x1 + pw - 4, bar_y + 6, 4, 4, false);
	draw_set_alpha(1);
}
draw_set_color(make_color_rgb(120, 72, 48));
draw_roundrect_ext(bar_x1, bar_y, bar_x2, bar_y + bar_h, 8, 8, true);

var hp_txt = string(floor(_hp)) + " / " + string(floor(_hm));
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(make_color_rgb(66, 58, 72));
draw_text_transformed(bar_x2 + 8, bar_y + 1, hp_txt, 0.68, 0.68, 0);

// —— Giữa: Điểm số (một hàng) trong “pill” ——
var cx = gw * 0.5;
var pill_w = 200;
var pill_h = 38;
var py1 = y1 + (panel_h - pill_h) * 0.5;
var px1 = cx - pill_w * 0.5;
var px2 = cx + pill_w * 0.5;
draw_set_alpha(0.12);
draw_set_color(make_color_rgb(82, 155, 235));
draw_roundrect_ext(px1, py1, px2, py1 + pill_h, pill_h * 0.5, pill_h * 0.5, false);
draw_set_alpha(1);
draw_roundrect_colour_ext(px1, py1, px2, py1 + pill_h, pill_h * 0.5, pill_h * 0.5,
	make_color_rgb(235, 244, 255), make_color_rgb(214, 232, 252), false);
draw_roundrect_ext(px1, py1, px2, py1 + pill_h, pill_h * 0.5, pill_h * 0.5, true);

var score_line_scale = 0.82;
var score_lbl = "Điểm số: ";
var score_val = string(sc);
var w_lbl = string_width(score_lbl) * score_line_scale;
var w_val = string_width(score_val) * score_line_scale;
var score_row_y = py1 + pill_h * 0.5;
var score_x0 = cx - (w_lbl + w_val) * 0.5;

draw_set_halign(fa_left);
draw_set_valign(fa_middle);
draw_set_color(make_color_rgb(72, 64, 78));
draw_text_transformed(score_x0, score_row_y, score_lbl, score_line_scale, score_line_scale, 0);
draw_set_color(make_color_rgb(42, 118, 188));
draw_text_transformed(score_x0 + w_lbl, score_row_y, score_val, score_line_scale, score_line_scale, 0);

// —— Phải: Thời gian ——
draw_set_halign(fa_right);
draw_set_valign(fa_top);
var time_lbl_scale = 0.72;
var time_val_scale = 1.02;
var time_ty = y1 + 10;
draw_set_color(make_color_rgb(88, 78, 92));
draw_text_transformed(inner_r, time_ty, "Thời gian", time_lbl_scale, time_lbl_scale, 0);
var time_lbl_h = string_height("Thời gian") * time_lbl_scale;
var time_vy = time_ty + time_lbl_h + 5;

var mm_str = string(mm);
if (mm < 10) mm_str = "0" + mm_str;
var time_str = mm_str + ":" + sec_str;
draw_set_color(make_color_rgb(188, 92, 48));
draw_text_transformed(inner_r, time_vy, time_str, time_val_scale, time_val_scale, 0);

draw_set_halign(fa_left);
draw_set_valign(fa_top);
if (f != -1) draw_set_font(-1);

// —— Game Over (vẽ trên cùng) ——
if (variable_global_exists("game_over") && global.game_over) {
	draw_set_circle_precision(28);
	draw_set_alpha(0.72);
	draw_set_color(make_color_rgb(16, 12, 28));
	draw_rectangle(0, 0, gw, display_get_gui_height(), false);
	draw_set_alpha(1);

	var gh = display_get_gui_height();
	var _cx = gw * 0.5;
	var _cy = gh * 0.48;
	var box_w = min(520, gw - 40);
	var box_h = 200;
	var bx1 = _cx - box_w * 0.5;
	var by1 = _cy - box_h * 0.5;
	var br = 20;

	draw_set_alpha(0.25);
	draw_set_color(c_black);
	draw_roundrect_ext(bx1 + 8, by1 + 10, bx1 + box_w + 8, by1 + box_h + 10, br, br, false);
	draw_set_alpha(1);

	var c0 = make_color_rgb(255, 248, 236);
	var c1 = make_color_rgb(236, 220, 200);
	draw_roundrect_colour_ext(bx1, by1, bx1 + box_w, by1 + box_h, br, br, c0, c1, false);
	draw_roundrect_colour_ext(bx1, by1, bx1 + box_w, by1 + box_h, br, br,
		make_color_rgb(220, 96, 72), make_color_rgb(150, 52, 40), true);

	if (f != -1) draw_set_font(f);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_set_color(make_color_rgb(72, 28, 24));
	draw_text_transformed(_cx + 2, by1 + 68 + 2, "THUA CUỘC", 1.45, 1.45, 0);
	draw_set_color(make_color_rgb(230, 74, 58));
	draw_text_transformed(_cx, by1 + 66, "THUA CUỘC", 1.45, 1.45, 0);

	draw_set_color(make_color_rgb(88, 72, 68));
	draw_text_transformed(_cx, by1 + 128, "Enter hoặc Space — chơi lại màn", 0.78, 0.78, 0);

	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	if (f != -1) draw_set_font(-1);
}
