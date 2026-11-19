mode       = PLAYER_MODE.CUBE;
vy         = 0;
on_ground  = false;
dead_timer = 0;
start_x    = x;
start_y    = y;
last_touch = noone;
jump_buffer = 0;
mask_index = spr_player_cube;
input_lock = 0;
visual_angle = 0;

// camara
cam_y     = CAM_BASE_Y;
win_timer = 0;
win_x0    = 0;
win_y0    = 0;
win_tx    = 0;
win_ty    = 0;