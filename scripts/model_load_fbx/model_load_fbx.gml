// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function model_load_fbx(fname, rescale = 32, zup = true) {
	/// @desc Loads model data from an ASCII FBX file.
	/// @param fname		The filename of the model.
	/// @param rescale		The scaling factor for the model.
	/// @param zup			Whether to treat the Z-axis as the up-axis.
	
	var cache_name = $"fbx-{fname}-{rescale}";
	if (variable_struct_exists(global.MODEL_CACHE, cache_name)) {
		return global.MODEL_CACHE[$ cache_name];
	}

	if (!file_exists(fname)) {
		show_error($"File '{fname}' not found.", true);
		return -1;
	}

	var model = create_P3D_struct();
	var file = file_text_open_read(fname);

	// Data stores for the entire file
	var materials = [];

	// Parser state variables
	var in_objects_block = false;
	var in_geometry_block = false;
	var in_material_block = false;

	// Temporary data for the current geometry being parsed
	var temp_vertices = [];
	var temp_normals = [];
	var temp_uvs = [];
	var temp_poly_indices = [];
	var temp_normal_mapping = "ByPolygonVertex";
	var temp_uv_mapping = "ByPolygonVertex";
	var temp_material_index = 0;

	while (!file_text_eof(file)) {
		var line = file_text_readln(file);
		var line_trimmed = string_trim(line);

		// --- State Machine ---
		if (string_pos("Objects:", line_trimmed) == 1) {
			in_objects_block = true;
			continue;
		}
		
		if (string_pos("Material:", line_trimmed) == 1 && in_objects_block) {
			in_material_block = true;
			var props = _fbx_parse_properties(file);
			
			var mat_struct = {
				color: c_white,
				alpha: 1.0,
			};
			
			if (variable_struct_exists(props, "Diffuse")) {
				var col_arr = props[$ "Diffuse"];
				mat_struct.color = make_color_rgb(real(col_arr[2])*255, real(col_arr[3])*255, real(col_arr[4])*255);
			}
			if (variable_struct_exists(props, "Opacity")) {
				mat_struct.alpha = real(props[$ "Opacity"][2]);
			}
			if (variable_struct_exists(props, "TransparencyFactor")) {
				mat_struct.alpha = 1.0 - real(props[$ "TransparencyFactor"][2]);
			}
			
			array_push(materials, mat_struct);
			in_material_block = false;
			continue;
		}

		if (string_pos("Geometry:", line_trimmed) == 1 && in_objects_block) {
			in_geometry_block = true;
			// Reset temporary data for a new mesh
			temp_vertices = [];
			temp_normals = [];
			temp_uvs = [];
			temp_poly_indices = [];
			temp_normal_mapping = "ByPolygonVertex";
			temp_uv_mapping = "ByPolygonVertex";
			temp_material_index = 0;
			continue;
		}

		if (in_geometry_block) {
			if (string_pos("Vertices:", line_trimmed) == 1) {
				temp_vertices = _fbx_parse_data_array(file);
			} else if (string_pos("PolygonVertexIndex:", line_trimmed) == 1) {
				temp_poly_indices = _fbx_parse_data_array(file);
			} else if (string_pos("LayerElementNormal:", line_trimmed) == 1) {
				var line_norm = file_text_readln(file); // Version
				line_norm = file_text_readln(file); // Name
				line_norm = file_text_readln(file); // MappingInformationType
				if (string_pos("ByPolygon", line_norm) > 0) {
					temp_normal_mapping = "ByPolygon";
				} else {
					temp_normal_mapping = "ByPolygonVertex";
				}
				file_text_readln(file); // ReferenceInformationType
				file_text_readln(file); // Normals:
				temp_normals = _fbx_parse_data_array(file);
			} else if (string_pos("LayerElementUV:", line_trimmed) == 1) {
				file_text_readln(file); // Version
				file_text_readln(file); // Name
				var line_uv = file_text_readln(file); // MappingInformationType
				temp_uv_mapping = (string_pos("ByPolygonVertex", line_uv) > 0) ? "ByPolygonVertex" : "ByVertex";
				file_text_readln(file); // ReferenceInformationType
				file_text_readln(file); // UV:
				temp_uvs = _fbx_parse_data_array(file);
			} else if (string_pos("LayerElementMaterial:", line_trimmed) == 1) {
				// We assume "AllSame" for simplicity as per the file
				while(string_pos("Materials:", line) == 0 && !file_text_eof(file)) line = file_text_readln(file);
				var mat_indices = _fbx_parse_data_array(file);
				if(array_length(mat_indices) > 0) temp_material_index = real(mat_indices[0]);
			} else if (string_pos("}", line_trimmed) == 1) {
				// --- End of Geometry block: Process and build the mesh ---
				if (array_length(temp_vertices) > 0 && array_length(temp_poly_indices) > 0) {
					
					var current_material = (array_length(materials) > temp_material_index) ? materials[temp_material_index] : { color: c_white, alpha: 1.0 };
					var color = current_material.color;
					var alpha = current_material.alpha;

					var face = [];
					var uv_counter = 0;
					var normal_counter = 0;

					for (var i = 0; i < array_length(temp_poly_indices); i++) {
						var index = real(temp_poly_indices[i]);
						if (index >= 0) {
							array_push(face, index);
						} else {
							// End of polygon detected
							index = (-index) - 1;
							array_push(face, index);

							// Triangulate the polygon (fan triangulation)
							for (var j = 1; j < array_length(face) - 1; j++) {
								var v1_idx = face[0];
								var v2_idx = face[j];
								var v3_idx = face[j+1];

								var v_indices = [v1_idx, v2_idx, v3_idx];
								
								// Get the normal for this triangle
								var nx = 0, ny = 0, nz = 0;
								if (temp_normal_mapping == "ByPolygon") {
									var n_base_idx = normal_counter * 3;
									nx = real(temp_normals[n_base_idx]);
									var n_y_raw = real(temp_normals[n_base_idx + 1]);
									var n_z_raw = real(temp_normals[n_base_idx + 2]);
									if(zup) { ny = n_z_raw; nz = n_y_raw; } else { ny = n_y_raw; nz = n_z_raw; }
								}

								// Add the 3 vertices for the triangle
								for (var k = 0; k < 3; k++) {
									var vert_idx = v_indices[k];
									var base_idx = vert_idx * 3;
									
									var xx = real(temp_vertices[base_idx]) * rescale;
									var yy_raw = real(temp_vertices[base_idx + 1]) * rescale;
									var zz_raw = real(temp_vertices[base_idx + 2]) * rescale;
									
									var yy, zz;
									if(zup) { yy = zz_raw; zz = yy_raw; } else { yy = yy_raw; zz = zz_raw; }

									// Get normals if they are per-vertex
									if (temp_normal_mapping == "ByPolygonVertex") {
										var n_base_idx = (uv_counter + k) * 3; // Normals are often aligned with UVs in this mode
										nx = real(temp_normals[n_base_idx]);
										var n_y_raw = real(temp_normals[n_base_idx+1]);
										var n_z_raw = real(temp_normals[n_base_idx+2]);
										if(zup) { ny = n_z_raw; nz = n_y_raw; } else { ny = n_y_raw; nz = n_z_raw; }
									}
									
									// Get UVs
									var uv_base_idx = (uv_counter + k) * 2;
									var uu = (array_length(temp_uvs) > uv_base_idx) ? real(temp_uvs[uv_base_idx]) : 0;
									var vv = (array_length(temp_uvs) > uv_base_idx + 1) ? 1 - real(temp_uvs[uv_base_idx + 1]) : 0;
									
									model.addPoint([xx, yy, zz], [nx, ny, nz], [uu, vv], color, alpha);
								}
							}
							
							uv_counter += array_length(face);
							if (temp_normal_mapping == "ByPolygon") {
								normal_counter++;
							}
							face = []; // Reset for next polygon
						}
					}
				}
				in_geometry_block = false; // Finished processing this geometry
			}
		}
	}

	file_text_close(file);

	// Cache the fully loaded model
	global.MODEL_CACHE[$ cache_name] = model;
	return model;
}