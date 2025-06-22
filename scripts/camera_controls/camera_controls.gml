/// @description script for camera controls
function camera_controls() {

    var mx = window_mouse_get_x();
    var my = window_mouse_get_y();
    var dx = mx - last_mouse_x;
    var dy = my - last_mouse_y;

    // Zoom with mouse wheel
    var wheel = mouse_wheel_down() - mouse_wheel_up();
    if (wheel != 0) {
        cam_dist = max(50, cam_dist * (1 - wheel * 0.1));
    }

    // Orbit with middle mouse button (all directions inverted)
    if (mouse_check_button(mb_middle)) {
        cam_yaw -= dx * 0.5; // Inverted from +=
        cam_pitch = clamp(cam_pitch + dy * 0.5, -89, 89); // Inverted from -=
    }
    
    // Pan with right mouse button (up/down inverted)
    if (mouse_check_button(mb_right)) {
        var mat_view = camera_get_view_mat(camera);
        var right_vec = [mat_view[0], mat_view[4], mat_view[8]];
        var up_vec = [mat_view[1], mat_view[5], mat_view[9]];
        
        var pan_speed = cam_dist / 500;
        
        // The sign for the 'dy' component is flipped here from - to +
        cam_target.x -= (right_vec[0] * dx + up_vec[0] * dy) * pan_speed;
        cam_target.y -= (right_vec[1] * dx + up_vec[1] * dy) * pan_speed;
        cam_target.z -= (right_vec[2] * dx + up_vec[2] * dy) * pan_speed;
    }

    // Update last mouse position
    last_mouse_x = mx;
    last_mouse_y = my;

    // Update camera matrix
    var cam_x = cam_target.x + lengthdir_x(cam_dist, cam_yaw) * dcos(cam_pitch);
    var cam_y = cam_target.y + lengthdir_y(cam_dist, cam_yaw) * dcos(cam_pitch);
    var cam_z = cam_target.z + lengthdir_z(cam_dist, cam_pitch);

    var fov = 60;
    var aspect = window_get_width() / window_get_height();
    camera_set_view_mat(camera, matrix_build_lookat(cam_x, cam_y, cam_z, cam_target.x, cam_target.y, cam_target.z, 0, 0, 1));
    camera_set_proj_mat(camera, matrix_build_projection_perspective_fov(fov, aspect, 1.0, 30000.0));
}