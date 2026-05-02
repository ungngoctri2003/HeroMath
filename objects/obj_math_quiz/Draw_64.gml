/// Draw GUI — popup câu hỏi (Kenney / cream–cam, đồng bộ layout với Step_0)
if (!variable_global_exists("quiz_active") || !global.quiz_active) return;

if (variable_global_exists("game_over") && global.game_over) return;

var gw = display_get_gui_width();
var gh = display_get_gui_height();
var f = global.font_start_vn;
if (f != -1) draw_set_font(f);

draw_set_circle_precision(32);

// —— Lớp nền mờ + vignette ——
draw_set_alpha(0.48);
draw_set_color(make_color_rgb(18, 22, 42));
draw_rectangle(0, 0, gw, gh, false);
draw_set_alpha(0.35);
draw_circle_color(gw * 0.5, gh * 0.48, max(gw, gh) * 0.72, c_black, c_black, false);
draw_set_alpha(1);

// —— Kích thước panel: luôn nằm trong GUI (trùng Step_0) ——
var side_m = 20;
var pw = min(540, floor(gw) - side_m * 2);
pw = max(pw, 280);
var px = floor((gw - pw) * 0.5);
var ph = 392;
var py = floor((gh - ph) * 0.5);
var r = 22;
var pad = (pw < 400) ? 18 : 24;
var gap = (pw < 400) ? 10 : 12;
var opt_h = 50;
var opt_inner = pw - pad * 2 - gap;
var opt_w = opt_inner div 2;
var opt_x0 = px + pad;
var opt_y0 = py + 174;

// Đổ bóng kép
draw_set_alpha(0.18);
draw_set_color(c_black);
draw_roundrect_ext(px + 8, py + 10, px + pw + 8, py + ph + 10, r + 2, r + 2, false);
draw_set_alpha(0.12);
draw_roundrect_ext(px + 4, py + 5, px + pw + 4, py + ph + 5, r, r, false);
draw_set_alpha(1);

// Nền chính
var _crm0 = make_color_rgb(255, 252, 244);
var _crm1 = make_color_rgb(250, 240, 222);
draw_roundrect_colour_ext(px, py, px + pw, py + ph, r, r, _crm0, _crm1, false);

// Viền ngoài cam
draw_roundrect_colour_ext(px, py, px + pw, py + ph, r, r, make_color_rgb(242, 134, 58), make_color_rgb(184, 86, 34), true);

// Viền sáng trong
draw_set_alpha(0.45);
draw_set_color(c_white);
draw_roundrect_ext(px + 4, py + 4, px + pw - 4, py + ph - 4, r - 4, r - 4, true);
draw_set_alpha(1);

// —— Thanh tiêu đề (ribbon) ——
var rib_y1 = py + 14;
var rib_y2 = py + 58;
var rib_r = 14;
draw_roundrect_colour_ext(px + pad, rib_y1, px + pw - pad, rib_y2, rib_r, rib_r,
	make_color_rgb(255, 168, 72), make_color_rgb(232, 118, 48), false);
draw_roundrect_ext(px + pad, rib_y1, px + pw - pad, rib_y2, rib_r, rib_r, true);

draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(make_color_rgb(92, 46, 18));
draw_text_transformed(gw * 0.5, (rib_y1 + rib_y2) * 0.5 + 1, "Thử thách toán học", 0.88, 0.88, 0);
draw_set_color(c_white);
draw_text_transformed(gw * 0.5, (rib_y1 + rib_y2) * 0.5 - 1, "Thử thách toán học", 0.88, 0.88, 0);

// —— Khung câu hỏi ——
var qx1 = px + pad;
var qy1 = py + 70;
var qx2 = px + pw - pad;
var qy2 = py + 158;
draw_roundrect_colour_ext(qx1, qy1, qx2, qy2, 16, 16,
	make_color_rgb(236, 246, 255), make_color_rgb(220, 234, 252), false);
draw_set_alpha(0.65);
draw_set_color(make_color_rgb(90, 140, 210));
draw_roundrect_ext(qx1, qy1, qx2, qy2, 16, 16, true);
draw_set_alpha(1);

draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(make_color_rgb(32, 56, 112));
draw_text_ext(gw * 0.5, (qy1 + qy2) * 0.5, global.quiz_question, string_height("M") * 1.15, qx2 - qx1 - 28);

// —— Bốn đáp án ——
var labels = ["A", "B", "C", "D"];
var opt_x = [opt_x0, opt_x0 + opt_w + gap, opt_x0, opt_x0 + opt_w + gap];
var opt_y = [opt_y0, opt_y0, opt_y0 + opt_h + gap, opt_y0 + opt_h + gap];

for (var i = 0; i < 4; i++) {
	var ox1 = opt_x[i];
	var oy1 = opt_y[i];
	var ox2 = ox1 + opt_w;
	var oy2 = oy1 + opt_h;
	var mx = device_mouse_x_to_gui(0);
	var my = device_mouse_y_to_gui(0);
	var hot = point_in_rectangle(mx, my, ox1, oy1, ox2, oy2);

	var bg1 = hot ? make_color_rgb(255, 248, 232) : make_color_rgb(252, 244, 228);
	var bg2 = hot ? make_color_rgb(255, 228, 190) : make_color_rgb(244, 228, 204);
	var br  = hot ? make_color_rgb(220, 108, 48) : make_color_rgb(188, 100, 52);

	draw_set_alpha(hot ? 1 : 0.97);
	draw_roundrect_colour_ext(ox1, oy1, ox2, oy2, 14, 14, bg1, bg2, false);
	draw_set_color(br);
	draw_roundrect_ext(ox1, oy1, ox2, oy2, 14, 14, true);
	draw_set_alpha(1);

	// Badge chữ cái —— nằm trọn trong ô (tránh lệch ra ngoài)
	var bx = ox1 + 26;
	var by = oy1 + opt_h * 0.5;
	var badge_r = 14;
	draw_set_color(make_color_rgb(255, 186, 88));
	draw_circle(bx, by, badge_r, false);
	draw_set_color(make_color_rgb(200, 98, 36));
	draw_circle(bx, by, badge_r, true);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_set_color(make_color_rgb(118, 48, 16));
	draw_text_transformed(bx, by + 1, labels[i], 1.05, 1.05, 0);
	draw_set_color(c_white);
	draw_text_transformed(bx, by - 1, labels[i], 1.05, 1.05, 0);

	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	draw_set_color(make_color_rgb(48, 72, 118));
	draw_text_transformed(ox1 + 50, by, string(global.quiz_opt[i]), 1.08, 1.08, 0);
}

// —— Chân gợi ý ——
var foot_y = py + ph - 40;
draw_set_alpha(0.55);
draw_roundrect_colour_ext(px + pad, foot_y, px + pw - pad, py + ph - 14, 10, 10,
	make_color_rgb(240, 232, 218), make_color_rgb(230, 220, 205), false);
draw_roundrect_ext(px + pad, foot_y, px + pw - pad, py + ph - 14, 10, 10, true);
draw_set_alpha(1);

draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(make_color_rgb(105, 92, 82));
draw_text_transformed(gw * 0.5, foot_y + 13,
	"Phím 1–4 · hoặc bấm ô đáp án — Đúng: hạ quái · Sai: mất máu", 0.58, 0.58, 0);

draw_set_halign(fa_left);
draw_set_valign(fa_top);
if (f != -1) draw_set_font(-1);
