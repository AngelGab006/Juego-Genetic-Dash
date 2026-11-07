// Cargador de niveles.

// Carácter de cada objeto
function level_char_to_asset(_ch) {
    switch (_ch) {
        case "^": return obj_spike;
        case "v": return obj_spike;          // púa invertida
        case "#": return obj_block;
        // T10: case "=": return obj_pad;
        // T11: case "o": return obj_orb;
        // T12: case "S": return obj_portal_ship;
        // T12: case "N": return obj_portal_normal;
        // T13: case "E": return obj_goal;
    }
    return -1;
}

function level_load(_n) {
    var _path = working_directory + LEVEL_DIR + "level_" + string(_n) + LEVEL_EXT;

    if (!file_exists(_path)) {
        show_debug_message("LEVEL ERROR: no existe " + _path);
        return false;
    }

    // Leer el archivo
    var _rows = [];
    var _meta = { name: "Nivel " + string(_n), music: string(_n), speed: "1.0" };

    var _f = file_text_open_read(_path);
    while (!file_text_eof(_f)) {
        var _line = file_text_read_string(_f);
        file_text_readln(_f);

        _line = string_replace_all(_line, "\r", "");
        _line = string_replace_all(_line, " ", "");
        if (string_length(_line) == 0) continue;

        if (string_char_at(_line, 1) == ";") {
            var _p = string_pos("=", _line);
            if (_p > 2) {
                var _key = string_copy(_line, 2, _p - 2);
                var _val = string_copy(_line, _p + 1, string_length(_line) - _p);
                _meta[$ _key] = _val;
            }
        } else {
            array_push(_rows, _line);
        }
    }
    file_text_close(_f);

    // Validar, que siga las reglas
    if (array_length(_rows) != LEVEL_ROWS) {
        show_debug_message("LEVEL ERROR: tiene " + string(array_length(_rows))
            + " filas y deben ser " + string(LEVEL_ROWS));
        return false;
    }

    var _cols = 0;
    for (var _r = 0; _r < LEVEL_ROWS; _r++) {
        _cols = max(_cols, string_length(_rows[_r]));
    }
    for (var _r = 0; _r < LEVEL_ROWS; _r++) {
        if (string_length(_rows[_r]) != _cols) {
            show_debug_message("LEVEL AVISO: la fila " + string(_r + 1)
                + " mide " + string(string_length(_rows[_r]))
                + " y deberia medir " + string(_cols));
        }
    }

    // Guardar datos del nivel
    global.level = {
        name:  _meta.name,
        music: _meta.music,
        speed: real(_meta.speed),
        cols:  _cols,
        rows:  LEVEL_ROWS,
        end_x: _cols * TILE,
        width: (_cols + LEVEL_END_PAD) * TILE
    };

    // Crear los objetos
    var _count = 0;
    var _unknown = {};
    for (var _r = 0; _r < LEVEL_ROWS; _r++) {
        for (var _c = 1; _c <= _cols; _c++) {
            var _ch = string_char_at(_rows[_r], _c);
            if (_ch == ".") continue;

            var _x = (_c - 1) * TILE;
            var _y = _r * TILE;

            if (_ch == "E") global.level.end_x = _x;

            var _asset = level_char_to_asset(_ch);
            if (_asset == -1) {
				// aún no implementado: se omite
                _unknown[$ _ch] = true;
                continue;
            }

            if (_ch == "v") {
                // Invertida: con origen Top Left se voltea y baja un tile
                var _inv = instance_create_layer(_x, _y + TILE, "Instances", _asset);
                _inv.image_yscale = -1;
            } else {
                instance_create_layer(_x, _y, "Instances", _asset);
            }
            _count++;
        }
    }

    // Jugador al inicio
    instance_create_layer(CAM_PLAYER_X, GROUND_Y - CUBE_HITBOX / 2,
                          "Instances", obj_player);

    // Avisar de los caracteres que aún no tienen objeto
    var _chars = struct_get_names(_unknown);
    for (var _i = 0; _i < array_length(_chars); _i++) {
        show_debug_message("LEVEL AVISO: '" + _chars[_i] + "' aun no tiene objeto, se omite");
    }

    show_debug_message("LEVEL OK: " + global.level.name + " ("
        + string(_cols) + " columnas, " + string(_count) + " objetos creados)");
		return true
}