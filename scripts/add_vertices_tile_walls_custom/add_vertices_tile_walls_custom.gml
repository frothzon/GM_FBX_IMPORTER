/// Create P3D model and populate vertex information
/// Fill vertex,  normals,  texture,  color,  alpha
function add_vertices_custom_tileset_tall__walls_1(_model,  _dx,  _dy,  _dz){

	_model.vert_list = array_concat(_model.vert_list, [[_dx + 0, _dy - 16, _dz + 0], [_dx + 0, _dy - 16, _dz - 32], [_dx + 0, _dy - 8, _dz + 0], [_dx + 0, _dy - 8, _dz - 32], [_dx + 0, _dy - 8, _dz + 0], [_dx + 0, _dy - 16, _dz - 32], [_dx + 0, _dy - 8, _dz + 0], [_dx + 0, _dy - 8, _dz - 32], [_dx - 3.20, _dy - 3.20, _dz + 0], [_dx - 3.20, _dy - 3.20, _dz - 32], [_dx - 3.20, _dy - 3.20, _dz + 0], [_dx + 0, _dy - 8, _dz - 32], [_dx - 3.20, _dy - 3.20, _dz + 0], [_dx - 3.20, _dy - 3.20, _dz - 32], [_dx - 8, _dy + 0, _dz + 0], [_dx - 8, _dy + 0, _dz - 32], [_dx - 8, _dy + 0, _dz + 0], [_dx - 3.20, _dy - 3.20, _dz - 32], [_dx - 8, _dy + 0, _dz + 0], [_dx - 8, _dy + 0, _dz - 32], [_dx - 16, _dy + 0, _dz + 0], [_dx - 16, _dy + 0, _dz - 32], [_dx - 16, _dy + 0, _dz + 0], [_dx - 8, _dy + 0, _dz - 32]]);
	_model.norm_list = array_concat(_model.norm_list,  [[ -1, 0, 0 ], [ -1, 0, 0 ], [ -0.98, -0.19, 0 ], [ -0.92, -0.38, 0 ], [ -0.98, -0.19, 0 ], [ -1, 0, 0 ], [ -0.98, -0.19, 0 ], [ -0.92, -0.38, 0 ], [ -0.75, -0.66, 0 ], [ -0.66, -0.75, 0 ], [ -0.75, -0.66, 0 ], [ -0.92, -0.38, 0 ], [ -0.75, -0.66, 0 ], [ -0.66, -0.75, 0 ], [ -0.38, -0.92, 0 ], [ -0.19, -0.98, 0 ], [ -0.38, -0.92, 0 ], [ -0.66, -0.75, 0 ], [ -0.38, -0.92, 0 ], [ -0.19, -0.98, 0 ], [ 0, -1, 0 ], [ 0, -1, 0 ], [ 0, -1, 0 ], [ -0.19, -0.98, 0 ]]);
	_model.tex_list = array_concat(_model.tex_list,  [[ 0.50, 0.00 ], [ 0.50, 0.50 ], [ 0.63, 0.00 ], [ 0.63, 0.50 ], [ 0.63, 0.00 ], [ 0.50, 0.50 ], [ 0.63, 0.00 ], [ 0.63, 0.50 ], [ 0.75, 0.00 ], [ 0.75, 0.50 ], [ 0.75, 0.00 ], [ 0.63, 0.50 ], [ 0.75, 0.00 ], [ 0.75, 0.50 ], [ 0.86, 0.00 ], [ 0.86, 0.50 ], [ 0.86, 0.00 ], [ 0.75, 0.50 ], [ 0.86, 0.00 ], [ 0.86, 0.50 ], [ 1.00, 0.00 ], [ 1.00, 0.50 ], [ 1.00, 0.00 ], [ 0.86, 0.50 ]]);
	_model.col_list = array_concat(_model.col_list,  [c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white]);
	_model.alpha_list = array_concat(_model.alpha_list,  [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]);

}


/// Create P3D model and populate vertex information
/// Fill vertex,  normals,  texture,  color,  alpha
function add_vertices_custom_tileset_tall__walls_2(_model,  _dx,  _dy,  _dz){

	_model.vert_list = array_concat(_model.vert_list, [[_dx + 16, _dy + 0, _dz + 0], [_dx + 16, _dy + 0, _dz - 32], [_dx + 8, _dy + 0, _dz + 0], [_dx + 8, _dy + 0, _dz - 32], [_dx + 8, _dy + 0, _dz + 0], [_dx + 16, _dy + 0, _dz - 32], [_dx + 8, _dy + 0, _dz + 0], [_dx + 8, _dy + 0, _dz - 32], [_dx + 3.20, _dy - 3.20, _dz + 0], [_dx + 3.20, _dy - 3.20, _dz - 32], [_dx + 3.20, _dy - 3.20, _dz + 0], [_dx + 8, _dy + 0, _dz - 32], [_dx + 3.20, _dy - 3.20, _dz + 0], [_dx + 3.20, _dy - 3.20, _dz - 32], [_dx + 0, _dy - 8, _dz + 0], [_dx + 0, _dy - 8, _dz - 32], [_dx + 0, _dy - 8, _dz + 0], [_dx + 3.20, _dy - 3.20, _dz - 32], [_dx + 0, _dy - 8, _dz + 0], [_dx + 0, _dy - 8, _dz - 32], [_dx + 0, _dy - 16, _dz + 0], [_dx + 0, _dy - 16, _dz - 32], [_dx + 0, _dy - 16, _dz + 0], [_dx + 0, _dy - 8, _dz - 32]]);
	_model.norm_list = array_concat(_model.norm_list,  [[ 0, -1, 0 ], [ 0, -1, 0 ], [ 0.19, -0.98, 0 ], [ 0.38, -0.92, 0 ], [ 0.19, -0.98, 0 ], [ 0, -1, 0 ], [ 0.19, -0.98, 0 ], [ 0.38, -0.92, 0 ], [ 0.66, -0.75, 0 ], [ 0.75, -0.66, 0 ], [ 0.66, -0.75, 0 ], [ 0.38, -0.92, 0 ], [ 0.66, -0.75, 0 ], [ 0.75, -0.66, 0 ], [ 0.92, -0.38, 0 ], [ 0.98, -0.19, 0 ], [ 0.92, -0.38, 0 ], [ 0.75, -0.66, 0 ], [ 0.92, -0.38, 0 ], [ 0.98, -0.19, 0 ], [ 1, 0, 0 ], [ 1, 0, 0 ], [ 1, 0, 0 ], [ 0.98, -0.19, 0 ]]);
	_model.tex_list = array_concat(_model.tex_list,  [[ 0.50, 0.00 ], [ 0.50, 0.50 ], [ 0.63, 0.00 ], [ 0.63, 0.50 ], [ 0.63, 0.00 ], [ 0.50, 0.50 ], [ 0.63, 0.00 ], [ 0.63, 0.50 ], [ 0.75, 0.00 ], [ 0.75, 0.50 ], [ 0.75, 0.00 ], [ 0.63, 0.50 ], [ 0.75, 0.00 ], [ 0.75, 0.50 ], [ 0.87, 0.00 ], [ 0.87, 0.50 ], [ 0.87, 0.00 ], [ 0.75, 0.50 ], [ 0.87, 0.00 ], [ 0.87, 0.50 ], [ 1.00, 0.00 ], [ 1.00, 0.50 ], [ 1.00, 0.00 ], [ 0.87, 0.50 ]]);
	_model.col_list = array_concat(_model.col_list,  [c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white]);
	_model.alpha_list = array_concat(_model.alpha_list,  [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]);

}

