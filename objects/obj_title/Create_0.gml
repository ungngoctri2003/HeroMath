 // Kenney New Platformer pack — phong cach & palette (Vector trong kenney_new-platformer-pack-1.1, CC0 kenney.nl)
var _w = room_width;
var _h = room_height;
panel_x1 = _w * 0.5 - 280;
panel_y1 = _h * 0.36 - 105;
panel_x2 = _w * 0.5 + 280;
panel_y2 = _h * 0.36 + 105;
btn_x1 = _w * 0.5 - 140;
btn_y1 = _h * 0.70;
btn_x2 = _w * 0.5 + 140;
btn_y2 = btn_y1 + 58;
btn_hover = false;
title_tw = 0;

if (!variable_global_exists("font_start_vn")) {
	global.font_start_vn = font_add("Segoe UI", 22, true, false, 32, 1200);
	if (global.font_start_vn == -1) {
		global.font_start_vn = font_add("Arial", 22, true, false, 32, 1200);
	}
}
