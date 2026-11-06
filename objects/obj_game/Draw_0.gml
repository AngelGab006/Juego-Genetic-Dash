// temporal para probar
if (room == rm_game) {
    var _cx = camera_get_view_x(view_camera[0]);
    draw_set_color(c_dkgray);
    draw_rectangle(_cx, GROUND_Y, _cx + VIEW_W, GROUND_Y + GROUND_ROWS * TILE, false);
    draw_set_color(c_white);
}