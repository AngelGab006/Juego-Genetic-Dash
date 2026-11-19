// mueve el juego entre el menu y los niveles


function room_is_level() {
    return array_contains(global.level_rooms, room);
}

function level_goal_x() {
    return room_width;
}

// Arranca un nivel
function game_start_level(_n) {
    global.current_level = _n;
    global.attempts      = 1;
    global.game_state    = GAME_STATE.PLAYING;
    room_goto(global.level_rooms[_n - 1]);
}

// Vuelve al menú principal
function game_go_menu() {
    global.game_state = GAME_STATE.MENU;
    room_goto(rm_menu);
	music_stop();
}

// Porcentaje de avance del jugador en el nivel
function level_progress_pct() {
    if (!instance_exists(obj_player)) return 0;
    var _p = obj_player;
    var _total = max(1, level_goal_x() - WIN_STOP_DIST - _p.start_x);
    return clamp(floor(100 * (_p.x - _p.start_x) / _total), 0, 100);
}

// siguiente nivel
function game_next_level() {
    if (global.current_level < LEVEL_COUNT) {
        game_start_level(global.current_level + 1);
    } else {
        game_start_level(global.current_level);
    }
}

// Qué panel hay en pantalla: 0 = ninguno, 1 = pausa, 2 = victoria
function ui_panel_kind() {
    if (global.fast_mode) return 0;
    if (global.game_state == GAME_STATE.PAUSED) return 1;
    if (global.game_state == GAME_STATE.WON)    return 2;
    return 0;
}

function game_pause() {
    if (global.game_state != GAME_STATE.PLAYING) return;
    global.game_state = GAME_STATE.PAUSED;
    if (global.music_handle != -1) audio_pause_sound(global.music_handle);
}

function game_resume() {
    if (global.game_state != GAME_STATE.PAUSED) return;
    global.game_state = GAME_STATE.PLAYING;
    if (instance_exists(obj_player)) obj_player.input_lock = PANEL_INPUT_FR;
    if (global.music_handle != -1) audio_resume_sound(global.music_handle);
}

// Reiniciar el nivel
function game_retry() {
    with (obj_player) {
        player_respawn();
        input_lock = PANEL_INPUT_FR;
    }
}

// Qué hace cada botón de cada panel
function panel_activate(_kind, _i) {
    if (_kind == 1) {
        switch (_i) {
			// CONTINUAR
			case 0: game_resume();  break;
			// REINTENTAR
			case 1: game_retry();   break;
			// MENU
			case 2: game_go_menu(); break;
        }
    } else {
        if (_i == 0) game_next_level(); else game_go_menu();
    }
}