// configuracion del juego

// Información
#macro GAME_NAME		"Genetic Dash"
#macro GAME_VERSION		"0.1.0"

// paleta de colores
#macro COL_NIGHT	make_colour_rgb(20, 15, 45)		// #140F2D fondo
#macro COL_BLOCK	make_colour_rgb(91, 63, 168)	// #5B3FA8 bloques
#macro COL_CYAN		make_colour_rgb(61, 224, 255)	// #3DE0FF jugador
#macro COL_RED		make_colour_rgb(255, 59, 92)	// #FF3B5C peligro
#macro COL_YELLOW	make_colour_rgb(255, 210, 63)	// #FFD23F ayuda
#macro COL_MAGENTA	make_colour_rgb(255, 79, 216)	// #FF4FD8 nave
#macro COL_LIGHT	make_colour_rgb(138, 107, 255)	// #8A6BFF luz
#macro COL_SHADOW	make_colour_rgb(52, 36, 105)	// #342469 sombra
#macro COL_WHITE	make_colour_rgb(244, 241, 255)	// #F4F1FF brillos

// Paneles de fin
#macro PANEL_W			480
#macro PANEL_H			320
#macro PANEL_X			((VIEW_W - PANEL_W) / 2)
#macro PANEL_Y			((VIEW_H - PANEL_H) / 2)
#macro PANEL_INPUT_FR	15

// Botón de pausa
#macro PAUSE_BTN_S		40
#macro PAUSE_BTN_X		(VIEW_W - 56)
#macro PAUSE_BTN_Y		16

// Simulación
#macro FPS				60
#macro TILE				32

// Movimiento horizontal
#macro SPEED_NORMAL		5.54

// Modo cubo
#macro CUBE_GRAVITY		0.90
#macro CUBE_JUMP_VY		-11.0
#macro CUBE_MAX_FALL	15.0
#macro CUBE_HITBOX		32
#macro CUBE_ROT_SPEED	7.5

// Trampolín (pad)
#macro PAD_VY			-16.4

// Orbe de doble salto (orb)
#macro ORB_VY			-11.0
#macro INPUT_BUFFER_FR	8

// Modo nave
#macro SHIP_GRAVITY		0.35
#macro SHIP_THRUST		-0.70
#macro SHIP_MAX_VY		9.0

// Obstáculos
// Pua Normal
#macro SPIKE_HITBOX_W	6
#macro SPIKE_HITBOX_H	12

// Bloque
#macro BLOCK_TOP_KILLS	false
#macro BLOCK_TOLERANCE	6

// Pua pequeña
#macro SPIKE_SMALL_HITBOX_W	6
#macro SPIKE_SMALL_HITBOX_H	6


// Mundo
// tiene 15 filas el mundo
#macro LEVEL_ROWS		15

// el suelo ocupa dos filas
#macro GROUND_ROWS		2

// 17 tiles = 15 de nivel + 2 de suelo
#macro VIEW_W			960
#macro VIEW_H			544
#macro GROUND_Y			(LEVEL_ROWS * TILE)
#macro DEATH_DELAY_FR	45
#macro WORLD_TOP_Y		-2000

// Final de nivel
#macro WIN_STOP_DIST	192
#macro WIN_ANIM_FR		50
#macro WIN_SPIN			18

// Cámara
#macro CAM_PLAYER_X		288
#macro CAM_GROUND_SCR	381
#macro CAM_BASE_Y		(GROUND_Y - CAM_GROUND_SCR)
#macro CAM_TOP_BAND		109
#macro CAM_BOT_BAND		435
#macro CAM_SHIP_Y		0
#macro CAM_SETTLE_DEAD	96
#macro CAM_LERP_FOLLOW	0.20
#macro CAM_LERP_SETTLE	0.08
#macro CAM_END_MARGIN	0
#macro BG_PARALLAX_X	0.25 

// Niveles
#macro LEVEL_DIR		"levels/"
#macro LEVEL_EXT		".txt"
#macro LEVEL_COUNT		3
#macro LEVEL_END_PAD	10

// Enums
enum GAME_STATE		{ BOOT, MENU, PLAYING, DEAD, WON, WINNING, PAUSED}
enum PLAYER_MODE	{ CUBE, SHIP }
enum CONTROLLER		{ HUMAN, AI }
enum OBJ_TYPE		{ NONE = 0, SPIKE, BLOCK, PAD, ORB, PORTAL_SHIP, PORTAL_NORMAL, GOAL}

// Estado global (inicializamos todas las configuraciones iniciales)
function config_init() {
    global.game_state = GAME_STATE.BOOT;
    global.controller = CONTROLLER.HUMAN;
    global.current_level = 1;
    global.attempts = 0;
    global.fast_mode = false;
    global.music_volume = 0.7;
    global.sfx_volume = 1.0;
	global.death_pct = 0;
	global.bg_list = [spr_bg_1, spr_bg_2, spr_bg_3];
    global.music_list = [snd_music_1, snd_music_2, snd_music_3];
    global.music_handle = -1;
	global.level = { name: "", music: "1", speed: 1.0,
                     cols: 0, rows: 0, end_x: 0, width: VIEW_W};
	global.debug = true;
}