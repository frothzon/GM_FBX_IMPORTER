// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function vertex_add_sphere(vbuffer, hVerts, vVerts, hRep, vRep, radius=1){

	for(var xx = 0; xx < hVerts; xx++){
		
		var xa1 = xx / hVerts * 2 * pi;
		var xa2 = (xx+1) / hVerts * 2 * pi;
		var xc1 = cos(xa1)*radius;
		var xs1 = sin(xa1)*radius;
		var xc2 = cos(xa2)*radius;
		var xs2 = sin(xa2)*radius;
		
		for(var yy = 0; yy < vVerts; yy++){
			var ya1 = yy / vVerts * 2 * pi;
			var ya2 = (yy+1) / vVerts * 2 * pi;
			var yc1 = cos(ya1)*radius;
			var ys1 = sin(ya1)*radius;
			var yc2 = cos(ya2)*radius;
			var ys2 = sin(ya2)*radius;
			
			/// add 6 points
			vertex_add_point(vbuffer, 
				[xc1 * ys1, xs1 * ys1, yc1], /// position
				[xc1 * ys1, xs1 * ys1, yc1],
				[clamp(xx / hVerts * hRep, 0, 1), clamp(yy / vVerts * vRep, 0, 1)],
				c_white, 1
			);
			vertex_add_point(vbuffer, 
				[xc1 * ys2, xs1 * ys2, yc2], /// position
				[xc1 * ys2, xs1 * ys2, yc2],
				[clamp(xx / hVerts * hRep, 0, 1), clamp((yy+1) / vVerts * vRep, 0, 1)],
				c_white, 1
			);
			vertex_add_point(vbuffer, 
				[xc2 * ys1, xs2 * ys1, yc1], /// position
				[xc2 * ys1, xs2 * ys1, yc1],
				[clamp((xx+1) / hVerts * hRep, 0, 1), clamp(yy / vVerts * vRep, 0, 1)],
				c_white, 1
			);
			
			//
			vertex_add_point(vbuffer, 
				[xc1 * ys2, xs1 * ys2, yc2], /// position
				[xc1 * ys2, xs1 * ys2, yc2],
				[clamp(xx / hVerts * hRep, 0, 1), clamp((yy+1) / vVerts * vRep, 0, 1)],
				c_white, 1
			);
			vertex_add_point(vbuffer, 
				[xc2 * ys2, xs2 * ys2, yc2], /// position
				[xc2 * ys2, xs2 * ys2, yc2],
				[clamp((xx+1) / hVerts * hRep, 0, 1), clamp((yy+1) / vVerts * vRep, 0, 1)],
				c_white, 1
			);
			vertex_add_point(vbuffer, 
				[xc2 * ys1, xs2 * ys1, yc1], /// position
				[xc2 * ys1, xs2 * ys1, yc1],
				[clamp((xx+1) / hVerts * hRep, 0, 1), clamp(yy / vVerts * vRep, 0, 1)],
				c_white, 1
			);
			
		}
	}
}