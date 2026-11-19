// si el nivel falla, vuelve al menú
if (room_is_level()) {
	music_play(global.current_level);
}
if (room == rm_menu){
	music_stop();
}