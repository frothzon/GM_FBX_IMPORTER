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

gpu_set_ztestenable(false);
gpu_set_zwriteenable(false);
gpu_set_cullmode(cull_noculling);

camera_apply(view_camera[0]); // Reset for GUI drawing at 2D