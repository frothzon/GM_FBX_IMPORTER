function Tileset_Terrain() constructor{
	state = 0;
	models = {};
	textures = {};
	buffers = [];
	ready_tex = [];
	
	ground_tile_functions = [
		add_vertices_custom_tileset_ind0,
		add_vertices_custom_tileset_ind1,
		add_vertices_custom_tileset_ind2,
		add_vertices_custom_tileset_ind3,
		add_vertices_custom_tileset_ind4,
		add_vertices_custom_tileset_ind5,
		add_vertices_custom_tileset_ind6,
		add_vertices_custom_tileset_ind7,
		add_vertices_custom_tileset_ind8,
		add_vertices_custom_tileset_ind9,
		add_vertices_custom_tileset_ind10,
		add_vertices_custom_tileset_ind11,
		add_vertices_custom_tileset_ind12,
		add_vertices_custom_tileset_ind13,
		add_vertices_custom_tileset_ind14,
		dummy_add_vertices_custom
	];
	
	wall_tile_functions = [
		dummy_add_vertices_custom,
		add_vertices_custom_tileset_tall__walls_1,
		add_vertices_custom_tileset_tall__walls_2,
		add_vertices_custom_tileset_tall__walls_3,
		add_vertices_custom_tileset_tall__walls_4,
		add_vertices_custom_tileset_tall__walls_5,
		add_vertices_custom_tileset_tall__walls_6,
		add_vertices_custom_tileset_tall__walls_7,
		add_vertices_custom_tileset_tall__walls_8,
		add_vertices_custom_tileset_tall__walls_9,
		add_vertices_custom_tileset_tall__walls_10,
		add_vertices_custom_tileset_tall__walls_11,
		add_vertices_custom_tileset_tall__walls_12,
		add_vertices_custom_tileset_tall__walls_13,
		add_vertices_custom_tileset_tall__walls_14,
		dummy_add_vertices_custom
	];

	static import_tileset = function(ts_name, tex_sprite, zoffset, stack_count=1){
		/// static addPoint = function(pos_v3, norm_v3, uv_v2, color, alpha){
		var _l = layer_get_id(ts_name);
		var _m = layer_tilemap_get_id(_l);
		/// get texture source counts
		/// loop through tiles in map
		var _mapW = tilemap_get_width(_m);
		var _mapH = tilemap_get_height(_m);
		var _modelName = $"mod_{tex_sprite}";
		if(!variable_struct_exists(self.models, _modelName)){
			self.models[$ _modelName] = create_P3D_struct();
			self.textures[$ _modelName] = sprite_get_texture(tex_sprite, 0);
		}
		var _model = self.models[$ _modelName];
		
		layer_set_visible(_l, 0);
		
		for(var i = 0; i < _mapW; i++){
			for(var j = 0; j < _mapH; j++){
				var _tile = tilemap_get(_m, i, j) - 1;
				if(_tile < 0) continue;
				var _function = self.ground_tile_functions[_tile];
				var _wall_func = self.wall_tile_functions[_tile];
				
				// add vertices for ground
				_function(_model, i*32-16, j*32-16, zoffset);
				
				// add vertices for additional walls
				if(stack_count > 1){
					for(var f = 1; f < stack_count; f++){
						_wall_func(_model, i*32-16, j*32-16, zoffset - f*32);
					}
				}

			}
		}
		state = 1;
		
	}
	
	static build_vertex_buffers = function(){
		var _names = struct_get_names(self.models);
		for(var i = 0; i < array_length(_names); i++){
			var vb_model = start_vertex_buffer_model();	
			add_P3D_to_vertex_buffer(vb_model, self.models[$ _names[i]], 0, 0, 0);
			finish_vertex_buffer_model(vb_model);
			vertex_freeze(vb_model);
			array_push(self.buffers, vb_model);
			array_push(self.ready_tex, self.textures[$ _names[i]]);
		}
		state = 2;
	}
	
	static destroy_buffers = function(){
		if(state != 2){
			return;
		}
		for(var i = 0; i < array_length(self.buffers); i++){
			buffer_delete(self.buffers[i])
		}
		state = 1;
	}
	
	static render = function(){
		if(state != 2){
			return;
		}
		for(var i = 0; i < array_length(self.buffers); i++){
			vertex_submit(self.buffers[i], pr_trianglelist, self.ready_tex[i]);
		}
	}
}