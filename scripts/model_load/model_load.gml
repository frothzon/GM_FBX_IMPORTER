// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function model_load(fname, matfname = -1, rescale=32, zup=true){
	/// fetch already loaded model first
	var cache_name = $"{fname}-{rescale}";
	if(variable_struct_exists(global.MODEL_CACHE, cache_name)){
		return global.MODEL_CACHE[$ cache_name];
	}
	
	var mtl_file = file_text_open_read(matfname);
	
	var vertex_x = [];
	var vertex_y = [];
	var vertex_z = [];
	
	var normal_x = [];
	var normal_y = [];
	var normal_z = [];
	
	var uv_x = [];
	var uv_y = [];
	
	var model = create_P3D_struct();
	
	var mtl_alpha = ds_map_create();
	var mtl_color = ds_map_create();
	
	var alpha = 1;
	var color = c_white;
	
	/// read from mat file
	if(mtl_file != -1){
		var mtl_name = "None";
		
		while(! file_text_eof(mtl_file)){
			var line = file_text_read_string(mtl_file);
			file_text_readln(mtl_file);
			
			var terms = string_split(line, " ");
			
			/// parse based on op code
			if(!is_array(terms)){
				show_error("not an array.", 0);
				continue;
			}
			if(array_length(terms) <= 0) continue;
		
			switch(terms[0]){
				case "newmtl":
					mtl_name = terms[1];
				break;
				case "Kd":
					var col = make_color_rgb(real(terms[1])*255,real(terms[2])*255,real(terms[3])*255);
					ds_map_add(mtl_color, mtl_name, col);
				break;
				case "d":
					ds_map_add(mtl_alpha, mtl_name, real(terms[1]));
				break;
				default:
					/// other attributes have not been defined
				break;
			}
			
		}
		file_text_close(mtl_file);
	}
	
	/// read from model file
	var obj_file = file_text_open_read(fname);
	while(! file_text_eof(obj_file)){
		var line = file_text_read_string(obj_file);
		file_text_readln(obj_file);
		
		var terms = string_split(line, " ");
		
		/// parse based on op code
		if(!is_array(terms)){
			show_error("not an array.", 0);
			continue;
		}
		if(array_length(terms) <= 0) continue;
		switch(terms[0]){
			case "v":
				/// add vertex coords -- with position offsets
				array_push(vertex_x, real(terms[1]) * rescale);
				if(zup){
					array_push(vertex_y, real(terms[3]) * rescale);
					array_push(vertex_z, real(terms[2]) * rescale);
				} else {
					array_push(vertex_y, real(terms[2]) * rescale);
					array_push(vertex_z, real(terms[3]) * rescale);
				}
			break;
			case "vt":
				/// add tex coords
				array_push(uv_x, real(terms[1]));
				array_push(uv_y, 1-real(terms[2]));
			break;
			case "vn":
				/// add normals
				array_push(normal_x, real(terms[1]));
				if(zup){
					array_push(normal_y, real(terms[3]));
					array_push(normal_z, real(terms[2]));
				} else {
					array_push(normal_y, real(terms[2]));
					array_push(normal_z, real(terms[3]));
				}

			break;
			case "f":
				/// add faces
				var count = array_length(terms);
				if(count > 4){
					show_error("Warning, model has N-Gons that will not render properly", 0);	
				}
				for(var i = 1; i < count; i++){
					var data = string_split(terms[i], "/");
					
					/// get coordinates
					var xx = vertex_x[real(data[0])-1];
					var yy = vertex_y[real(data[0])-1];
					var zz = vertex_z[real(data[0])-1];
					
					/// get uvs
					var uu = uv_x[real(data[1])-1];
					var vv = uv_y[real(data[1])-1];
					
					/// get normals
					var nx = normal_x[real(data[2])-1];
					var ny = normal_y[real(data[2])-1];
					var nz = normal_z[real(data[2])-1];
					
					
					/// add vertices
					model.addPoint([xx,yy,zz], [nx, ny, nz], [uu, vv], color, alpha);
				}
			break;
			case "usemtl":
				/// use material
				if(ds_map_exists(mtl_color, terms[1])) color = ds_map_find_value(mtl_color, terms[1]);
				if(ds_map_exists(mtl_alpha, terms[1])) alpha = ds_map_find_value(mtl_alpha, terms[1]);
			break;
		}
	}
	
	/// clean up arrays
	vertex_x = -1;
	vertex_y = -1;
	vertex_z = -1;
	normal_x = -1;
	normal_y = -1;
	normal_z = -1;
	uv_x = -1;
	uv_y = -1;
	ds_map_destroy(mtl_alpha);
	ds_map_destroy(mtl_color);
	file_text_close(obj_file);
	
	/// keep in cache (can be used to destroy models at game end)
	global.MODEL_CACHE[$ cache_name] = model;
	
	return(model);
	
}