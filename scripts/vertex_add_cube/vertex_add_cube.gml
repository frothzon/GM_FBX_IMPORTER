// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function vertex_add_cube(vbuffer,x1,y1,z1,x2,y2,z2,col,alpha){
	/// top of cube
	/// vbuffer,x1,y1,z1,x2,y2,z2,col,alpha
	vertex_add_floor(vbuffer, x1, y1, z1, x2, y2, z1, col, alpha);
	vertex_add_floor(vbuffer, x1, y1, z2, x2, y2, z2, col, alpha);
	
	/// front
	vertex_add_wall(vbuffer, x1, y2, z1, x2, y2, z2, col, alpha);
	/// right
	vertex_add_wall(vbuffer, x2, y2, z1, x2, y1, z2, col, alpha);
	/// back
	vertex_add_wall(vbuffer, x2, y1, z1, x1, y1, z2, col, alpha);
	/// left
	vertex_add_wall(vbuffer, x1, y1, z1, x1, y2, z2, col, alpha);
}