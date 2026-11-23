draw_self();

var _txt = "JUGADOR";

if (global.controller == CONTROLLER.HUMAN){
	_txt = "JUGADOR";
}else if (global.controller == CONTROLLER.AI_TRAIN){
	_txt = "AI Train";
}else if (global.controller == CONTROLLER.AI_TEST){
	_txt = "AI Test";
}

draw_set_font(fnt_ui);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(COL_WHITE);
draw_text((bbox_left + bbox_right) / 2, (bbox_top + bbox_bottom) / 2, _txt);

draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);