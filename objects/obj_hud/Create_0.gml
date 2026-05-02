if (variable_global_exists("new_run_from_menu") && global.new_run_from_menu) {
	global.run_start_ms = current_time;
} else if (!variable_global_exists("run_start_ms")) {
	global.run_start_ms = current_time;
}
level_start_ms = global.run_start_ms;

if (!variable_global_exists("game_over")) {
	global.game_over = false;
}

if (!variable_global_exists("font_start_vn")) {
	global.font_start_vn = font_add("Segoe UI", 22, true, false, 32, 1200);
	if (global.font_start_vn == -1) {
		global.font_start_vn = font_add("Arial", 22, true, false, 32, 1200);
	}
}

