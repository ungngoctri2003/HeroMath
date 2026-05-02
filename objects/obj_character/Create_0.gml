vsp = 0;
grav = 0.5;
jump = -10;
move_speed = 4;
spr_idle = spr_character_dung_yen;
spr_walk = spr_character_chay;
attacking = false;
walk_image_speed = 0.2;
idle_image_speed = 1;
attack_image_speed = 0.15;
hp_max = 100;
hp = hp_max;
global.hp = hp;
global.hp_max = hp_max;
attack_damage_done = false;
dead = false;
hurt_timer = 0;
if (!variable_global_exists("score")) {
	global.score = 0;
}
if (!variable_global_exists("quiz_opt")) {
	global.quiz_opt = [0, 0, 0, 0];
}