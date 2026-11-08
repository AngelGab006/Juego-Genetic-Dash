// física de la nave.
function player_ship_step(_inp) {
    var _half = CUBE_HITBOX / 2;

    // Choque lateral
    var _blk = instance_place(x, y, par_solid);
    if (_blk != noone) {
        var _feet = y + _half;
        var _head = y - _half;
        if ((_feet - _blk.y) <= BLOCK_TOLERANCE) {
            y = _blk.y - _half;
            vy = min(vy, 0);
        } else if (((_blk.y + TILE) - _head) <= BLOCK_TOLERANCE) {
            y = _blk.y + TILE + _half;
            vy = max(vy, 0);
        } else {
            player_die();
            return;
        }
    }

    // Aceleración vertical
    var _a = SHIP_GRAVITY;
    if (_inp.jump_held) _a += SHIP_THRUST;
    vy = clamp(vy + _a, -SHIP_MAX_VY, SHIP_MAX_VY);
    var _vy_move = vy;
    y += vy;

    // Suelo y techo
    if (y + _half >= GROUND_Y) {
        y = GROUND_Y - _half;
        vy = 0;
    }
    if (y - _half <= CEILING_Y) {
        y = CEILING_Y + _half;
        vy = 0;
    }

    // apoyo encima o golpe por debajo
    _blk = instance_place(x, y, par_solid);
    if (_blk != noone) {
        if (_vy_move > 0) {
            y = _blk.y - _half;
        } else {
            y = _blk.y + TILE + _half;
        }
        vy = 0;
    }

    // Inclinación visual según la velocidad
    image_angle = clamp(-vy * 5, -35, 35);
}