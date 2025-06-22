function P3D_Class() constructor{
	vert_list = [];
	norm_list = [];
	tex_list = [];
	col_list = [];
	alpha_list = [];
	model_name = "default_p3d";
	vbuffer = -1;

	// add vertex
	static addPoint = function(pos_v3, norm_v3, uv_v2, color, alpha){
		array_push(vert_list, pos_v3);
		array_push(norm_list, norm_v3);
		array_push(tex_list, uv_v2);
		array_push(col_list, color);
		array_push(alpha_list, alpha);
	};

	// build this model's internal vertex buffer
	static build_buffer = function() {
		// Clean up old buffer if it exists
		if (buffer_exists(vbuffer)) {
			buffer_exists(vbuffer);
		}
		
		vbuffer = vertex_create_buffer();
		vertex_begin(vbuffer, global.fbx_vertex_format);
		
		var len = array_length(vert_list);
		for(var i = 0; i < len; i++){
			var pos = vert_list[i];
			var nrm = norm_list[i];
			var uv = tex_list[i];
			var col = col_list[i];
			var alpha = alpha_list[i];
			
			vertex_position_3d(vbuffer, pos[0], pos[1], pos[2]);
			vertex_normal(vbuffer, nrm[0], nrm[1], nrm[2]);
			vertex_texcoord(vbuffer, uv[0], uv[1]);
			vertex_color(vbuffer, col, alpha);
		}
		
		vertex_end(vbuffer);
		vertex_freeze(vbuffer);
	};
	
	// Method to destroy the vertex buffer to prevent memory leaks
	static destroy = function() {
		if (vertex_buffer_exists(vbuffer)) {
			vertex_buffer_delete(vbuffer);
			vbuffer = -1;
		}
	};

	// turn this into an object constructor string
	static toObjectConstructor = function(){
		var _str = "/// Create P3D model and populate vertex information\n";
		_str += "var _model = create_P3D_struct();\n\n";
		_str += "/// Fill vertex, normals, texture, color, alpha\n";
		_str += $"_model.vert_list = [{array_to_string(self.vert_list)}];\n";
		_str += $"_model.norm_list = [{array_to_string(self.norm_list)}];\n";
		_str += $"_model.tex_list = [{array_to_string(self.tex_list)}];\n";
		_str += $"_model.col_list = [{array_to_string(self.col_list)}];\n";
		_str += $"_model.alpha_list = [{array_to_string(self.alpha_list)}];\n\n";
		_str += "return _model;"
		return _str;
	};

	static toObjectConstructorCustom = function(fname){
		var _str = "/// Create P3D model and populate vertex information\n";
		_str += "/// Fill vertex, normals, texture, color, alpha\n";
		_str += "function add_vertices_custom_" + string(fname) + "(_model, _dx, _dy, _dz){\n\n";
		_str += $"\t_model.vert_list = array_concat(_model.vert_list,[{self.customArrayText(self.vert_list)}]);\n";
		_str += $"\t_model.norm_list = array_concat(_model.norm_list, [{array_to_string(self.norm_list)}]);\n";
		_str += $"\t_model.tex_list = array_concat(_model.tex_list, [{array_to_string(self.tex_list)}]);\n";
		_str += $"\t_model.col_list = array_concat(_model.col_list, [{array_to_string(self.col_list)}]);\n";
		_str += $"\t_model.alpha_list = array_concat(_model.alpha_list, [{array_to_string(self.alpha_list)}]);\n\n";
		_str += "}";
		return _str;
	};

	static customArrayText = function(arr){
		/// convert any array to text
		var _str = "";
		for(var i = 0; i < array_length(arr); i++){
			var _vec3 = arr[i];
			if(i > 0){
				_str += ",";
			}
			_str += $"[_dx + {_vec3[0]},_dy + {_vec3[1]},_dz + {_vec3[2]}]";
		}
		return _str;
	}
}