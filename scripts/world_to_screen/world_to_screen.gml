// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function world_to_screen(xx, yy, zz, view_mat, proj_mat){
/// @param xx
/// @param yy
/// @param zz
/// @param view_mat
/// @param proj_mat
/*
    Transforms a 3D world-space coordinate to a 2D window-space coordinate. Returns an array of the following format:
    [xx, yy]
    Returns {x, y} if the 3D point is not in view
   
    Script created by TheSnidr
    www.thesnidr.com
*/

if (proj_mat[15] == 0) {   //This is a perspective projection
    var w = view_mat[2] * xx + view_mat[6] * yy + view_mat[10] * zz + view_mat[14];
    // If you try to convert the camera's "from" position to screen space, you will
    // end up dividing by zero (please don't do that)
    if (w <= 0) return {x:-10000,y: -10000};
    if (w == 0) return {x:-10000,y: -10000};
    var cx = proj_mat[8] + proj_mat[0] * (view_mat[0] * xx + view_mat[4] * yy + view_mat[8] * zz + view_mat[12]) / w;
    var cy = proj_mat[9] + proj_mat[5] * (view_mat[1] * xx + view_mat[5] * yy + view_mat[9] * zz + view_mat[13]) / w;
} else {    //This is an ortho projection
    var cx = proj_mat[12] + proj_mat[0] * (view_mat[0] * xx + view_mat[4] * yy + view_mat[8]  * zz + view_mat[12]);
    var cy = proj_mat[13] + proj_mat[5] * (view_mat[1] * xx + view_mat[5] * yy + view_mat[9]  * zz + view_mat[13]);
}

return {x: (0.5 + 0.5 * cx) * window_get_width(), y:  (0.5 + 0.5 * cy) * window_get_height()};
}