/// Create P3D model and populate vertex information
/// Fill vertex,  normals,  texture,  color,  alpha
function add_vertices_custom_tileset_tall__walls_3(_model,  _dx,  _dy,  _dz){

	_model.vert_list = array_concat(_model.vert_list, [[_dx + 16, _dy + 0, _dz + 0], [_dx + 16, _dy + 0, _dz - 32], [_dx - 16, _dy + 0, _dz + 0], [_dx - 16, _dy + 0, _dz - 32], [_dx - 16, _dy + 0, _dz + 0], [_dx + 16, _dy + 0, _dz - 32]]);
	_model.norm_list = array_concat(_model.norm_list,  [[ 0, -1, 0 ], [ 0, -1, 0 ], [ 0, -1, 0 ], [ 0, -1, 0 ], [ 0, -1, 0 ], [ 0, -1, 0 ]]);
	_model.tex_list = array_concat(_model.tex_list,  [[ 0.50, 0.00 ], [ 0.50, 0.50 ], [ 1.00, 0.00 ], [ 1.00, 0.50 ], [ 1.00, 0.00 ], [ 0.50, 0.50 ]]);
	_model.col_list = array_concat(_model.col_list,  [c_white, c_white, c_white, c_white, c_white, c_white]);
	_model.alpha_list = array_concat(_model.alpha_list,  [1, 1, 1, 1, 1, 1]);

}

/// Create P3D model and populate vertex information
/// Fill vertex,  normals,  texture,  color,  alpha
function add_vertices_custom_tileset_tall__walls_4(_model,  _dx,  _dy,  _dz){

	_model.vert_list = array_concat(_model.vert_list, [[_dx - 16, _dy + 0.00, _dz + 0], [_dx - 16, _dy + 0.00, _dz - 32], [_dx - 8, _dy + 0.00, _dz + 0], [_dx - 8, _dy + 0.00, _dz - 32], [_dx - 8, _dy + 0.00, _dz + 0], [_dx - 16, _dy + 0.00, _dz - 32], [_dx - 8, _dy + 0.00, _dz + 0], [_dx - 8, _dy + 0.00, _dz - 32], [_dx - 3.20, _dy + 3.20, _dz + 0], [_dx - 3.20, _dy + 3.20, _dz - 32], [_dx - 3.20, _dy + 3.20, _dz + 0], [_dx - 8, _dy + 0.00, _dz - 32], [_dx - 3.20, _dy + 3.20, _dz + 0], [_dx - 3.20, _dy + 3.20, _dz - 32], [_dx + 0, _dy + 8, _dz + 0], [_dx + 0, _dy + 8, _dz - 32], [_dx + 0, _dy + 8, _dz + 0], [_dx - 3.20, _dy + 3.20, _dz - 32], [_dx + 0, _dy + 8, _dz + 0], [_dx + 0, _dy + 8, _dz - 32], [_dx + 0, _dy + 16, _dz + 0], [_dx + 0, _dy + 16, _dz - 32], [_dx + 0, _dy + 16, _dz + 0], [_dx + 0, _dy + 8, _dz - 32]]);
	_model.norm_list = array_concat(_model.norm_list,  [[ 0, 1, 0 ], [ 0, 1, 0 ], [ -0.19, 0.98, 0 ], [ -0.38, 0.92, 0 ], [ -0.19, 0.98, 0 ], [ 0, 1, 0 ], [ -0.19, 0.98, 0 ], [ -0.38, 0.92, 0 ], [ -0.66, 0.75, 0 ], [ -0.75, 0.66, 0 ], [ -0.66, 0.75, 0 ], [ -0.38, 0.92, 0 ], [ -0.66, 0.75, 0 ], [ -0.75, 0.66, 0 ], [ -0.92, 0.38, 0 ], [ -0.98, 0.19, 0 ], [ -0.92, 0.38, 0 ], [ -0.75, 0.66, 0 ], [ -0.92, 0.38, 0 ], [ -0.98, 0.19, 0 ], [ -1, 0, 0 ], [ -1, 0, 0 ], [ -1, 0, 0 ], [ -0.98, 0.19, 0 ]]);
	_model.tex_list = array_concat(_model.tex_list,  [[ 0.50, 0.00 ], [ 0.50, 0.50 ], [ 0.65, 0.00 ], [ 0.65, 0.50 ], [ 0.65, 0.00 ], [ 0.50, 0.50 ], [ 0.65, 0.00 ], [ 0.65, 0.50 ], [ 0.75, 0.00 ], [ 0.75, 0.50 ], [ 0.75, 0.00 ], [ 0.65, 0.50 ], [ 0.75, 0.00 ], [ 0.75, 0.50 ], [ 0.85, 0.00 ], [ 0.85, 0.50 ], [ 0.85, 0.00 ], [ 0.75, 0.50 ], [ 0.85, 0.00 ], [ 0.85, 0.50 ], [ 1.00, 0.00 ], [ 1.00, 0.50 ], [ 1.00, 0.00 ], [ 0.85, 0.50 ]]);
	_model.col_list = array_concat(_model.col_list,  [c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white]);
	_model.alpha_list = array_concat(_model.alpha_list,  [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]);

}

