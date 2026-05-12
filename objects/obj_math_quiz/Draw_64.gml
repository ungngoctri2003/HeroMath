/// Draw GUI — popup câu hỏi (UI nâng cao; layout trùng Step_0)
if (!variable_global_exists("quiz_active") || !global.quiz_active) return;
if (variable_global_exists("game_over") && global.game_over) return;

var gw = display_get_gui_width();
var gh = display_get_gui_height();
var f = global.font_start_vn;
if (f != -1) draw_set_font(f);

draw_set_circle_precision(48);

// —— Nền: gradient + vignette + điểm sáng ——
draw_set_alpha(0.72);
draw_rectangle_color(0, 0, gw, gh,
	make_color_rgb(20, 24, 48), make_color_rgb(18, 22, 44),
	make_color_rgb(12, 14, 32), make_color_rgb(14, 18, 40), false);
draw_set_alpha(0.55);
draw_circle_color(gw * 0.5, gh * 0.42, max(gw, gh) * 0.95,
	c_black, c_black, false);
draw_set_alpha(1);

// —— Panel (trùng Step_0) ——
var side_m = 20;
var pw = min(540, floor(gw) - side_m * 2);
pw = max(pw, 280);
var px = floor((gw - pw) * 0.5);
var ph = 392;
var py = floor((gh - ph) * 0.5);
var r = 26;
var pad = (pw < 400) ? 18 : 24;
var gap = (pw < 400) ? 10 : 12;
var opt_h = 50;
var opt_inner = pw - pad * 2 - gap;
var opt_w = opt_inner div 2;
var opt_x0 = px + pad;
var opt_y0 = py + 174;
var cx = px + pw * 0.5;

// Bóng nhiều lớp (mềm)
var s;
for (s = 4; s >= 1; s--) {
	draw_set_alpha(0.06 * (5 - s));
	draw_set_color(c_black);
	draw_roundrect_ext(px + s * 3, py + s * 3, px + pw + s * 3, py + ph + s * 3, r + s + 1, r + s + 1, false);
}
draw_set_alpha(1);

// Viền tối ngoài (rim)
draw_set_alpha(0.92);
draw_set_color(make_color_rgb(12, 14, 28));
draw_roundrect_ext(px - 1, py - 1, px + pw + 1, py + ph + 1, r + 1, r + 1, true);
draw_set_alpha(1);

// Thân card — gradient kem tinh
draw_roundrect_colour_ext(px, py, px + pw, py + ph, r, r,
	make_color_rgb(255, 254, 252), make_color_rgb(246, 242, 235), false);
// Lớp gloss trên
draw_set_alpha(0.14);
draw_set_color(c_white);
draw_roundrect_ext(px + 6, py + 5, px + pw - 6, py + 62, r - 5, r - 5, false);
draw_set_alpha(0.08);
draw_roundrect_ext(px + 6, py + 5, px + pw - 6, py + 110, r - 5, r - 5, false);
draw_set_alpha(1);

// Viền gradient (outline 2 bước)
draw_roundrect_colour_ext(px, py, px + pw, py + ph, r, r,
	make_color_rgb(45, 55, 85), make_color_rgb(234, 88, 12), true);
draw_set_alpha(0.55);
draw_set_color(make_color_rgb(255, 255, 255));
draw_roundrect_ext(px + 2, py + 2, px + pw - 2, py + ph - 2, r - 3, r - 3, true);
draw_set_alpha(1);

// Sọc cyan siêu mỏng
draw_roundrect_colour_ext(px + 14, py + 7, px + pw - 14, py + 10, 2, 2,
	make_color_rgb(125, 211, 252), make_color_rgb(14, 165, 233), false);

