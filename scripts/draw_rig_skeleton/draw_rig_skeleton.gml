/// @function draw_skeleton(rig)
/// @description Draws a visual representation of a skeleton rig for debugging.
/// @param {struct} rig The FBXRig struct containing the bone data.
function draw_rig_skeleton(rig) {
    if (!is_struct(rig) || array_length(rig.bones) == 0) {
        return;
    }

    var bone_count = array_length(rig.bones);
    var world_matrices = array_create(bone_count);

    // First, calculate and store the world matrix for every bone.
    // The world matrix is the inverse of the inverseBindMatrix.
    for (var i = 0; i < bone_count; i++) {
        world_matrices[i] = matrix_invert(rig.bones[i].inverseBindMatrix);
    }

    // Now, iterate through and draw the bones and joints.
    for (var i = 0; i < bone_count; i++) {
        var bone = rig.bones[i];
        var child_matrix = world_matrices[i];
        
        // Extract the position (joint) of the current bone.
        var child_pos = {
            x: matrix_get_translation_x(child_matrix),
            y: matrix_get_translation_y(child_matrix),
            z: matrix_get_translation_z(child_matrix)
        };

        // Draw a small cube at the joint's position
        var joint_size = 3;
        var mat_joint = matrix_build(child_pos.x, child_pos.y, child_pos.z, 0, 0, 0, joint_size, joint_size, joint_size);
        matrix_set(matrix_world, mat_joint);
        shader_set(shd_simple_unlit);
        vertex_submit(global.debug_box_vb, pr_linelist, -1);
        shader_reset();
        
        // If the bone has a parent, draw a line connecting them.
        if (bone.parentIndex != -1 && bone.parentIndex < bone_count) {
            var parent_matrix = world_matrices[bone.parentIndex];
            var parent_pos = {
                x: matrix_get_translation_x(parent_matrix),
                y: matrix_get_translation_y(parent_matrix),
                z: matrix_get_translation_z(parent_matrix)
            };
            
            // Draw a line representing the bone
            draw_line_3d_color(parent_pos.x, parent_pos.y, parent_pos.z, child_pos.x, child_pos.y, child_pos.z, c_yellow, c_lime);
        }
    }
    
    // Reset the world matrix
    matrix_set(matrix_world, matrix_build_identity());
}