/// Create P3D model and populate vertex information
/// Fill vertex,  normals,  texture,  color,  alpha
function add_vertices_custom_tileset_tall__walls_5(_model,  _dx,  _dy,  _dz){

	_model.vert_list = array_concat(_model.vert_list, [[_dx + 0.00, _dy - 16, _dz + 0], [_dx + 0.00, _dy - 16, _dz - 32], [_dx - 0.00, _dy + 16, _dz + 0], [_dx - 0.00, _dy + 16, _dz - 32], [_dx - 0.00, _dy + 16, _dz + 0], [_dx + 0.00, _dy - 16, _dz - 32]]);
	_model.norm_list = array_concat(_model.norm_list,  [[ -1, -0.00, 0 ], [ -1, -0.00, 0 ], [ -1, -0.00, 0 ], [ -1, -0.00, 0 ], [ -1, -0.00, 0 ], [ -1, -0.00, 0 ]]);
	_model.tex_list = array_concat(_model.tex_list,  [[ 0.50, 0.00 ], [ 0.50, 0.50 ], [ 1.00, 0.00 ], [ 1.00, 0.50 ], [ 1.00, 0.00 ], [ 0.50, 0.50 ]]);
	_model.col_list = array_concat(_model.col_list,  [c_white, c_white, c_white, c_white, c_white, c_white]);
	_model.alpha_list = array_concat(_model.alpha_list,  [1, 1, 1, 1, 1, 1]);

}

/// Create P3D model and populate vertex information
/// Fill vertex,  normals,  texture,  color,  alpha
function add_vertices_custom_tileset_tall__walls_6(_model,  _dx,  _dy,  _dz){

	_model.vert_list = array_concat(_model.vert_list, [[_dx + 16, _dy + 0.00, _dz + 0], [_dx + 16, _dy + 0.00, _dz - 32], [_dx + 8, _dy + 0.00, _dz + 0], [_dx + 8, _dy + 0.00, _dz - 32], [_dx + 8, _dy + 0.00, _dz + 0], [_dx + 16, _dy + 0.00, _dz - 32], [_dx + 0, _dy + 8, _dz + 0], [_dx + 0, _dy + 8, _dz - 32], [_dx + 0, _dy + 16, _dz + 0], [_dx + 0, _dy + 16, _dz - 32], [_dx + 0, _dy + 16, _dz + 0], [_dx + 0, _dy + 8, _dz - 32], [_dx + 8, _dy + 0.00, _dz + 0], [_dx + 8, _dy + 0.00, _dz - 32], [_dx + 0, _dy + 8, _dz + 0], [_dx + 0, _dy + 8, _dz - 32], [_dx + 0, _dy + 8, _dz + 0], [_dx + 8, _dy + 0.00, _dz - 32], [_dx - 16, _dy - 0.00, _dz + 0], [_dx - 16, _dy - 0.00, _dz - 32], [_dx - 8, _dy - 0.00, _dz + 0], [_dx - 8, _dy - 0.00, _dz - 32], [_dx - 8, _dy - 0.00, _dz + 0], [_dx - 16, _dy - 0.00, _dz - 32], [_dx + 0, _dy - 8, _dz + 0], [_dx + 0, _dy - 8, _dz - 32], [_dx + 0, _dy - 16, _dz + 0], [_dx + 0, _dy - 16, _dz - 32], [_dx + 0, _dy - 16, _dz + 0], [_dx + 0, _dy - 8, _dz - 32], [_dx - 8, _dy - 0.00, _dz + 0], [_dx - 8, _dy - 0.00, _dz - 32], [_dx + 0, _dy - 8, _dz + 0], [_dx + 0, _dy - 8, _dz - 32], [_dx + 0, _dy - 8, _dz + 0], [_dx - 8, _dy - 0.00, _dz - 32]]);
	_model.norm_list = array_concat(_model.norm_list,  [[ 0.00, -1, 0 ], [ 0.00, -1, 0 ], [ 0.00, -1, 0 ], [ 0.00, -1, 0 ], [ 0.00, -1, 0 ], [ 0.00, -1, 0 ], [ -1, 0, 0 ], [ -1, 0, 0 ], [ -1, 0, 0 ], [ -1, 0, 0 ], [ -1, 0, 0 ], [ -1, 0, 0 ], [ -0.71, -0.71, 0 ], [ -0.71, -0.71, 0 ], [ -0.71, -0.71, 0 ], [ -0.71, -0.71, 0 ], [ -0.71, -0.71, 0 ], [ -0.71, -0.71, 0 ], [ -0.00, 1, 0 ], [ -0.00, 1, 0 ], [ -0.00, 1, 0 ], [ -0.00, 1, 0 ], [ -0.00, 1, 0 ], [ -0.00, 1, 0 ], [ 1, 0, 0 ], [ 1, 0, 0 ], [ 1, 0, 0 ], [ 1, 0, 0 ], [ 1, 0, 0 ], [ 1, 0, 0 ], [ 0.71, 0.71, 0 ], [ 0.71, 0.71, 0 ], [ 0.71, 0.71, 0 ], [ 0.71, 0.71, 0 ], [ 0.71, 0.71, 0 ], [ 0.71, 0.71, 0 ]]);
	_model.tex_list = array_concat(_model.tex_list,  [[ 0.50, 0.00 ], [ 0.50, 0.50 ], [ 0.62, 0.00 ], [ 0.62, 0.50 ], [ 0.62, 0.00 ], [ 0.50, 0.50 ], [ 0.89, 0.00 ], [ 0.89, 0.50 ], [ 1.00, 0.00 ], [ 1.00, 0.50 ], [ 1.00, 0.00 ], [ 0.89, 0.50 ], [ 0.62, 0.00 ], [ 0.62, 0.50 ], [ 0.89, 0.00 ], [ 0.89, 0.50 ], [ 0.89, 0.00 ], [ 0.62, 0.50 ], [ 0.50, 0.00 ], [ 0.50, 0.50 ], [ 0.62, 0.00 ], [ 0.62, 0.50 ], [ 0.62, 0.00 ], [ 0.50, 0.50 ], [ 0.89, 0.00 ], [ 0.89, 0.50 ], [ 1.00, 0.00 ], [ 1.00, 0.50 ], [ 1.00, 0.00 ], [ 0.89, 0.50 ], [ 0.62, 0.00 ], [ 0.62, 0.50 ], [ 0.89, 0.00 ], [ 0.89, 0.50 ], [ 0.89, 0.00 ], [ 0.62, 0.50 ]]);
	_model.col_list = array_concat(_model.col_list,  [c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white]);
	_model.alpha_list = array_concat(_model.alpha_list,  [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]);

}


