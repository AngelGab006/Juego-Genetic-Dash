// muerte y reaparición del jugador.
function player_die() {
    // Si ya está muerto, no hacer nada
    if (global.game_state != GAME_STATE.PLAYING) exit;

    global.death_pct  = level_progress_pct();
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
    player_set_mode(PLAYER_MODE.CUBE);
    visible = true;
	last_touch = noone;
	jump_buffer = 0;

    global.attempts++;
    global.game_state = GAME_STATE.PLAYING;
}

// Interacción con pads, orbes, portales y meta.
function player_interact() {
    var _it = instance_place(x, y, par_interactable);

    if (_it == noone) {
        last_touch = noone;
        return;
    }

    if (_it == last_touch) return;

    switch (_it.obj_type) {
        case OBJ_TYPE.PAD:
            vy = PAD_VY;
            on_ground = false;
			last_touch = _it;
            break;
			
		case OBJ_TYPE.ORB:
            if (jump_buffer > 0) {
                vy = ORB_VY;
                on_ground = false;
                jump_buffer = 0;
                last_touch = _it;
            }
            break;
		
		case OBJ_TYPE.PORTAL_SHIP:
            player_set_mode(PLAYER_MODE.SHIP);
            last_touch = _it;
            break;

        case OBJ_TYPE.PORTAL_NORMAL:
            player_set_mode(PLAYER_MODE.CUBE);
            last_touch = _it;
            break;
    }
}

// Cambia el modo del jugador
function player_set_mode(_m) {
    if (mode == _m) return;

    mode = _m;
    image_angle = 0;
    on_ground = false;

    switch (_m) {
        case PLAYER_MODE.CUBE:
            sprite_index = spr_player_cube;
            break;
        case PLAYER_MODE.SHIP:
            sprite_index = spr_player_ship;
            vy = clamp(vy, -SHIP_MAX_VY, SHIP_MAX_VY);
            break;
    }
}