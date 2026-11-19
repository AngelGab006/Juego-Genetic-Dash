// Arranque: de rm_boot pasamos al menú
if (room == rm_boot) {
    game_go_menu();
}

// Herramientas de desarrollo (se ocultan con F1)
if (keyboard_check_pressed(vk_f1)) global.debug = !global.debug;

// Full screen
if (keyboard_check_pressed(vk_f11)) {
    window_set_fullscreen(!window_get_fullscreen());
}

// Pausa (ESC, P o el botón II)
if (room == rm_game && !global.fast_mode) {
    var _key   = keyboard_check_pressed(vk_escape) || keyboard_check_pressed(ord("P"));
    var _click = mouse_check_button_pressed(mb_left) && pause_button_over();

    if (global.game_state == GAME_STATE.PLAYING && (_key || _click)) {
        game_pause();
    } else if (global.game_state == GAME_STATE.PAUSED && _key) {
        game_resume();
    }
}

// Paneles (pausa / victoria) 
var _kind = ui_panel_kind();
if (_kind != end_prev) {
    end_sel   = 0;
    end_prev  = _kind;
    end_delay = PANEL_INPUT_FR;
}
if (end_delay > 0) end_delay--;

if (_kind != 0) {
    var _n  = (_kind == 1) ? 3 : 2;
    var _mx = device_mouse_x_to_gui(0);
    var _my = device_mouse_y_to_gui(0);

    var _hover = -1;
    for (var _i = 0; _i < _n; _i++) {
        if (ui_button_hit(panel_btn_x(_i, _n), panel_btn_y(_i, _n), _mx, _my)) _hover = _i;
    }

    // Teclado: arriba/izquierda = anterior, abajo/derecha = siguiente
    if (keyboard_check_pressed(vk_up) || keyboard_check_pressed(vk_left)
        || keyboard_check_pressed(ord("W")) || keyboard_check_pressed(ord("A"))) {
        end_sel = (end_sel - 1 + _n) mod _n;
    }
    if (keyboard_check_pressed(vk_down) || keyboard_check_pressed(vk_right)
        || keyboard_check_pressed(ord("S")) || keyboard_check_pressed(ord("D"))) {
        end_sel = (end_sel + 1) mod _n;
    }

    // Mouse: el hover solo selecciona si el mouse se movió
    if (_hover != -1 && (_mx != end_mx || _my != end_my)) end_sel = _hover;
    end_mx = _mx;
    end_my = _my;

    // Activar (con un breve retardo para evitar clics accidentales)
    var _act = -1;
    if (end_delay <= 0) {
        if (keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space)) _act = end_sel;
        if (mouse_check_button_pressed(mb_left) && _hover != -1) _act = _hover;
    }
    if (_act != -1) panel_activate(_kind, _act);
}