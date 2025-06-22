/// @description FBX Importer Step
camera_controls();
check_ui_clicks();

if (is_playing && current_animation != -1) {
    animation_time += (1 / room_speed) * animation_speed;
    // We'll add animation looping logic here later
}