/// @description Initialize FBX Importer
// -- Initialize Systems --
fbx_vertex_formats_init();
ui_init();

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
p3d_models = [];
model_bbox = { x1: -1, y1: -1, z1: -1, x2: 1, y2: 1, z2: 1 };
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

// -- Debug Bounding Box VB Setup --
vertex_format_begin();
vertex_format_add_position_3d();
global.debug_box_format = vertex_format_end();
global.debug_box_vb = vertex_create_buffer();
vertex_begin(global.debug_box_vb, global.debug_box_format);
// A helper function to make adding lines cleaner
var _add_line = function(x1, y1, z1, x2, y2, z2) {
    vertex_position_3d(global.debug_box_vb, x1, y1, z1);
    vertex_position_3d(global.debug_box_vb, x2, y2, z2);
}
// Create a 1x1x1 unit cube centered at the origin (from -0.5 to +0.5)
var p = 0.5;
var n = -0.5;
// Bottom face
_add_line(n, n, n, p, n, n);
_add_line(p, n, n, p, p, n);
_add_line(p, p, n, n, p, n);
_add_line(n, p, n, n, n, n);
// Top face
_add_line(n, n, p, p, n, p);
_add_line(p, n, p, p, p, p);
_add_line(p, p, p, n, p, p);
_add_line(n, p, p, n, n, p);
// Vertical edges connecting top and bottom faces
_add_line(n, n, n, n, n, p);
_add_line(p, n, n, p, n, p);
_add_line(p, p, n, p, p, p);
_add_line(n, p, n, n, p, p);
vertex_end(global.debug_box_vb);
vertex_freeze(global.debug_box_vb);
placeholder_tex = sprite_get_texture(s_white_pixel, 0);