/// @function p3d_load_fbx(filepath, z_up)
/// @description Loads an ASCII FBX file and returns an array of P3D_Class models.
/// @param {string} filepath The path to the .fbx file.
/// @param {boolean} z_up Whether to convert from Y-up to Z-up coordinate system.
function p3d_load_fbx(filepath, z_up = true) {
    var p3d_models = [];
    
    // Step 1: Parse the FBX file into a generic data tree
    var root_node = fbx_parse_file_to_nodetree(filepath);
    if (!is_struct(root_node)) {
        show_debug_message("P3D FBX LOAD FAILED: Could not parse node tree.");
        return p3d_models;
    }

    // Step 2: Extract an array of simple mesh data structs from the node tree
    var all_mesh_data = fbx_extract_all_mesh_data(root_node, z_up);
    if (array_length(all_mesh_data) == 0) {
        show_debug_message("P3D FBX LOAD FAILED: No valid mesh data found in file.");
        return p3d_models;
    }

    // Step 3: Iterate through each mesh data and build a P3D_Class object for it
    for (var i = 0; i < array_length(all_mesh_data); i++) {
        var mesh_data = all_mesh_data[i];
        
        // Create a new P3D model object
        var p3d_model = new P3D_Class();
        p3d_model.model_name = mesh_data.name;

        // Add all the processed vertices to the P3D model
        for (var j = 0; j < array_length(mesh_data.vertices); j++) {
            var vert = mesh_data.vertices[j];
            p3d_model.addPoint(vert.pos, vert.nrm, vert.uv, c_white, 1.0);
        }

        // Finalize the P3D model by building its vertex buffer
        p3d_model.build_buffer();
        array_push(p3d_models, p3d_model);
    }

    show_debug_message("P3D FBX LOAD SUCCESS: Created " + string(array_length(p3d_models)) + " P3D models.");
    return p3d_models;
}