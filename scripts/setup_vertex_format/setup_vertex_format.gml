function setup_vertex_format(){
	gml_pragma("global", "setup_vertex_format()");

	vertex_format_begin();
	vertex_format_add_position_3d();
	vertex_format_add_normal();
	vertex_format_add_texcoord();
	vertex_format_add_color();
	global.VERTEX_FORMAT = vertex_format_end();
	
	/// save models so we don't need to load the same one multiple times
	global.MODEL_CACHE = {};
	
	/// save basic shapes
	var vb_cube = start_vertex_buffer_model();
	var dx = 1 / 2;
	var dy = 1 / 2;
	var dz = 1 / 2;
	vertex_add_cube(vb_cube, -dx, -dy, -dz, dx, dy, dz, c_white, 1);
	finish_vertex_buffer_model(vb_cube);
	
	var vb_sphere = start_vertex_buffer_model();
	var dr = 1 / 2;
	vertex_add_sphere(vb_sphere, 10, 10, 1, 1, dr);
	finish_vertex_buffer_model(vb_sphere);
	
	var vb_wall = start_vertex_buffer_model();
	vertex_add_wall(vb_wall, -dx, -dy, -dz, dx, dy, dz, c_white, 1);
	finish_vertex_buffer_model(vb_wall);
	
	var vb_floor = start_vertex_buffer_model();
	vertex_add_floor(vb_floor, -dx, -dy, -dz, dx, dy, dz, c_white, 1);
	finish_vertex_buffer_model(vb_floor);
	
	/// global space for the basic models
	global.BASIC_MODEL = {
		cube: vb_cube,
		sphere: vb_sphere,
		wall: vb_wall,
		plane: vb_floor
	}
}