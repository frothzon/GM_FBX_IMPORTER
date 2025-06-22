function setup_terrain(_name = "Tiles_1", _tileset = spr_basic_tile_tex){
	var _lay = layer_get_id(_name);
	var _depth = -layer_get_depth(_lay);
	show_debug_message($"Terrain Depth {_name} = {_depth}");
	var _terrain = new Tileset_Terrain();
	var _stacks = 1 + ceil(abs(_depth)/32);
	show_debug_message($"Layer Stacks {_stacks}");
	var _build_terrain = function(_name, _terrain, _depth, _stacks, _tileset){
		/// import_tileset(ts_name, tex_sprite, zoffset, stack_count=1)
		_terrain.import_tileset(_name, _tileset, _depth, _stacks);
		_terrain.build_vertex_buffers();
	}
	var time_source = time_source_create(time_source_game, 1, time_source_units_frames, _build_terrain, [_name, _terrain, _depth, _stacks, _tileset]);
	time_source_start(time_source);
	return _terrain;
}