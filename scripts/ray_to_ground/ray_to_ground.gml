// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function ray_to_ground(ray, height){
	var slope = ray.direction;
	var intercept = ray.origin;
	var e = (height - intercept.z) / slope.z;
	var fx = e * slope.x + intercept.x;
	var fy = e * slope.y + intercept.y;
	/*
	var fx = mouse_ray[0] * mouse_ray[5] / -mouse_ray[2] + mouse_ray[3];
	var fy = mouse_ray[1] * mouse_ray[5] / -mouse_ray[2] + mouse_ray[4];
	*/
	return(new Vector3(fx, fy, height));
}
