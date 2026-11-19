// si muere entonces:
if (global.game_state == GAME_STATE.DEAD) {
    dead_timer = max(0, dead_timer - 1);
    if (dead_timer <= 0) player_respawn();
    exit;
}

// Animacion al ganar
if (global.game_state == GAME_STATE.WINNING) {
    player_win_step();
    exit;
}

if (global.game_state != GAME_STATE.PLAYING) exit;

var _inp = input_get();

// Buffer para el doble salto
if (_inp.jump_pressed) {
    jump_buffer = INPUT_BUFFER_FR;
} else {
    jump_buffer = max(0, jump_buffer - 1);
}

// Avance horizontal
x += SPEED_NORMAL;

// física según el modo
switch (mode) {
	case PLAYER_MODE.CUBE:
        player_cube_step(_inp);
        break;
	case PLAYER_MODE.SHIP:
        player_ship_step(_inp);
        break;
}

// Interacción
if (global.game_state == GAME_STATE.PLAYING) {
    player_interact();
}

// Final del nivel
if (global.game_state == GAME_STATE.PLAYING
    && x >= level_goal_x() - WIN_STOP_DIST) {
    player_start_win();
}

// si se sale del mapa de juego
if (global.game_state == GAME_STATE.PLAYING && y < WORLD_TOP_Y) {
    player_die();
}

// Peligros
if (place_meeting(x, y, par_hazard)) {
    player_die();
}