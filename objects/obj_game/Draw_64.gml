draw_set_color(c_white);
draw_text(8, 8, "Estado: " + string(global.game_state)
              + "   FPS: " + string(fps_real));

if (room == rm_menu) {
    draw_text(8, 40, "Menu principal (T03 OK)");
}