if (room == rm_game) {
    if (!level_load(global.current_level)) {
		// si el nivel falla, vuelve al menú
        game_go_menu();     
    }
}