/// Create P3D model and populate vertex information
/// Fill vertex,  normals,  texture,  color,  alpha
function add_vertices_custom_tileset_tall__walls_7(_model,  _dx,  _dy,  _dz){

	_model.vert_list = array_concat(_model.vert_list, [[_dx + 16, _dy + 0, _dz + 0], [_dx + 16, _dy + 0, _dz - 32], [_dx + 8, _dy + 0, _dz + 0], [_dx + 8, _dy + 0, _dz - 32], [_dx + 8, _dy + 0, _dz + 0], [_dx + 16, _dy + 0, _dz - 32], [_dx + 8, _dy + 0, _dz + 0], [_dx + 8, _dy + 0, _dz - 32], [_dx + 3.20, _dy + 3.20, _dz + 0], [_dx + 3.20, _dy + 3.20, _dz - 32], [_dx + 3.20, _dy + 3.20, _dz + 0], [_dx + 8, _dy + 0, _dz - 32], [_dx + 3.20, _dy + 3.20, _dz + 0], [_dx + 3.20, _dy + 3.20, _dz - 32], [_dx + 0.00, _dy + 8, _dz + 0], [_dx + 0.00, _dy + 8, _dz - 32], [_dx + 0.00, _dy + 8, _dz + 0], [_dx + 3.20, _dy + 3.20, _dz - 32], [_dx + 0.00, _dy + 8, _dz + 0], [_dx + 0.00, _dy + 8, _dz - 32], [_dx + 0.00, _dy + 16, _dz + 0], [_dx + 0.00, _dy + 16, _dz - 32], [_dx + 0.00, _dy + 16, _dz + 0], [_dx + 0.00, _dy + 8, _dz - 32]]);
	_model.norm_list = array_concat(_model.norm_list,  [[ 0, -1, 0 ], [ 0, -1, 0 ], [ -0.19, -0.98, 0 ], [ -0.38, -0.92, 0 ], [ -0.19, -0.98, 0 ], [ 0, -1, 0 ], [ -0.19, -0.98, 0 ], [ -0.38, -0.92, 0 ], [ -0.66, -0.75, 0 ], [ -0.75, -0.66, 0 ], [ -0.66, -0.75, 0 ], [ -0.38, -0.92, 0 ], [ -0.66, -0.75, 0 ], [ -0.75, -0.66, 0 ], [ -0.92, -0.38, 0 ], [ -0.98, -0.19, 0 ], [ -0.92, -0.38, 0 ], [ -0.75, -0.66, 0 ], [ -0.92, -0.38, 0 ], [ -0.98, -0.19, 0 ], [ -1, 0.00, 0 ], [ -1, 0.00, 0 ], [ -1, 0.00, 0 ], [ -0.98, -0.19, 0 ]]);
	_model.tex_list = array_concat(_model.tex_list,  [[ 0.50, 0.00 ], [ 0.50, 0.50 ], [ 0.62, 0.00 ], [ 0.62, 0.50 ], [ 0.62, 0.00 ], [ 0.50, 0.50 ], [ 0.62, 0.00 ], [ 0.62, 0.50 ], [ 0.75, 0.00 ], [ 0.75, 0.50 ], [ 0.75, 0.00 ], [ 0.62, 0.50 ], [ 0.75, 0.00 ], [ 0.75, 0.50 ], [ 0.89, 0.00 ], [ 0.89, 0.50 ], [ 0.89, 0.00 ], [ 0.75, 0.50 ], [ 0.89, 0.00 ], [ 0.89, 0.50 ], [ 1.00, 0.00 ], [ 1.00, 0.50 ], [ 1.00, 0.00 ], [ 0.89, 0.50 ]]);
	_model.col_list = array_concat(_model.col_list,  [c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white]);
	_model.alpha_list = array_concat(_model.alpha_list,  [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]);

}

