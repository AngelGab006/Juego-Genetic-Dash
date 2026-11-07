// si muere entonces:
if (global.game_state == GAME_STATE.DEAD) {
    dead_timer--;
    if (dead_timer <= 0) player_respawn();
    exit;
}

if (global.game_state != GAME_STATE.PLAYING) exit;

var _inp = input_get();

// Avance horizontal
x += SPEED_NORMAL;

// física según el modo
switch (mode) {
    case PLAYER_MODE.CUBE:
        player_cube_step(_inp);
        break;
}

// Púas
if (place_meeting(x, y, par_hazard)) {
    player_die();
}