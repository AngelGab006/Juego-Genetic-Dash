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
}

draw_text(8, 88, "Bloques: " + string(instance_number(obj_block))
               + "  Puas: " + string(instance_number(obj_spike)));
