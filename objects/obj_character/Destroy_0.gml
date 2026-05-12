if (variable_instance_exists(id, "run_snd_voice") && run_snd_voice >= 0) {
	if (audio_is_playing(run_snd_voice)) {
		audio_stop_sound(run_snd_voice);
	}
	run_snd_voice = -1;
}
