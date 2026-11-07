// mueve el juego entre el menu y los niveles

// Arranca un nivel
function game_start_level(_n) {
    global.current_level = _n;
    global.attempts      = 1;
    global.game_state    = GAME_STATE.PLAYING;
    room_goto(rm_game);
}

// Vuelve al menú principal
function game_go_menu() {
    global.game_state = GAME_STATE.MENU;
    room_goto(rm_menu);
}

// Porcentaje de avance del jugador en el nivel
function level_progress_pct() {
    if (!instance_exists(obj_player)) return 0;
    return clamp(floor(100 * obj_player.x / max(1, global.level.end_x)), 0, 100);
}