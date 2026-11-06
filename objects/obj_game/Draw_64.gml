draw_set_color(c_white);
draw_text(8, 8, "Estado: " + string(global.game_state)
              + "   FPS: " + string(fps));
if (room == rm_menu) {
    draw_text(8, 40, "Presiona ENTER para jugar (temporal)");
}

if (room == rm_game && instance_exists(obj_player)) {
    draw_text(8, 40, "x: "  + string(obj_player.x)
                   + "  y: " + string(obj_player.y)
                   + "  vy: " + string(obj_player.vy)
                   + "  suelo: " + string(obj_player.on_ground));
}