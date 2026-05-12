// Nhạc nền xuyên suốt — persistent. RoomStart có instance: khi về menu, instance mới bị hủy nếu đã có bản đang sống.
if (instance_number(obj_music_manager) > 1) {
	instance_destroy();
} else if (!audio_is_playing(sound_nhac_nen)) {
	audio_play_sound(sound_nhac_nen, 0, true);
}