/// Create P3D model and populate vertex information
/// Fill vertex,  normals,  texture,  color,  alpha
function add_vertices_custom_tileset_tall__walls_8(_model,  _dx,  _dy,  _dz){

	_model.vert_list = array_concat(_model.vert_list, [[_dx - 0.00, _dy + 16, _dz + 0], [_dx - 0.00, _dy + 16, _dz - 32], [_dx - 0.00, _dy + 8, _dz + 0], [_dx + 0, _dy + 8, _dz - 32], [_dx - 0.00, _dy + 8, _dz + 0], [_dx - 0.00, _dy + 16, _dz - 32], [_dx - 0.00, _dy + 8, _dz + 0], [_dx + 0, _dy + 8, _dz - 32], [_dx + 3.20, _dy + 3.20, _dz + 0], [_dx + 3.20, _dy + 3.20, _dz - 32], [_dx + 3.20, _dy + 3.20, _dz + 0], [_dx + 0, _dy + 8, _dz - 32], [_dx + 3.20, _dy + 3.20, _dz + 0], [_dx + 3.20, _dy + 3.20, _dz - 32], [_dx + 8, _dy + 0, _dz + 0], [_dx + 8, _dy + 0, _dz - 32], [_dx + 8, _dy + 0, _dz + 0], [_dx + 3.20, _dy + 3.20, _dz - 32], [_dx + 8, _dy + 0, _dz + 0], [_dx + 8, _dy + 0, _dz - 32], [_dx + 16, _dy + 0, _dz + 0], [_dx + 16, _dy + 0, _dz - 32], [_dx + 16, _dy + 0, _dz + 0], [_dx + 8, _dy + 0, _dz - 32]]);
	_model.norm_list = array_concat(_model.norm_list,  [[ 1, 0, -0.00 ], [ 1, 0.00, 0 ], [ 0.98, 0.19, 0.00 ], [ 0.92, 0.38, 0.00 ], [ 0.98, 0.19, 0.00 ], [ 1, 0.00, 0 ], [ 0.98, 0.19, 0.00 ], [ 0.92, 0.38, 0.00 ], [ 0.75, 0.66, 0.00 ], [ 0.66, 0.75, 0 ], [ 0.75, 0.66, 0.00 ], [ 0.92, 0.38, 0.00 ], [ 0.75, 0.66, 0.00 ], [ 0.66, 0.75, 0 ], [ 0.38, 0.92, 0 ], [ 0.19, 0.98, 0 ], [ 0.38, 0.92, 0 ], [ 0.66, 0.75, 0 ], [ 0.38, 0.92, 0 ], [ 0.19, 0.98, 0 ], [ 0, 1, 0 ], [ 0, 1, 0 ], [ 0, 1, 0 ], [ 0.19, 0.98, 0 ]]);
	_model.tex_list = array_concat(_model.tex_list,  [[ 0.50, 0.00 ], [ 0.50, 0.50 ], [ 0.64, 0.00 ], [ 0.64, 0.50 ], [ 0.64, 0.00 ], [ 0.50, 0.50 ], [ 0.64, 0.00 ], [ 0.64, 0.50 ], [ 0.75, 0.00 ], [ 0.75, 0.50 ], [ 0.75, 0.00 ], [ 0.64, 0.50 ], [ 0.75, 0.00 ], [ 0.75, 0.50 ], [ 0.87, 0.00 ], [ 0.87, 0.50 ], [ 0.87, 0.00 ], [ 0.75, 0.50 ], [ 0.87, 0.00 ], [ 0.87, 0.50 ], [ 1.00, 0.00 ], [ 1.00, 0.50 ], [ 1.00, 0.00 ], [ 0.87, 0.50 ]]);
	_model.col_list = array_concat(_model.col_list,  [c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white]);
	_model.alpha_list = array_concat(_model.alpha_list,  [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]);

}

