// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function vertex_add_wall(vbuffer,x1,y1,z1,x2,y2,z2,col,alpha){

	var p1 = [x1,y1,z1];
	var p2 = [x2,y2,z1];
	var p3 = [x2,y2,z2];
	var p4 = [x1,y1,z2];
	var n1 = calculate_normal(p1, p3, p2);
	var n2 = calculate_normal(p1, p4, p3);
	
	/// tri 1
	vertex_add_point(vbuffer, p1, n1, [0,0], col, alpha);
	vertex_add_point(vbuffer, p2, n1, [1,0], col, alpha);
	vertex_add_point(vbuffer, p3, n1, [1,1], col, alpha);

	/// tri 2
	vertex_add_point(vbuffer, p1, n2, [0,0], col, alpha);
	vertex_add_point(vbuffer, p3, n2, [1,1], col, alpha);
	vertex_add_point(vbuffer, p4, n2, [0,1], col, alpha);
}