var _w = room_width;
var _h = room_height;
var tw = title_tw;

var t = 0.22 + 0.03 * sin(tw * 2.1);
draw_set_alpha(0.5 + 0.08 * sin(tw * 1.7));
draw_set_color(make_color_rgb(40, 96, 160));
draw_roundrect_ext(panel_x1 - 6, panel_y1 - 6, panel_x2 + 6, panel_y2 + 6, 16, 16, false);
draw_set_alpha(1);

draw_set_color(make_color_rgb(246, 251, 255));
draw_roundrect_ext(panel_x1, panel_y1, panel_x2, panel_y2, 12, 12, false);
draw_set_color(make_color_rgb(32, 56, 96));
draw_roundrect_ext(panel_x1, panel_y1, panel_x2, panel_y2, 12, 12, true);

draw_set_font(-1);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(make_color_rgb(28, 48, 82));
draw_text_transformed(_w * 0.5, _h * 0.36, "Hết quái! Chuyển màn.", t, t, 0);

draw_set_color(make_color_rgb(70, 110, 160));
draw_text_transformed(_w * 0.5, _h * 0.52, "Enter / Space — chơi lại màn 1", 0.92, 0.92, 0);

draw_set_halign(fa_left);
draw_set_valign(fa_top);
