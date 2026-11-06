// Arranque empezamos en el menu
if (room == rm_boot) {
    game_go_menu();
}

// TEMPORAL para probar el juego
if (room == rm_menu && keyboard_check_pressed(vk_enter)) {
    game_start_level(1);
}