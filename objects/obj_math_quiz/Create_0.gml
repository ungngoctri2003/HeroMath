global.quiz_active = false;
global.quiz_enemy = noone;
global.quiz_cooldown = 0;
global.quiz_question = "";
global.quiz_correct = 0;
global.quiz_opt = [0, 0, 0, 0];
global.quiz_pending_attack = false;
global.quiz_face_x = 0;

if (!variable_global_exists("font_start_vn")) {
	global.font_start_vn = font_add("Segoe UI", 22, true, false, 32, 1200);
	if (global.font_start_vn == -1) {
		global.font_start_vn = font_add("Arial", 22, true, false, 32, 1200);
	}
}
