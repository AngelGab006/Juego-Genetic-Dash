// física del cubo y colision
function player_cube_step(_inp) {
    var _half = CUBE_HITBOX / 2;

    // Choque lateral
    var _blk = instance_place(x, y, par_solid);
    if (_blk != noone) {
        var _feet = y + _half;
        if (!BLOCK_TOP_KILLS && (_feet - _blk.bbox_top) <= BLOCK_TOLERANCE) {
            // si Solo rozó la esquina de la cima, lo apoyamos encima
            y = _blk.bbox_top - _half;
        } else {
            player_die();
            return;
        }
    }

    // Salto
    if (on_ground && _inp.jump_held) {
        vy = CUBE_JUMP_VY;
        on_ground = false;
    }

    // Gravedad y movimiento vertical
    vy += CUBE_GRAVITY;
    vy = min(vy, CUBE_MAX_FALL);
    var _prev_feet = y + _half;
    y += vy;
    on_ground = false;

    // Suelo
    if (y + _half >= GROUND_Y) {
        y = GROUND_Y - _half;
        vy = 0;
        on_ground = true;
    }

    // Bloques
    if (vy >= 0) {
        _blk = instance_place(x, y + 1, par_solid);
        if (_blk != noone && _prev_feet <= _blk.bbox_top + BLOCK_TOLERANCE) {
            if (BLOCK_TOP_KILLS) {
                player_die();
                return;
            }
            y = _blk.bbox_top - _half;
            vy = 0;
            on_ground = true;
        }
    } else {
        // chocó con la parte de abajo de un bloque
        if (place_meeting(x, y, par_solid)) {
            player_die();
            return;
        }
    }
}