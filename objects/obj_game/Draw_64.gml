if (global.debug) {
    draw_set_font(-1);
    draw_set_color(c_white);
    draw_text(8, 8, "Room: " + room_get_name(room)
                  + "   Estado: " + string(global.game_state)
                  + "   FPS: " + string(fps));

    if (room == rm_game && instance_exists(obj_player)) {
        draw_text(8, 40, "x: " + string(obj_player.x)
                       + "  y: " + string(obj_player.y)
                       + "  vy: " + string(obj_player.vy)
                       + "  suelo: " + string(obj_player.on_ground));
        draw_text(8, 64, "Intento: " + string(global.attempts)
                       + "   Modo: " + string(obj_player.mode));
        draw_text(8, 88, "Progreso: " + string(level_progress_pct()) + "%");
    }
}

if (room == rm_game && !global.fast_mode) {
    // Botón de pausa (solo mientras se juega)
    if (global.game_state == GAME_STATE.PLAYING || global.game_state == GAME_STATE.DEAD) {
        draw_pause_button();
    }

    // Tarjeta de progreso al morir
    if (global.game_state == GAME_STATE.DEAD) {
        draw_death_card();
    }

    // Paneles de pausa y victoria
    var _kind = ui_panel_kind();
    if (_kind != 0) draw_panel(_kind, end_sel);
}