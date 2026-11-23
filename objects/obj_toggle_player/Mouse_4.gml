// global.controller = (global.controller == CONTROLLER.HUMAN) ? CONTROLLER.AI : CONTROLLER.HUMAN;
if (global.controller == CONTROLLER.HUMAN){
	global.controller = CONTROLLER.AI_TRAIN;
}else if (global.controller == CONTROLLER.AI_TRAIN){
	global.controller = CONTROLLER.AI_TEST;
}else if (global.controller == CONTROLLER.AI_TEST){
	global.controller = CONTROLLER.HUMAN;
}