// si muere entonces:
if (global.game_state == GAME_STATE.DEAD) {
    dead_timer--;
    if (dead_timer <= 0) player_respawn();
    exit;
}

if (global.game_state != GAME_STATE.PLAYING) exit;

var _inp = input_get();
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

// Peligros
if (place_meeting(x, y, par_hazard)) {
    player_die();
}