// —— Ribbon ——
var rib_y1 = py + 20;
var rib_y2 = py + 64;
var rib_r = 14;
draw_set_alpha(0.35);
draw_set_color(c_black);
draw_roundrect_ext(px + pad + 2, rib_y1 + 4, px + pw - pad + 2, rib_y2 + 4, rib_r, rib_r, false);
draw_set_alpha(1);
draw_roundrect_colour_ext(px + pad, rib_y1, px + pw - pad, rib_y2, rib_r, rib_r,
	make_color_rgb(255, 149, 89), make_color_rgb(234, 88, 12), false);
draw_set_alpha(0.4);
draw_set_color(c_white);
draw_roundrect_ext(px + pad + 5, rib_y1 + 4, px + pw - pad - 5, rib_y1 + 14, 8, 8, false);
draw_set_alpha(1);
draw_set_color(make_color_rgb(180, 70, 10));
draw_roundrect_ext(px + pad, rib_y1, px + pw - pad, rib_y2, rib_r, rib_r, true);

var _ry = (rib_y1 + rib_y2) * 0.5;
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
var _rib_t = "Thử thách toán học";
draw_set_color(make_color_rgb(40, 14, 4));
draw_text_transformed(cx + 2, _ry + 2, _rib_t, 0.93, 0.93, 0);
draw_set_color(make_color_rgb(90, 30, 8));
draw_text_transformed(cx + 1, _ry + 1, _rib_t, 0.93, 0.93, 0);
draw_set_color(make_color_rgb(255, 248, 238));
draw_text_transformed(cx, _ry, _rib_t, 0.93, 0.93, 0);

// —— Khung câu hỏi (thẻ trắng nổi) ——
var qx1 = px + pad;
var qy1 = py + 74;
var qx2 = px + pw - pad;
var qy2 = py + 162;
draw_set_alpha(0.2);
draw_set_color(c_black);
draw_roundrect_ext(qx1 + 3, qy1 + 4, qx2 + 3, qy2 + 4, 18, 18, false);
draw_set_alpha(1);
draw_roundrect_colour_ext(qx1, qy1, qx2, qy2, 18, 18,
	make_color_rgb(248, 252, 255), make_color_rgb(232, 242, 252), false);
draw_roundrect_colour_ext(qx1 + 3, qy1 + 8, qx1 + 10, qy2 - 8, 3, 3,
	make_color_rgb(56, 189, 248), make_color_rgb(3, 105, 161), false);
draw_set_alpha(0.35);
draw_set_color(c_white);
draw_roundrect_ext(qx1 + 5, qy1 + 4, qx2 - 5, qy1 + 22, 14, 14, false);
draw_set_alpha(1);
draw_set_color(make_color_rgb(51, 98, 148));
draw_roundrect_ext(qx1, qy1, qx2, qy2, 18, 18, true);

draw_set_halign(fa_center);
draw_set_valign(fa_middle);
var _qy = (qy1 + qy2) * 0.5;
var _qq = global.quiz_question;
draw_set_color(c_white);
draw_text_ext(cx + 1, _qy + 1, _qq, string_height("M") * 1.2, qx2 - qx1 - 40);
draw_set_color(make_color_rgb(15, 37, 77));
draw_text_ext(cx, _qy, _qq, string_height("M") * 1.2, qx2 - qx1 - 40);

// —— Đáp án ——
var labels = ["A", "B", "C", "D"];
var opt_x = [opt_x0, opt_x0 + opt_w + gap, opt_x0, opt_x0 + opt_w + gap];
var opt_y = [opt_y0, opt_y0, opt_y0 + opt_h + gap, opt_y0 + opt_h + gap];
var rr_opt = 14;

