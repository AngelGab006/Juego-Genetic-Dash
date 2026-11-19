function camera_follow_player() {
    var _max_x = max(0, level_goal_x() - VIEW_W + CAM_END_MARGIN);
    var _cx = clamp(x - CAM_PLAYER_X, 0, _max_x);

    var _target = cam_y;
    var _k = CAM_LERP_FOLLOW;

    if (mode == PLAYER_MODE.SHIP) {
        _target = CAM_SHIP_Y;
        _k = CAM_LERP_SETTLE;
    } else {
        var _sy = y - cam_y;

        if (_sy < CAM_TOP_BAND) {
            _target = y - CAM_TOP_BAND;
        } else if (_sy > CAM_BOT_BAND) {
            _target = y - CAM_BOT_BAND;
        } else if (on_ground) {
            var _rest = min((y + CUBE_HITBOX / 2) - CAM_GROUND_SCR, CAM_BASE_Y);
            if (abs(_rest - cam_y) > CAM_SETTLE_DEAD || _rest == CAM_BASE_Y) {
                _target = _rest;
                _k = CAM_LERP_SETTLE;
            }
        }

        _target = min(_target, CAM_BASE_Y);
    }

    cam_y += (_target - cam_y) * _k;
    camera_set_view_pos(view_camera[0], _cx, cam_y);
}