// Funciones de musica
function music_play(_i) {
    music_stop();
    if (global.fast_mode) return;

    var _idx = clamp(_i, 1, array_length(global.music_list)) - 1;
    global.music_handle = audio_play_sound(global.music_list[_idx], 10, true);
    audio_sound_gain(global.music_handle, global.music_volume, 0);
}

function music_stop() {
    if (global.music_handle != -1) {
        audio_stop_sound(global.music_handle);
        global.music_handle = -1;
    }
}

function sfx_play(_snd) {
    if (global.fast_mode) return;
    var _h = audio_play_sound(_snd, 5, false);
    audio_sound_gain(_h, global.sfx_volume, 0);
}