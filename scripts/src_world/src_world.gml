// Dibujar el fondo
function draw_background() {
    var _cx = camera_get_view_x(view_camera[0]);
    var _cy = camera_get_view_y(view_camera[0]);

    var _sw = sprite_get_width(global.level.bg_sprite);
    var _sh = sprite_get_height(global.level.bg_sprite);

    var _s = max(VIEW_W / _sw, VIEW_H / _sh);
    var _w = _sw * _s;

    var _off = -((_cx * BG_PARALLAX_X) mod _w);

    for (var _x = _off; _x < VIEW_W; _x += _w) {
        draw_sprite_ext(global.level.bg_sprite, 0, _cx + _x, _cy, _s, _s, 0, c_white, 1);
    }
}

// Dibujar el suelo
function draw_ground() {
    var _cx = camera_get_view_x(view_camera[0]);
    var _cy = camera_get_view_y(view_camera[0]);

    var _tw = sprite_get_width(spr_ground);
    var _th = sprite_get_height(spr_ground);

    var _x1 = floor(_cx / _tw) * _tw;
    var _x2 = min(_cx + VIEW_W, global.level.end_x);
    var _y2 = _cy + VIEW_H;

    for (var _y = GROUND_Y; _y < _y2; _y += _th) {
        for (var _x = _x1; _x < _x2; _x += _tw) {
            draw_sprite(spr_ground, 0, _x, _y);
        }
    }
}