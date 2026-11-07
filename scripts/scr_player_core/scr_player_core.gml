// muerte y reaparición del jugador.
function player_die() {
    // Si ya está muerto, no hacer nada
    if (global.game_state != GAME_STATE.PLAYING) exit;

    global.game_state = GAME_STATE.DEAD;
    dead_timer = DEATH_DELAY_FR;
    visible = false;
    // (Agregar sonido de muerte)
}

function player_respawn() {
    x = start_x;
    y = start_y;
    vy = 0;
    on_ground = false;
    mode = PLAYER_MODE.CUBE;
    visible = true;

    global.attempts++;
    global.game_state = GAME_STATE.PLAYING;
}