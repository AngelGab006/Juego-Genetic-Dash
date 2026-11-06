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