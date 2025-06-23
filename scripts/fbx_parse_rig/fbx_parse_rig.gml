/// @description Functions to parse skeleton and bind pose data from an FBX node tree.

/// @function fbx_parse_rig(root_node)
/// @description Parses all rig-related data from the node tree and returns a populated FBXRig struct.
/// @param {struct} root_node The root node from the fbx_parse_file_to_nodetree function.
function fbx_parse_rig(root_node) {
    var rig = new FBXRig();
    if (!is_struct(root_node) || !variable_struct_exists(root_node, "_children")) {
        return rig;
    }

    var objects_node = root_node._children.Objects;
    var connections_node = root_node._children.Connections;

    if (!is_struct(objects_node) || !is_struct(connections_node)) {
        show_debug_message("FBX Rig Parse WARNING: Missing Objects or Connections sections.");
        return rig;
    }

    // 1. Find all potential bones (Model nodes) and create a map keyed by their FBX ID.
    var bone_map = _fbx_find_bones(objects_node);
    if (ds_map_size(bone_map) == 0) {
        show_debug_message("FBX Rig Parse: No model nodes found to build a skeleton.");
        ds_map_destroy(bone_map);
        return rig;
    }

    // 2. Build the hierarchy by parsing the connections.
    _fbx_build_hierarchy(connections_node, bone_map);

    // 3. Convert the map of bones into a simple array for our rig, sorted by index.
    // This step also creates a new map to find an array index from an fbx_id.
    var id_to_index_map = ds_map_create();
    var bone_list = [];
    var map_keys = ds_map_keys_to_array(bone_map);
    for (var i = 0; i < array_length(map_keys); i++) {
        var key = map_keys[i];
        var bone = bone_map[? key];
        ds_map_add(id_to_index_map, key, array_length(bone_list));
        array_push(bone_list, bone);
    }
    
    // 4. Final pass to set the integer-based parentIndex for each bone.
    for (var i = 0; i < array_length(bone_list); i++) {
        var bone = bone_list[i];
        if (bone.parentIndex != -1) { // parentIndex currently holds the parent's FBX ID
            var parent_fbx_id = bone.parentIndex;
            if (ds_map_exists(id_to_index_map, parent_fbx_id)) {
                bone.parentIndex = id_to_index_map[? parent_fbx_id];
            } else {
                bone.parentIndex = -1; // Parent is not in our bone list.
            }
        }
    }
    
    rig.bones = bone_list;
    ds_map_destroy(bone_map);

    // 5. Parse the Deformer and Pose nodes to get the bind pose matrices.
    _fbx_parse_bind_pose(objects_node, id_to_index_map, rig);
    
    ds_map_destroy(id_to_index_map);

    show_debug_message("FBX Rig Parse SUCCESS: Created skeleton with " + string(array_length(rig.bones)) + " bones.");
    return rig;
}

/// @function _fbx_find_bones(objects_node)
/// @description Finds all 'Model' nodes and returns them in a map keyed by FBX ID.
function _fbx_find_bones(objects_node) {
    var bone_map = ds_map_create();
    if (!variable_struct_exists(objects_node._children, "Model")) {
        return bone_map;
    }
    
    var model_nodes = objects_node._children.Model;
    if (!is_array(model_nodes)) {
        model_nodes = [model_nodes];
    }
    
    for (var i = 0; i < array_length(model_nodes); i++) {
        var node = model_nodes[i];
        var props = string_split(node._properties, ",");
        
        var fbx_id = real(string_trim(props[0]));
        var name_full = string_replace_all(string_trim(props[1]), "\"", "");
        var name_parts = string_split(name_full, "::");
        var name = name_parts[array_length(name_parts)-1];
        
        var new_bone = new FBXBone();
        new_bone.fbx_id = fbx_id;
        new_bone.name = name;
        
        bone_map[? fbx_id] = new_bone;
    }
    
    return bone_map;
}

/// @function _fbx_build_hierarchy(connections_node, bone_map)
/// @description Parses the 'Connections' block to set the parent for each bone.
function _fbx_build_hierarchy(connections_node, bone_map) {
    if (!variable_struct_exists(connections_node._children, "C")) {
        return;
    }
    
    var connections = connections_node._children.C;
    if (!is_array(connections)) {
        connections = [connections];
    }
    
    for (var i = 0; i < array_length(connections); i++) {
        var props_str = connections[i]._properties;
        var props = string_split(string_replace_all(props_str, "\"", ""), ",");
        
        if (array_length(props) < 3 || string_trim(props[0]) != "OO") {
            continue; // We only care about Object-to-Object connections
        }
        
        var child_id = real(string_trim(props[1]));
        var parent_id = real(string_trim(props[2]));
        
        if (ds_map_exists(bone_map, child_id) && ds_map_exists(bone_map, parent_id)) {
            var child_bone = bone_map[? child_id];
            child_bone.parentIndex = parent_id; // Temporarily store the parent's FBX ID
        }
    }
}

/// @function _fbx_parse_bind_pose(objects_node, id_to_index_map, rig)
/// @description Finds Deformer and Pose nodes to extract bind pose matrices.
function _fbx_parse_bind_pose(objects_node, id_to_index_map, rig) {
    if (!variable_struct_exists(objects_node._children, "Pose")) {
        show_debug_message("FBX Bind Pose WARNING: No 'Pose' node found.");
        return;
    }
    
    var pose_node = objects_node._children.Pose;
    if (is_array(pose_node)) {
        pose_node = pose_node[0];
    }
    
    if (!is_struct(pose_node) || !variable_struct_exists(pose_node, "_children") || !variable_struct_exists(pose_node._children, "PoseNode")) {
        return;
    }
    
    var pose_nodes = pose_node._children.PoseNode;
    if (!is_array(pose_nodes)) {
        pose_nodes = [pose_nodes];
    }
    
    for (var i = 0; i < array_length(pose_nodes); i++) {
        var p_node = pose_nodes[i];
        if (!variable_struct_exists(p_node._children, "Node") || !variable_struct_exists(p_node._children, "Matrix")) {
            continue;
        }
        
        var fbx_id = real(p_node._children.Node._properties);
        var matrix_tokens = string_split(p_node._children.Matrix.a, ",");
        
        if (ds_map_exists(id_to_index_map, fbx_id) && array_length(matrix_tokens) == 16) {
            var bone_index = id_to_index_map[? fbx_id];
            var bone = rig.bones[bone_index];
            
            // Build the 2D matrix directly from the parsed tokens
            var bind_matrix_2d = array_create(4);
            for(var row = 0; row < 4; row++) {
                bind_matrix_2d[row] = array_create(4);
                for (var col = 0; col < 4; col++) {
                    bind_matrix_2d[row][col] = real(string_trim(matrix_tokens[col * 4 + row]));
                }
            }
            
            // Invert the 2D matrix. The matrix_invert function now expects and returns a 2D array.
            bone.inverseBindMatrix = matrix_invert(bind_matrix_2d);
        }
    }
}