for (var i = 0; i < 4; i++) {
	var ox1 = opt_x[i];
	var oy1 = opt_y[i];
	var ox2 = ox1 + opt_w;
	var oy2 = oy1 + opt_h;
	var mx = device_mouse_x_to_gui(0);
	var my = device_mouse_y_to_gui(0);
	var hot = point_in_rectangle(mx, my, ox1, oy1, ox2, oy2);

	draw_set_alpha(hot ? 0.28 : 0.16);
	draw_set_color(c_black);
	draw_roundrect_ext(ox1 + 2, oy1 + 3, ox2 + 2, oy2 + 4, rr_opt + 1, rr_opt + 1, false);
	draw_set_alpha(1);

	var c_top = hot ? make_color_rgb(255, 255, 252) : make_color_rgb(252, 249, 243);
	var c_bot = hot ? make_color_rgb(255, 236, 210) : make_color_rgb(237, 228, 216);
	draw_roundrect_colour_ext(ox1, oy1, ox2, oy2, rr_opt, rr_opt, c_top, c_bot, false);
	draw_set_alpha(0.55);
	draw_set_color(c_white);
	draw_roundrect_ext(ox1 + 4, oy1 + 4, ox2 - 4, oy1 + 14, 9, 9, false);
	draw_set_alpha(1);
	var brd_o = hot ? make_color_rgb(249, 115, 22) : make_color_rgb(120, 86, 62);
	var brd_i = hot ? make_color_rgb(253, 224, 178) : make_color_rgb(200, 180, 158);
	draw_set_color(brd_o);
	draw_roundrect_ext(ox1, oy1, ox2, oy2, rr_opt, rr_opt, true);
	draw_set_alpha(0.65);
	draw_set_color(brd_i);
	draw_roundrect_ext(ox1 + 1, oy1 + 1, ox2 - 1, oy2 - 1, rr_opt - 1, rr_opt - 1, true);
	draw_set_alpha(1);

	var bx = ox1 + 28;
	var by = oy1 + opt_h * 0.5;
	var badge_r = 14;
	draw_roundrect_colour_ext(bx - badge_r, by - badge_r, bx + badge_r, by + badge_r, 10, 10,
		make_color_rgb(254, 230, 138), make_color_rgb(245, 158, 11), false);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_set_color(make_color_rgb(55, 28, 6));
	draw_text_transformed(bx + 1, by + 1, labels[i], 1.05, 1.05, 0);
	draw_set_color(make_color_rgb(255, 251, 235));
	draw_text_transformed(bx, by, labels[i], 1.05, 1.05, 0);

	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	var _opt_txt = string(global.quiz_opt[i]);
	draw_set_color(c_white);
	draw_text_transformed(ox1 + 55, by + 1, _opt_txt, 1.05, 1.05, 0);
	draw_set_color(make_color_rgb(30, 41, 59));
	draw_text_transformed(ox1 + 54, by, _opt_txt, 1.05, 1.05, 0);
}

// —— Chân ——
var foot_y = py + ph - 40;
draw_set_alpha(0.15);
draw_set_color(c_black);
draw_roundrect_ext(px + pad + 2, foot_y + 2, px + pw - pad + 2, py + ph - 11, 12, 12, false);
draw_set_alpha(1);
draw_roundrect_colour_ext(px + pad, foot_y, px + pw - pad, py + ph - 14, 12, 12,
	make_color_rgb(250, 246, 239), make_color_rgb(236, 228, 218), false);
draw_set_color(make_color_rgb(140, 126, 118));
draw_roundrect_ext(px + pad, foot_y, px + pw - pad, py + ph - 14, 12, 12, true);

draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(make_color_rgb(255, 255, 255));
draw_text_transformed(cx + 1, foot_y + 14, "Phím 1–4 hoặc bấm ô đáp án  ·  Đúng: hạ quái  ·  Sai: mất máu", 0.57, 0.57, 0);
draw_set_color(make_color_rgb(80, 72, 68));
draw_text_transformed(cx, foot_y + 13, "Phím 1–4 hoặc bấm ô đáp án  ·  Đúng: hạ quái  ·  Sai: mất máu", 0.57, 0.57, 0);

draw_set_halign(fa_left);
draw_set_valign(fa_top);
if (f != -1) draw_set_font(-1);
