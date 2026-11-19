// Barra fina con resplandor, de arriba a abajo de la pantalla
var _cy = camera_get_view_y(view_camera[0]);
var _bx = x - 4;
var _a  = [0.15, 0.25, 0.45, 1.0];
var _w  = [24, 14, 8, 2];
draw_set_color(c_yellow);
for (var _i = 0; _i < 4; _i++) {
    draw_set_alpha(_a[_i]);
    draw_rectangle(_bx - _w[_i], _cy - 4, _bx + _w[_i], _cy + VIEW_H + 4, false);
}
draw_set_alpha(1);
draw_set_color(c_white);