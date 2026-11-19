// Texto centrado, con color y escala
function ui_text(_x, _y, _str, _col, _scale) {
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_color(_col);
    draw_text_transformed(_x, _y, _str, _scale, _scale, 0);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_color(c_white);
}

function ui_button_hit(_cx, _cy, _mx, _my) {
    var _w = sprite_get_width(spr_button);
    var _h = sprite_get_height(spr_button);
    return point_in_rectangle(_mx, _my, _cx - _w / 2, _cy - _h / 2,
                                        _cx + _w / 2, _cy + _h / 2);
}

// Botón centrado
function ui_button(_cx, _cy, _label, _selected) {
    var _w = sprite_get_width(spr_button);
    var _h = sprite_get_height(spr_button);
    var _tint = _selected ? c_white : make_colour_rgb(150, 140, 190);

    draw_sprite_ext(spr_button, 0,
        floor(_cx - _w / 2) + sprite_get_xoffset(spr_button),
        floor(_cy - _h / 2) + sprite_get_yoffset(spr_button),
        1, 1, 0, _tint, 1);

    ui_text(_cx, _cy, _label, _selected ? COL_YELLOW : COL_WHITE, 1);
}

// Posición de los botones de un panel
function panel_btn_x(_i, _n) {
    if (_n == 2) return PANEL_X + PANEL_W / 2 + (_i == 0 ? -104 : 104);
    return PANEL_X + PANEL_W / 2;
}
function panel_btn_y(_i, _n) {
    if (_n == 2) return PANEL_Y + 272;
    return PANEL_Y + 134 + _i * 58;
}

// Botón de pausa
function pause_button_over() {
    var _mx = device_mouse_x_to_gui(0);
    var _my = device_mouse_y_to_gui(0);
    return point_in_rectangle(_mx, _my, PAUSE_BTN_X, PAUSE_BTN_Y,
                              PAUSE_BTN_X + PAUSE_BTN_S, PAUSE_BTN_Y + PAUSE_BTN_S);
}

function draw_pause_button() {
    var _x = PAUSE_BTN_X;
    var _y = PAUSE_BTN_Y;
    var _s = PAUSE_BTN_S;

    draw_set_alpha(0.85);
    draw_set_color(pause_button_over() ? COL_LIGHT : COL_SHADOW);
    draw_rectangle(_x, _y, _x + _s, _y + _s, false);
    draw_set_color(COL_NIGHT);
    draw_rectangle(_x, _y, _x + _s, _y + _s, true);
    draw_set_color(COL_WHITE);
    draw_rectangle(_x + 11, _y + 10, _x + 16, _y + _s - 10, false);
    draw_rectangle(_x + _s - 16, _y + 10, _x + _s - 11, _y + _s - 10, false);
    draw_set_alpha(1);
    draw_set_color(c_white);
}

// Tarjeta de progreso al morir
function draw_death_card() {
    if (!instance_exists(obj_player)) return;

    // Aparece rápido y se desvanece al final de la espera
    var _t = obj_player.dead_timer;
    var _a = clamp(min((DEATH_DELAY_FR - _t) / 5, _t / 10), 0, 1);

    var _w  = 288;
    var _h  = 128;
    var _px = (VIEW_W - _w) / 2;
    var _py = (VIEW_H - _h) / 2;
    var _cx = VIEW_W / 2;

    draw_sprite_stretched_ext(spr_panel, 0, _px, _py, _w, _h, c_white, _a);

    draw_set_alpha(_a);
    draw_set_font(fnt_ui);
    ui_text(_cx, _py + 40, string(global.death_pct) + "%", COL_CYAN, 4);

    var _bx = _px + 24;
    var _by = _py + 70;
    draw_set_color(COL_NIGHT);
    draw_rectangle(_bx, _by, _bx + _w - 48, _by + 10, false);
    draw_set_color(COL_CYAN);
    draw_rectangle(_bx, _by, _bx + (_w - 48) * global.death_pct / 100, _by + 10, false);
    draw_set_color(c_white);

    ui_text(_cx, _py + 104, "INTENTO " + string(global.attempts), COL_YELLOW, 2);
    draw_set_font(-1);
    draw_set_alpha(1);
}

// Paneles pausa y victoria 
function draw_panel(_kind, _sel) {
    var _s_title = 4;
    var _s_text  = 2;

    var _px = PANEL_X;
    var _py = PANEL_Y;
    var _cx = _px + PANEL_W / 2;
    var _labels;

    draw_set_color(COL_NIGHT);
    draw_set_alpha(0.65);
    draw_rectangle(0, 0, VIEW_W, VIEW_H, false);
    draw_set_alpha(1);
    draw_set_color(c_white);
    draw_sprite_stretched(spr_panel, 0, _px, _py, PANEL_W, PANEL_H);

    draw_set_font(fnt_ui);

    if (_kind == 1) {
        ui_text(_cx, _py + 44, "PAUSA", COL_CYAN, _s_title);
        ui_text(_cx, _py + 88, "NIVEL " + string(global.current_level)
                             + "   PROGRESO " + string(level_progress_pct()) + "%",
                COL_WHITE, _s_text);
        _labels = ["CONTINUAR", "REINTENTAR", "MENU"];
    } else {
        ui_text(_cx, _py + 62,  "NIVEL",      COL_WHITE,  3);
        ui_text(_cx, _py + 104, "COMPLETADO", COL_YELLOW, _s_title);
        ui_text(_cx, _py + 162, "INTENTOS " + string(global.attempts), COL_CYAN, _s_text);
        _labels = [(global.current_level < LEVEL_COUNT) ? "SIGUIENTE" : "REPETIR", "MENU"];
    }

    var _n = array_length(_labels);
    for (var _i = 0; _i < _n; _i++) {
        ui_button(panel_btn_x(_i, _n), panel_btn_y(_i, _n), _labels[_i], _sel == _i);
    }
    draw_set_font(-1);
}

function draw_attempt_text() {
    if (!instance_exists(obj_player)) return;

    draw_set_font(fnt_ui);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_alpha(0.9);
    draw_set_color(COL_WHITE);
    draw_text_transformed(obj_player.start_x + 220, GROUND_Y - 180,
                          "INTENTO " + string(global.attempts), 3, 3, 0);

    draw_set_alpha(1);
    draw_set_font(-1);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_color(c_white);
}