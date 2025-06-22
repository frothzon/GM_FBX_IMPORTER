/// @description Draw 3D scene and GUI
// -- Draw 3D Scene --
gpu_set_ztestenable(true);
gpu_set_zwriteenable(true);
gpu_set_cullmode(cull_counterclockwise);

// Clear the background
draw_clear_alpha(c_dkgray, 1.0);

// Set up 3D projection
camera_apply(camera);

// Draw the grid
draw_grid();

// -- Draw GUI --
gpu_set_ztestenable(false);
gpu_set_zwriteenable(false);
gpu_set_cullmode(cull_noculling);

camera_apply(view_camera[0]); // Reset for GUI drawing at 2D

if (show_ui) {
    // We will draw UI elements here in a later phase.
    // For now, let's just show some debug text.
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_font(font_0);
    draw_set_color(c_white);
    
    draw_text(10, 10, "FBX Importer");
    draw_text(10, 30, "Middle Mouse: Orbit");
    draw_text(10, 50, "Right Mouse: Pan");
    draw_text(10, 70, "Mouse Wheel: Zoom");
}