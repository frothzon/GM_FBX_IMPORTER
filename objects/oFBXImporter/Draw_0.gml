/// @description Draw 3D scene and GUI

// -- Draw 3D Scene --
gpu_set_ztestenable(true);
gpu_set_zwriteenable(true);
gpu_set_cullmode(cull_counterclockwise);

// Clear the background
draw_clear_alpha(c_dkgray, 1.0);

// Set up 3D projection
camera_apply(camera);

// Draw the grid
draw_grid();

// Draw the imported FBX model
if (is_struct(fbx_model) && array_length(fbx_model.meshes) > 0) {
    matrix_set(matrix_world, matrix_build_identity());
    
    // Loop through each mesh and submit its vertex buffer
    for (var i = 0; i < array_length(fbx_model.meshes); i++) {
        var mesh = fbx_model.meshes[i];
        vertex_submit(mesh.vertexBuffer, pr_trianglelist, placeholder_tex);
    }
}

// Draw the skeleton for debugging
if (is_struct(fbx_model) && is_struct(fbx_model.rig)) {
    draw_rig_skeleton(fbx_model.rig);
}

// -- Draw Debug Bounding Box --
if (is_struct(model_bbox)) {
    var bbox = model_bbox;
    var size_x = bbox.x2 - bbox.x1;
    var size_y = bbox.y2 - bbox.y1;
    var size_z = bbox.z2 - bbox.z1;
    var center_x = (bbox.x1 + bbox.x2) / 2;
    var center_y = (bbox.y1 + bbox.y2) / 2;
    var center_z = (bbox.z1 + bbox.z2) / 2;
    
    var mat_bbox = matrix_build(center_x, center_y, center_z, 0, 0, 0, size_x, size_y, size_z);
    matrix_set(matrix_world, mat_bbox);
    
    shader_set(shd_simple_unlit);
    vertex_submit(global.debug_box_vb, pr_linelist, -1);
    shader_reset();
    
    matrix_set(matrix_world, matrix_build_identity());
}

// -- Draw GUI --
gpu_set_ztestenable(false);
gpu_set_zwriteenable(false);
gpu_set_cullmode(cull_noculling);

// Note: camera_apply for the GUI is handled in the Draw GUI event