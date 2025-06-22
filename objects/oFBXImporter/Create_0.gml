/// @description Initialize FBX Importer
// -- Window and GUI Setup --
width = 1280;
height = 720;
window_set_size(width, height);
surface_resize(application_surface, width, height);
display_set_gui_size(width, height);
window_center();

// -- 3D Camera Initialization --
camera = camera_create();
view_camera[0] = camera;

// Camera position and orientation
cam_dist = 200;
cam_pitch = 30;
cam_yaw = -45;
cam_target = { x: 0, y: 0, z: 0 };

// Mouse controls for camera
mouse_start_x = 0;
mouse_start_y = 0;
last_mouse_x = 0;
last_mouse_y = 0;

// -- Importer State --
fbx_model = -1; // Will hold the imported model data structure
is_loading = false;
animation_names = [];
current_animation = -1;
animation_time = 0;
animation_speed = 1;
is_playing = false;

// -- UI State --
show_ui = true;
button_height = 24;
dropdown_open = false;
dropdown_options = [];
dropdown_selected = -1;

// -- Grid and Debug VB Setup --
vertex_format_begin();
vertex_format_add_position_3d();
global.grid_format = vertex_format_end();

var grid_size = 1000;
global.grid_vb = vertex_create_buffer();
vertex_begin(global.grid_vb, global.grid_format);
vertex_position_3d(global.grid_vb, 0, -grid_size, 0);
vertex_position_3d(global.grid_vb, 0, grid_size, 0);
vertex_end(global.grid_vb);