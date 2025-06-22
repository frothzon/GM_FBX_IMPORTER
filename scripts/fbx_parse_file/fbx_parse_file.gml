/// @function fbx_parse_file(filepath, z_up)
/// @description Parses an FBX file and converts it into a renderable FBXModel structure.
/// @param {string} filepath The path to the .fbx file.
/// @param {boolean} z_up Whether to convert from Y-up to Z-up coordinate system.
function fbx_parse_file(filepath, z_up = true) {
    // Create the main model container
    var model = fbx_model_create(filepath);

    // Step 1: Parse the FBX file into a generic data tree
    var root_node = fbx_parse_file_to_nodetree(filepath);
    if (!is_struct(root_node)) {
        show_debug_message("FBX LOAD FAILED: Could not parse node tree from " + filepath);
        model.destroy();
        return -1;
    }

    // Step 2: Extract an array of simple mesh data structs from the node tree
    var all_mesh_data = fbx_extract_all_mesh_data(root_node, z_up);
    if (array_length(all_mesh_data) == 0) {
        show_debug_message("FBX LOAD FAILED: No valid mesh data found in file " + filepath);
        model.destroy();
        return -1;
    }
    
    // Step 3: Iterate through each mesh data and build an FBXMesh object for it
    for (var i = 0; i < array_length(all_mesh_data); i++) {
        var mesh_data = all_mesh_data[i];
        
        // Create a new mesh struct to hold this mesh's data
        var new_mesh = new FBXMesh();
        new_mesh.name = mesh_data.name;
        new_mesh.processed_vertex_data = mesh_data.vertices; // Store for debugging/later use
        
        // The raw vertex data for bounding box is just the position arrays
        for(var j = 0; j < array_length(mesh_data.vertices); j++) {
            array_push(new_mesh.raw_vertex_data, mesh_data.vertices[j].pos);
        }

        // Create a vertex buffer for this mesh
        var vb = vertex_create_buffer();
        vertex_begin(vb, global.fbx_vertex_format);
        
        // Add all the processed vertices to the vertex buffer
        for (var j = 0; j < array_length(mesh_data.vertices); j++) {
            var vert = mesh_data.vertices[j];
            vertex_position_3d(vb, vert.pos[0], vert.pos[1], vert.pos[2]);
            vertex_normal(vb, vert.nrm[0], vert.nrm[1], vert.nrm[2]);
            vertex_texcoord(vb, vert.uv[0], vert.uv[1]);
            vertex_color(vb, c_white, 1.0); // Default to white
        }
        
        vertex_end(vb);
        vertex_freeze(vb); // Freeze the buffer for performance
        
        // Assign the completed buffer to the mesh struct
        new_mesh.vertexBuffer = vb;
        new_mesh.vertexCount = array_length(mesh_data.vertices);
        
        // Add the completed mesh to our main model
        array_push(model.meshes, new_mesh);
    }
    
    show_debug_message("FBX LOAD SUCCESS: Created model with " + string(array_length(model.meshes)) + " meshes.");
    
    return model;
}