var _cx = x - CAM_PLAYER_X;
_cx = clamp(_cx, 0, max(0, global.level.width - VIEW_W));
camera_set_view_pos(view_camera[0], _cx, 0);