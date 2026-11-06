if (global.game_state != GAME_STATE.PLAYING) exit;

var _inp = input_get();

// Avance horizontal constante
x += SPEED_NORMAL;

// Física según el modo
switch (mode) {
    case PLAYER_MODE.CUBE:
        player_cube_step(_inp);
        break;
}