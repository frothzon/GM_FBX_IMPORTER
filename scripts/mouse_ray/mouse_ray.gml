// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function mouse_ray(_x, _y, view_mat, proj_mat){
	/*
	Transforms a 2D coordinate (in window space) to a 3D vector.
	Returns a Vector3
	where {dx, dy, dz} is the direction vector.
	Works for both orthographic and perspective projections.
	Script created by TheSnidr
	(slightly modified by @dragonitespam)
	*/

	var mx = 2 * (_x / window_get_width() - .5) / proj_mat[0];
	var my = 2 * (_y / window_get_height() - .5) / proj_mat[5];
	var camX = - (view_mat[12] * view_mat[0] + view_mat[13] * view_mat[1] + view_mat[14] * view_mat[2]);
	var camY = - (view_mat[12] * view_mat[4] + view_mat[13] * view_mat[5] + view_mat[14] * view_mat[6]);
	var camZ = - (view_mat[12] * view_mat[8] + view_mat[13] * view_mat[9] + view_mat[14] * view_mat[10]);

	if (proj_mat[15] == 0) {
		
	    //This is a perspective projection
		var px = view_mat[2]  + mx * view_mat[0] + my * view_mat[1];
		var py = view_mat[6]  + mx * view_mat[4] + my * view_mat[5];
		var pz = view_mat[10] + mx * view_mat[8] + my * view_mat[9];
	    return new ColRay(new Vector3(camX, camY, camZ), new Vector3(px, py, pz));
		
	} else {
	    //This is an ortho projection
	    var px = view_mat[2];
		var py = view_mat[6];
		var pz = view_mat[10];
		var ox = camX + mx * view_mat[0] + my * view_mat[1];
		var oy = camY + mx * view_mat[4] + my * view_mat[5];
		var oz = camZ + mx * view_mat[8] + my * view_mat[9];
	    return new ColRay(new Vector3(ox, oy, oz), new Vector3(px, py, pz));
	}
}