/// Create P3D model and populate vertex information
/// Fill vertex,  normals,  texture,  color,  alpha
function add_vertices_custom_tileset_tall__walls_9(_model,  _dx,  _dy,  _dz){

	_model.vert_list = array_concat(_model.vert_list, [[_dx + 0, _dy + 16, _dz + 0], [_dx + 0, _dy + 16, _dz - 32], [_dx + 0, _dy + 8, _dz + 0], [_dx + 0, _dy + 8, _dz - 32], [_dx + 0, _dy + 8, _dz + 0], [_dx + 0, _dy + 16, _dz - 32], [_dx - 8, _dy + 0, _dz + 0], [_dx - 8, _dy + 0, _dz - 32], [_dx - 16, _dy + 0, _dz + 0], [_dx - 16, _dy + 0, _dz - 32], [_dx - 16, _dy + 0, _dz + 0], [_dx - 8, _dy + 0, _dz - 32], [_dx + 0, _dy + 8, _dz + 0], [_dx + 0, _dy + 8, _dz - 32], [_dx - 8, _dy + 0, _dz + 0], [_dx - 8, _dy + 0, _dz - 32], [_dx - 8, _dy + 0, _dz + 0], [_dx + 0, _dy + 8, _dz - 32], [_dx + 0, _dy - 16, _dz + 0], [_dx + 0, _dy - 16, _dz - 32], [_dx + 0, _dy - 8, _dz + 0], [_dx + 0, _dy - 8, _dz - 32], [_dx + 0, _dy - 8, _dz + 0], [_dx + 0, _dy - 16, _dz - 32], [_dx + 8, _dy + 0, _dz + 0], [_dx + 8, _dy + 0, _dz - 32], [_dx + 16, _dy + 0, _dz + 0], [_dx + 16, _dy + 0, _dz - 32], [_dx + 16, _dy + 0, _dz + 0], [_dx + 8, _dy + 0, _dz - 32], [_dx + 0, _dy - 8, _dz + 0], [_dx + 0, _dy - 8, _dz - 32], [_dx + 8, _dy + 0, _dz + 0], [_dx + 8, _dy + 0, _dz - 32], [_dx + 8, _dy + 0, _dz + 0], [_dx + 0, _dy - 8, _dz - 32]]);
	_model.norm_list = array_concat(_model.norm_list,  [[ 1, 0, 0 ], [ 1, 0, 0 ], [ 1, 0, 0 ], [ 1, 0, 0 ], [ 1, 0, 0 ], [ 1, 0, 0 ], [ 0, -1, 0 ], [ 0, -1, 0 ], [ 0, -1, 0 ], [ 0, -1, 0 ], [ 0, -1, 0 ], [ 0, -1, 0 ], [ 0.71, -0.71, 0 ], [ 0.71, -0.71, 0 ], [ 0.71, -0.71, 0 ], [ 0.71, -0.71, 0 ], [ 0.71, -0.71, 0 ], [ 0.71, -0.71, 0 ], [ -1, 0, 0 ], [ -1, 0, 0 ], [ -1, 0, 0 ], [ -1, 0, 0 ], [ -1, 0, 0 ], [ -1, 0, 0 ], [ 0, 1, 0 ], [ 0, 1, 0 ], [ 0, 1, 0 ], [ 0, 1, 0 ], [ 0, 1, 0 ], [ 0, 1, 0 ], [ -0.71, 0.71, 0 ], [ -0.71, 0.71, 0 ], [ -0.71, 0.71, 0 ], [ -0.71, 0.71, 0 ], [ -0.71, 0.71, 0 ], [ -0.71, 0.71, 0 ]]);
	_model.tex_list = array_concat(_model.tex_list,  [[ 0.50, 0.00 ], [ 0.50, 0.50 ], [ 0.62, 0.00 ], [ 0.62, 0.50 ], [ 0.62, 0.00 ], [ 0.50, 0.50 ], [ 0.89, 0.00 ], [ 0.89, 0.50 ], [ 1.00, 0.00 ], [ 1.00, 0.50 ], [ 1.00, 0.00 ], [ 0.89, 0.50 ], [ 0.62, 0.00 ], [ 0.62, 0.50 ], [ 0.89, 0.00 ], [ 0.89, 0.50 ], [ 0.89, 0.00 ], [ 0.62, 0.50 ], [ 0.50, 0.00 ], [ 0.50, 0.50 ], [ 0.62, 0.00 ], [ 0.62, 0.50 ], [ 0.62, 0.00 ], [ 0.50, 0.50 ], [ 0.89, 0.00 ], [ 0.89, 0.50 ], [ 1.00, 0.00 ], [ 1.00, 0.50 ], [ 1.00, 0.00 ], [ 0.89, 0.50 ], [ 0.62, 0.00 ], [ 0.62, 0.50 ], [ 0.89, 0.00 ], [ 0.89, 0.50 ], [ 0.89, 0.00 ], [ 0.62, 0.50 ]]);
	_model.col_list = array_concat(_model.col_list,  [c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white]);
	_model.alpha_list = array_concat(_model.alpha_list,  [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]);

}

/// Create P3D model and populate vertex information
/// Fill vertex,  normals,  texture,  color,  alpha
function add_vertices_custom_tileset_tall__walls_10(_model,  _dx,  _dy,  _dz){

	_model.vert_list = array_concat(_model.vert_list, [[_dx - 0.00, _dy + 16, _dz + 0], [_dx - 0.00, _dy + 16, _dz - 32], [_dx + 0.00, _dy - 16, _dz + 0], [_dx + 0.00, _dy - 16, _dz - 32], [_dx + 0.00, _dy - 16, _dz + 0], [_dx - 0.00, _dy + 16, _dz - 32]]);
	_model.norm_list = array_concat(_model.norm_list,  [[ 1, 0.00, 0 ], [ 1, 0.00, 0 ], [ 1, 0.00, 0 ], [ 1, 0.00, 0 ], [ 1, 0.00, 0 ], [ 1, 0.00, 0 ]]);
	_model.tex_list = array_concat(_model.tex_list,  [[ 0.50, 0.00 ], [ 0.50, 0.50 ], [ 1.00, 0.00 ], [ 1.00, 0.50 ], [ 1.00, 0.00 ], [ 0.50, 0.50 ]]);
	_model.col_list = array_concat(_model.col_list,  [c_white, c_white, c_white, c_white, c_white, c_white]);
	_model.alpha_list = array_concat(_model.alpha_list,  [1, 1, 1, 1, 1, 1]);

}

