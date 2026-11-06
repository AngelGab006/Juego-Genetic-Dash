// arranca en el menu
if (room == rm_boot) {
    game_go_menu();
	// TEMPORAL: probar el modo IA con la tecla A
	if (keyboard_check_pressed(ord("A"))) {
	    global.controller = (global.controller == CONTROLLER.HUMAN)
	                      ? CONTROLLER.AI : CONTROLLER.HUMAN;
	}
}