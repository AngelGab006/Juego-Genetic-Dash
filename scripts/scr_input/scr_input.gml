// Esta es la entrada del Input
// Devuelve un struct: { jump_pressed, jump_held }
function input_get() {
    // IA (si se implementa)
    if (global.controller == CONTROLLER.AI) {
        return global.ai_input;
    }

    // Humano
    var _pressed = keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_up) || mouse_check_button_pressed(mb_left);

    var _held = keyboard_check(vk_space) || keyboard_check(vk_up) || mouse_check_button(mb_left);

    return { jump_pressed: _pressed, jump_held: _held };
}