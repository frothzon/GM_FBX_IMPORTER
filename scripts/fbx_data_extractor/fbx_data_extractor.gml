/// @description Functions to extract generic mesh data from a parsed FBX node tree.

/// @function fbx_extract_all_mesh_data(root_node, z_up)
/// @description Extracts all valid meshes from a node tree into an array of simple data structs.
/// @param {struct} root_node The root node from the parser.
/// @param {boolean} z_up Whether to perform the Y/Z coordinate swap.
function fbx_extract_all_mesh_data(root_node, z_up = true) {
    var all_mesh_data = [];
    
    if (!is_struct(root_node) || !variable_struct_exists(root_node._children, "Objects")) return all_mesh_data;
    var objects_node = root_node._children.Objects;

    if (!is_struct(objects_node) || !variable_struct_exists(objects_node, "_children")) return all_mesh_data;
    if (!variable_struct_exists(objects_node._children, "Geometry")) return all_mesh_data;

    var geometry_nodes = objects_node._children.Geometry;
    if (!is_array(geometry_nodes)) {
        geometry_nodes = [geometry_nodes];
    }
    
    for (var i = 0; i < array_length(geometry_nodes); i++) {
        var geo_node = geometry_nodes[i];
        if (!is_struct(geo_node)) continue;
        
        var mesh_data = _fbx_extract_single_mesh_data(geo_node, z_up);
        if (is_struct(mesh_data)) {
            array_push(all_mesh_data, mesh_data);
        }
    }
    return all_mesh_data;
}

/// @function _fbx_extract_single_mesh_data(geo_node, z_up)
/// @description Internal: Creates a mesh data struct from a single Geometry node.
function _fbx_extract_single_mesh_data(geo_node, z_up) {
	var props = string_split(geo_node._properties, ",");
	var mesh_name = string_replace_all(string_trim(props[1]), "\"", "");

	if (!variable_struct_exists(geo_node, "_children") ||
	    !variable_struct_exists(geo_node._children, "Vertices") || !variable_struct_exists(geo_node._children.Vertices, "a") ||
	    !variable_struct_exists(geo_node._children, "PolygonVertexIndex") || !variable_struct_exists(geo_node._children.PolygonVertexIndex, "a") ||
	    !variable_struct_exists(geo_node._children, "LayerElementNormal") || !variable_struct_exists(geo_node._children.LayerElementNormal._children, "Normals") ||
	    !variable_struct_exists(geo_node._children, "LayerElementUV") || !variable_struct_exists(geo_node._children.LayerElementUV._children, "UV"))
	{
		return -1;
	}
    
	var pos_tokens = string_split(geo_node._children.Vertices.a, ",");
	var idx_tokens = string_split(geo_node._children.PolygonVertexIndex.a, ",");
	var nrm_tokens = string_split(geo_node._children.LayerElementNormal._children.Normals.a, ",");
	var uv_tokens = string_split(geo_node._children.LayerElementUV._children.UV.a, ",");
    
	var raw_positions = []; for (var i = 0; i < array_length(pos_tokens); i += 3) { array_push(raw_positions, [real(string_trim(pos_tokens[i])), real(string_trim(pos_tokens[i+1])), real(string_trim(pos_tokens[i+2]))]); }
	var raw_normals = [];   for (var i = 0; i < array_length(nrm_tokens); i += 3) { array_push(raw_normals,   [real(string_trim(nrm_tokens[i])), real(string_trim(nrm_tokens[i+1])), real(string_trim(nrm_tokens[i+2]))]); }
	var raw_uvs = [];       for (var i = 0; i < array_length(uv_tokens); i += 2) { array_push(raw_uvs,         [real(string_trim(uv_tokens[i])), 1.0 - real(string_trim(uv_tokens[i+1]))]); }
	var raw_indices = [];   for (var i = 0; i < array_length(idx_tokens); i++) { var token = string_trim(idx_tokens[i]); if (token != "") { array_push(raw_indices, real(token)); } }

	var processed_verts = [];
	var attr_map_index = 0;
	var polygon_counter = 0;

	for (var i = 0; i < array_length(raw_indices);) {
		var poly_indices = [];
		while (i < array_length(raw_indices)) {
			var index = raw_indices[i];
			i++;
			if (index < 0) {
				array_push(poly_indices, ~index);
				break;
			}
			array_push(poly_indices, index);
		}
		
		var face_normal = raw_normals[polygon_counter];

		for (var j = 2; j < array_length(poly_indices); j++) {
			var v1_pos_idx = poly_indices[0];
			var v2_pos_idx = poly_indices[j - 1];
			var v3_pos_idx = poly_indices[j];
			
			var v1_uv = raw_uvs[attr_map_index];
			var v2_uv = raw_uvs[attr_map_index + j - 1];
			var v3_uv = raw_uvs[attr_map_index + j];
			
			var v1 = { pos: raw_positions[v1_pos_idx], nrm: face_normal, uv: v1_uv };
			var v2 = { pos: raw_positions[v2_pos_idx], nrm: face_normal, uv: v2_uv };
			var v3 = { pos: raw_positions[v3_pos_idx], nrm: face_normal, uv: v3_uv };
			
			if (z_up) {
				var p1 = { pos: [v1.pos[0], v1.pos[2], v1.pos[1]], nrm: [v1.nrm[0], v1.nrm[2], v1.nrm[1]], uv: v1.uv };
				var p2 = { pos: [v2.pos[0], v2.pos[2], v2.pos[1]], nrm: [v2.nrm[0], v2.nrm[2], v2.nrm[1]], uv: v2.uv };
				var p3 = { pos: [v3.pos[0], v3.pos[2], v3.pos[1]], nrm: [v3.nrm[0], v3.nrm[2], v3.nrm[1]], uv: v3.uv };
			} else {
				var p1 = v1; var p2 = v2; var p3 = v3;
			}
			
			array_push(processed_verts, p1, p2, p3);
		}
		attr_map_index += array_length(poly_indices);
		polygon_counter++;
	}
	
	return {
		name: mesh_name,
		vertices: processed_verts
	};
}