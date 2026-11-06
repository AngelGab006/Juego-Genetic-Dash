draw_set_color(c_white);
draw_text(8, 8, "Estado: " + string(global.game_state)
              + "   FPS: " + string(fps_real));

if (room == rm_menu) {
    draw_text(8, 40, "Menu principal (T03 OK)");

    // prueba de input
    var _inp = input_get();
    draw_text(8, 72, "jump_pressed: " + string(_inp.jump_pressed));
    draw_text(8, 96, "jump_held:    " + string(_inp.jump_held));
}