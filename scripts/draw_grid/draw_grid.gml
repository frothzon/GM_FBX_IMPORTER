/// @description Draws a 3D grid
function draw_grid() {
    var grid_size = 1000;
    var grid_step = 50;
    
    shader_set(shd_grid);
    
    // Draw grid lines
    for (var i = -grid_size; i <= grid_size; i += grid_step) {
        vertex_submit(global.grid_vb, pr_linelist, -1);
        
        matrix_set(matrix_world, matrix_build(i, 0, 0, 0, 0, 0, 1, 1, 1));
        vertex_submit(global.grid_vb, pr_linelist, -1);

        matrix_set(matrix_world, matrix_build(0, i, 0, 0, 0, 90, 1, 1, 1));
        vertex_submit(global.grid_vb, pr_linelist, -1);
    }

    matrix_set(matrix_world, matrix_build_identity());
    shader_reset();
}