pregame_tw = 0;
btn_hover = false;

if (!variable_global_exists("font_start_vn")) {
	global.font_start_vn = font_add("Segoe UI", 22, true, false, 32, 1200);
	if (global.font_start_vn == -1) {
		global.font_start_vn = font_add("Arial", 22, true, false, 32, 1200);
	}
}
if (!variable_global_exists("font_pregame_body")) {
	global.font_pregame_body = font_add("Segoe UI", 18, false, false, 32, 1200);
	if (global.font_pregame_body == -1) {
		global.font_pregame_body = font_add("Arial", 18, false, false, 32, 1200);
	}
}