/// Create P3D model and populate vertex information
/// Fill vertex,  normals,  texture,  color,  alpha
function add_vertices_custom_tileset_tall__walls_11(_model,  _dx,  _dy,  _dz){

	_model.vert_list = array_concat(_model.vert_list, [[_dx - 0.00, _dy + 16, _dz + 0], [_dx - 0.00, _dy + 16, _dz - 32], [_dx - 0.00, _dy + 8, _dz + 0], [_dx - 0.00, _dy + 8, _dz - 32], [_dx - 0.00, _dy + 8, _dz + 0], [_dx - 0.00, _dy + 16, _dz - 32], [_dx - 0.00, _dy + 8, _dz + 0], [_dx - 0.00, _dy + 8, _dz - 32], [_dx - 3.20, _dy + 3.20, _dz + 0], [_dx - 3.20, _dy + 3.20, _dz - 32], [_dx - 3.20, _dy + 3.20, _dz + 0], [_dx - 0.00, _dy + 8, _dz - 32], [_dx - 3.20, _dy + 3.20, _dz + 0], [_dx - 3.20, _dy + 3.20, _dz - 32], [_dx - 8, _dy + 0, _dz + 0], [_dx - 8, _dy + 0, _dz - 32], [_dx - 8, _dy + 0, _dz + 0], [_dx - 3.20, _dy + 3.20, _dz - 32], [_dx - 8, _dy + 0, _dz + 0], [_dx - 8, _dy + 0, _dz - 32], [_dx - 16, _dy + 0, _dz + 0], [_dx - 16, _dy + 0, _dz - 32], [_dx - 16, _dy + 0, _dz + 0], [_dx - 8, _dy + 0, _dz - 32]]);
	_model.norm_list = array_concat(_model.norm_list,  [[ 1, 0.00, 0 ], [ 1, 0.00, 0 ], [ 0.98, -0.19, 0 ], [ 0.92, -0.38, 0 ], [ 0.98, -0.19, 0 ], [ 1, 0.00, 0 ], [ 0.98, -0.19, 0 ], [ 0.92, -0.38, 0 ], [ 0.75, -0.66, 0 ], [ 0.66, -0.75, 0 ], [ 0.75, -0.66, 0 ], [ 0.92, -0.38, 0 ], [ 0.75, -0.66, 0 ], [ 0.66, -0.75, 0 ], [ 0.38, -0.92, 0 ], [ 0.19, -0.98, 0 ], [ 0.38, -0.92, 0 ], [ 0.66, -0.75, 0 ], [ 0.38, -0.92, 0 ], [ 0.19, -0.98, 0 ], [ 0, -1, 0 ], [ 0, -1, 0 ], [ 0, -1, 0 ], [ 0.19, -0.98, 0 ]]);
	_model.tex_list = array_concat(_model.tex_list,  [[ 0.50, 0.00 ], [ 0.50, 0.50 ], [ 0.61, 0.00 ], [ 0.61, 0.50 ], [ 0.61, 0.00 ], [ 0.50, 0.50 ], [ 0.61, 0.00 ], [ 0.61, 0.50 ], [ 0.75, 0.00 ], [ 0.75, 0.50 ], [ 0.75, 0.00 ], [ 0.61, 0.50 ], [ 0.75, 0.00 ], [ 0.75, 0.50 ], [ 0.88, 0.00 ], [ 0.88, 0.50 ], [ 0.88, 0.00 ], [ 0.75, 0.50 ], [ 0.88, 0.00 ], [ 0.88, 0.50 ], [ 1.00, 0.00 ], [ 1.00, 0.50 ], [ 1.00, 0.00 ], [ 0.88, 0.50 ]]);
	_model.col_list = array_concat(_model.col_list,  [c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white]);
	_model.alpha_list = array_concat(_model.alpha_list,  [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]);

}

/// Create P3D model and populate vertex information
/// Fill vertex,  normals,  texture,  color,  alpha
function add_vertices_custom_tileset_tall__walls_12(_model,  _dx,  _dy,  _dz){

	_model.vert_list = array_concat(_model.vert_list, [[_dx - 16, _dy - 0.00, _dz + 0], [_dx - 16, _dy - 0.00, _dz - 32], [_dx + 16, _dy + 0.00, _dz + 0], [_dx + 16, _dy + 0.00, _dz - 32], [_dx + 16, _dy + 0.00, _dz + 0], [_dx - 16, _dy - 0.00, _dz - 32]]);
	_model.norm_list = array_concat(_model.norm_list,  [[ -0.00, 1, 0 ], [ -0.00, 1, 0 ], [ -0.00, 1, 0 ], [ -0.00, 1, 0 ], [ -0.00, 1, 0 ], [ -0.00, 1, 0 ]]);
	_model.tex_list = array_concat(_model.tex_list,  [[ 0.50, 0.00 ], [ 0.50, 0.50 ], [ 1.00, 0.00 ], [ 1.00, 0.50 ], [ 1.00, 0.00 ], [ 0.50, 0.50 ]]);
	_model.col_list = array_concat(_model.col_list,  [c_white, c_white, c_white, c_white, c_white, c_white]);
	_model.alpha_list = array_concat(_model.alpha_list,  [1, 1, 1, 1, 1, 1]);

}

