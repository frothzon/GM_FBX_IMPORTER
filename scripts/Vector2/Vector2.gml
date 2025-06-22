// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function Vector2(vx = 0, vy = 0) constructor{
	x = vx;
	y = vy;
	static normalize = function(){
		var dis = length();
		x /= dis;
		y /= dis;
	};
	static length = function(){
		return(point_distance(0,0,x,y));
	};
	static set = function(vx, vy){
		x = vx;
		y = vy;
	};
	static add = function(v2){
		x += v2.x;
		y += v2.y;
	};
	static dot = function(v2){
		return(dot_product(x,y,v2.x,v2.y));
	};
	static scale = function(value){
		x *= value;
		y *= value;
	};
	static angle = function(){
		return(point_direction(0,0,x,y));	
	};
	static lengthdir = function(length, angle){
		x = lengthdir_x(length, angle);
		y = lengthdir_y(length, angle);
	};
	static add_lengthdir = function(length, angle){
		x += lengthdir_x(length, angle);
		y += lengthdir_y(length, angle);
	};
	static set_angle = function(angle){
		var _len = self.length();
		self.lengthdir(_len, angle);
	};
	static set_length = function(len){
		self.normalize();
		self.scale(len);
	};
}