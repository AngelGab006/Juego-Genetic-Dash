// muerte y reaparición del jugador.
function player_die() {
    // Si ya está muerto, no hacer nada
    if (global.game_state != GAME_STATE.PLAYING) exit;

    global.death_pct  = level_progress_pct();
	global.game_state = GAME_STATE.DEAD;
    dead_timer = DEATH_DELAY_FR;
    visible = false;
	music_stop();
	sfx_play(snd_death);
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
	cam_y = CAM_BASE_Y;
    visual_angle = 0;
    image_xscale = 1;
    image_yscale = 1;
	music_play(global.level.music);
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

		case OBJ_TYPE.GOAL:
            player_win();
            break;
    }
}

// Cambia el modo del jugador
function player_set_mode(_m) {
    if (mode == _m) return;

    mode = _m;
    visual_angle = 0
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

// Empieza la animación de victoria: el jugador deja de correr
function player_start_win() {
    if (global.game_state != GAME_STATE.PLAYING) exit;

    global.game_state = GAME_STATE.WINNING;
    global.death_pct  = 100;
    win_timer = 0;
    win_x0 = x;
    win_y0 = y;
    win_tx = global.level.end_x - 4;
    win_ty = cam_y + VIEW_H * 0.40;
    vy = 0;
	music_stop(); 
	sfx_play(snd_win);
}

// Animación: sube hacia la barra girando y encogiéndose
function player_win_step() {
    win_timer++;
    var _t = clamp(win_timer / WIN_ANIM_FR, 0, 1);
    var _e = _t * _t * (3 - 2 * _t);

    x = lerp(win_x0, win_tx, _e);
    y = lerp(win_y0, win_ty, _e);
    visual_angle += WIN_SPIN;
    image_xscale = 1 - _e;
    image_yscale = 1 - _e;

    if (_t >= 1) {
        visible = false;
        global.game_state = GAME_STATE.WON;
    }
}