/// Create P3D model and populate vertex information
/// Fill vertex,  normals,  texture,  color,  alpha
function add_vertices_custom_tileset_tall__walls_13(_model,  _dx,  _dy,  _dz){

	_model.vert_list = array_concat(_model.vert_list, [[_dx + 0, _dy - 16, _dz + 0], [_dx + 0, _dy - 16, _dz - 32], [_dx + 0, _dy - 8, _dz + 0], [_dx + 0, _dy - 8, _dz - 32], [_dx + 0, _dy - 8, _dz + 0], [_dx + 0, _dy - 16, _dz - 32], [_dx + 0, _dy - 8, _dz + 0], [_dx + 0, _dy - 8, _dz - 32], [_dx + 3.20, _dy - 3.20, _dz + 0], [_dx + 3.20, _dy - 3.20, _dz - 32], [_dx + 3.20, _dy - 3.20, _dz + 0], [_dx + 0, _dy - 8, _dz - 32], [_dx + 3.20, _dy - 3.20, _dz + 0], [_dx + 3.20, _dy - 3.20, _dz - 32], [_dx + 8, _dy + 0, _dz + 0], [_dx + 8, _dy + 0, _dz - 32], [_dx + 8, _dy + 0, _dz + 0], [_dx + 3.20, _dy - 3.20, _dz - 32], [_dx + 8, _dy + 0, _dz + 0], [_dx + 8, _dy + 0, _dz - 32], [_dx + 16, _dy + 0, _dz + 0], [_dx + 16, _dy + 0, _dz - 32], [_dx + 16, _dy + 0, _dz + 0], [_dx + 8, _dy + 0, _dz - 32]]);
	_model.norm_list = array_concat(_model.norm_list,  [[ -1, 0, 0 ], [ -1, 0, 0 ], [ -0.98, 0.19, 0 ], [ -0.92, 0.38, 0 ], [ -0.98, 0.19, 0 ], [ -1, 0, 0 ], [ -0.98, 0.19, 0 ], [ -0.92, 0.38, 0 ], [ -0.75, 0.66, 0 ], [ -0.66, 0.75, 0 ], [ -0.75, 0.66, 0 ], [ -0.92, 0.38, 0 ], [ -0.75, 0.66, 0 ], [ -0.66, 0.75, 0 ], [ -0.38, 0.92, 0 ], [ -0.19, 0.98, 0 ], [ -0.38, 0.92, 0 ], [ -0.66, 0.75, 0 ], [ -0.38, 0.92, 0 ], [ -0.19, 0.98, 0 ], [ 0, 1, 0 ], [ 0, 1, 0 ], [ 0, 1, 0 ], [ -0.19, 0.98, 0 ]]);
	_model.tex_list = array_concat(_model.tex_list,  [[ 0.50, 0.00 ], [ 0.50, 0.50 ], [ 0.62, 0.00 ], [ 0.62, 0.50 ], [ 0.62, 0.00 ], [ 0.50, 0.50 ], [ 0.62, 0.00 ], [ 0.62, 0.50 ], [ 0.75, 0.00 ], [ 0.75, 0.50 ], [ 0.75, 0.00 ], [ 0.62, 0.50 ], [ 0.75, 0.00 ], [ 0.75, 0.50 ], [ 0.89, 0.00 ], [ 0.89, 0.50 ], [ 0.89, 0.00 ], [ 0.75, 0.50 ], [ 0.89, 0.00 ], [ 0.89, 0.50 ], [ 1.00, 0.00 ], [ 1.00, 0.50 ], [ 1.00, 0.00 ], [ 0.89, 0.50 ]]);
	_model.col_list = array_concat(_model.col_list,  [c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white]);
	_model.alpha_list = array_concat(_model.alpha_list,  [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]);

}

/// Create P3D model and populate vertex information
/// Fill vertex,  normals,  texture,  color,  alpha
function add_vertices_custom_tileset_tall__walls_14(_model,  _dx,  _dy,  _dz){

	_model.vert_list = array_concat(_model.vert_list, [[_dx - 16, _dy + 0, _dz + 0], [_dx - 16, _dy + 0, _dz - 32], [_dx - 8, _dy + 0, _dz + 0], [_dx - 8, _dy + 0, _dz - 32], [_dx - 8, _dy + 0, _dz + 0], [_dx - 16, _dy + 0, _dz - 32], [_dx - 8, _dy + 0, _dz + 0], [_dx - 8, _dy + 0, _dz - 32], [_dx - 3.20, _dy - 3.20, _dz + 0], [_dx - 3.20, _dy - 3.20, _dz - 32], [_dx - 3.20, _dy - 3.20, _dz + 0], [_dx - 8, _dy + 0, _dz - 32], [_dx - 3.20, _dy - 3.20, _dz + 0], [_dx - 3.20, _dy - 3.20, _dz - 32], [_dx + 0, _dy - 8, _dz + 0], [_dx + 0, _dy - 8, _dz - 32], [_dx + 0, _dy - 8, _dz + 0], [_dx - 3.20, _dy - 3.20, _dz - 32], [_dx + 0, _dy - 8, _dz + 0], [_dx + 0, _dy - 8, _dz - 32], [_dx + 0.00, _dy - 16, _dz + 0], [_dx + 0, _dy - 16, _dz - 32], [_dx + 0.00, _dy - 16, _dz + 0], [_dx + 0, _dy - 8, _dz - 32]]);
	_model.norm_list = array_concat(_model.norm_list,  [[ 0, 1, 0 ], [ 0, 1, 0 ], [ 0.19, 0.98, 0 ], [ 0.38, 0.92, 0 ], [ 0.19, 0.98, 0 ], [ 0, 1, 0 ], [ 0.19, 0.98, 0 ], [ 0.38, 0.92, 0 ], [ 0.66, 0.75, 0 ], [ 0.75, 0.66, 0 ], [ 0.66, 0.75, 0 ], [ 0.38, 0.92, 0 ], [ 0.66, 0.75, 0 ], [ 0.75, 0.66, 0 ], [ 0.92, 0.38, 0 ], [ 0.98, 0.19, -0.00 ], [ 0.92, 0.38, 0 ], [ 0.75, 0.66, 0 ], [ 0.92, 0.38, 0 ], [ 0.98, 0.19, -0.00 ], [ 1, 0.00, -0.00 ], [ 1, 0, -0.00 ], [ 1, 0.00, -0.00 ], [ 0.98, 0.19, -0.00 ]]);
	_model.tex_list = array_concat(_model.tex_list,  [[ 0.50, 0.00 ], [ 0.50, 0.50 ], [ 0.62, 0.00 ], [ 0.62, 0.50 ], [ 0.62, 0.00 ], [ 0.50, 0.50 ], [ 0.62, 0.00 ], [ 0.62, 0.50 ], [ 0.75, 0.00 ], [ 0.75, 0.50 ], [ 0.75, 0.00 ], [ 0.62, 0.50 ], [ 0.75, 0.00 ], [ 0.75, 0.50 ], [ 0.89, 0.00 ], [ 0.89, 0.50 ], [ 0.89, 0.00 ], [ 0.75, 0.50 ], [ 0.89, 0.00 ], [ 0.89, 0.50 ], [ 1.00, 0.00 ], [ 1.00, 0.50 ], [ 1.00, 0.00 ], [ 0.89, 0.50 ]]);
	_model.col_list = array_concat(_model.col_list,  [c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white, c_white]);
	_model.alpha_list = array_concat(_model.alpha_list,  [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]);

}
