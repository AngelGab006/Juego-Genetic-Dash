// física del cubo..
function player_cube_step(_inp) {
    var _half = CUBE_HITBOX / 2;

    // Salto solo desde el suelo
    if (on_ground && (_inp.jump_held || _inp.jump_pressed)) {
        vy = CUBE_JUMP_VY;
        on_ground = false;
    }

    // Gravedad con velocidad terminal
    vy += CUBE_GRAVITY;
    vy = min(vy, CUBE_MAX_FALL);
    y += vy;

    // Suelo
    if (y + _half >= GROUND_Y) {
        y = GROUND_Y - _half;
        vy = 0;
        on_ground = true;
    } else {
        on_ground = false;
    }
}