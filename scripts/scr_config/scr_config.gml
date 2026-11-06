// configuracion del juego

// Información
#macro GAME_NAME        "Genetic Dash"
#macro GAME_VERSION     "0.1.0"

// Simulación
#macro FPS              60
#macro TILE             32

// Movimiento horizontal
#macro SPEED_NORMAL     5.54

// Modo cubo
#macro CUBE_GRAVITY     0.90
#macro CUBE_JUMP_VY    -11.0
#macro CUBE_MAX_FALL    15.0
#macro CUBE_HITBOX      32

// Trampolín (pad)
#macro PAD_VY          -15.0

// Orbe de doble salto (orb)
#macro ORB_VY          -11.0
#macro ORB_RADIUS       20
#macro INPUT_BUFFER_FR  6

// Modo nave
#macro SHIP_GRAVITY     0.45
#macro SHIP_THRUST     -0.80
#macro SHIP_MAX_VY      7.0
#macro SHIP_HITBOX_W    28
#macro SHIP_HITBOX_H    20

// Obstáculos
#macro SPIKE_HITBOX_W   6
#macro SPIKE_HITBOX_H   12
#macro BLOCK_TOP_KILLS  false
#macro BLOCK_TOLERANCE  6

// Mundo
// tiene 15 filas el mundo
#macro LEVEL_ROWS       15
// el suelo ocupa dos filas
#macro GROUND_ROWS      2
#macro VIEW_W           960
// 17 tiles = 15 de nivel + 2 de suelo
#macro VIEW_H           544
#macro CAM_PLAYER_X     240
#macro GROUND_Y (LEVEL_ROWS * TILE)

// Niveles
#macro LEVEL_DIR        "levels/"
#macro LEVEL_EXT        ".txt"
#macro LEVEL_COUNT      3

// IA / Entorno
#macro AI_LOOKAHEAD     6
#macro AI_OBS_SIZE      (4 + AI_LOOKAHEAD * 3)
#macro AI_MAX_STEPS     6000
#macro AI_FAST_STEPS    20
#macro AI_REWARD_DEATH -1.0

// Enums
enum GAME_STATE { BOOT, MENU, PLAYING, DEAD, WON }
enum PLAYER_MODE { CUBE, SHIP }
enum CONTROLLER { HUMAN, AI }
enum OBJ_TYPE { NONE = 0, SPIKE, BLOCK, PAD, ORB, PORTAL_SHIP, PORTAL_NORMAL }

// Estado global (inicializamos todas las configuraciones iniciales)
function config_init() {
    global.game_state    = GAME_STATE.BOOT;
    global.controller    = CONTROLLER.HUMAN;
    global.current_level = 1;
    global.attempts      = 0;
    global.fast_mode     = false;
    global.music_volume  = 0.7;
    global.sfx_volume    = 1.0;
}