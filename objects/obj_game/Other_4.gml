// si el nivel falla, vuelve al menú
if (room == rm_game) {
    if (!level_load(global.current_level)) {
        game_go_menu(); 
    }
	music_play(global.level.music);
}
if (room == rm_menu){
	music_stop();
}