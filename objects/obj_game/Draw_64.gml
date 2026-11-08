draw_set_color(c_white);
draw_text(8, 8, "Room: " + room_get_name(room)
              + "   Estado: " + string(global.game_state)
              + "   FPS: " + string(fps));
if (room == rm_menu) {
    draw_text(8, 40, "Presiona ENTER para jugar (temporal)");
}

if (room == rm_game && instance_exists(obj_player)) {
    draw_text(8, 40, "x: " + string(obj_player.x)
                   + "  y: " + string(obj_player.y)
                   + "  vy: " + string(obj_player.vy)
                   + "  suelo: " + string(obj_player.on_ground));
    draw_text(8, 64, "Intento: " + string(global.attempts)
                   + "   Estado: " + string(global.game_state));
	draw_text(8, 112, "Progreso: " + string(level_progress_pct()) + "%");
}

draw_text(8, 88, "Bloques: " + string(instance_number(obj_block))
               + "  Puas: " + string(instance_number(obj_spike)));

// Porcentaje al morir
if (room == rm_game && global.game_state == GAME_STATE.DEAD
    && instance_exists(obj_player)) {
    var _a = clamp(obj_player.dead_timer / 10, 0, 1);
    draw_set_alpha(_a);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text_transformed(display_get_gui_width() / 2,
                          display_get_gui_height() / 2,
                          string(global.death_pct) + "%", 4, 4, 0);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_alpha(1);
}

