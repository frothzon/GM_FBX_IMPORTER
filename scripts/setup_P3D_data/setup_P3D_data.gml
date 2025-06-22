//============================================================
// CONSOLIDATED INITIALIZATION SCRIPT
// Contains all functions needed for vertex format and basic model setup.
//============================================================

// --- From: create_P3D_struct.gml ---

function create_P3D_struct(){
	return new P3D_Class();
}

function start_vertex_buffer_model(){
	var vbuffer = vertex_create_buffer();
	vertex_begin(vbuffer, global.VERTEX_FORMAT);
	return(vbuffer);
}

function finish_vertex_buffer_model(vbuff){
	vertex_end(vbuff);
}

function calculate_normal(A_v3, B_v3, C_v3){
	var ax = B_v3[0] - A_v3[0];
	var ay = B_v3[1] - A_v3[1];
	var az = B_v3[2] - A_v3[2];
	var bx = C_v3[0] - A_v3[0];
	var by = C_v3[1] - A_v3[1];
	var bz = C_v3[2] - A_v3[2];

	var nx = ay * bz - az * by;
	var ny = az * bx - ax * bz;
	var nz = ax * by - ay * bx;

	var mag = point_distance_3d(0,0,0,nx,ny,nz);
	if (mag == 0) return [0, 0, 1]; // Return a default up-vector to prevent division by zero

	nx /= mag;
	ny /= mag;
	nz /= mag;

	return([nx, ny, nz]);
}
