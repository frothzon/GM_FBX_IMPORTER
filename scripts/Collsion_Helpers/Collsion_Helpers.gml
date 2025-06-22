// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function NewColAABBFromMinMax(point_min, point_max){
	var center_position = point_min.Add(point_max).Div(2);
	var half_size = point_max.Sub(point_min).Div(2).Abs();
	return new ColAABB(center_position, half_size);
}

function NewColRayFromPoints(start, finish){
	return new ColRay(start, finish.Sub(start).Normalize());
}

function RaycastHitInformation() constructor {
	self.shape = undefined;
	self.point = undefined;
	self.distance = infinity;
	self.normal = undefined; /// vector3
	
	static Update = function(distance, shape, point, normal) {
		if (distance < self.distance) {
			self.distance = distance;
			self.shape = shape;
			self.point = point;
			self.normal = normal;
		}
	};
	
	static Clear = function(){
		self.shape = undefined;
		self.point = undefined;
		self.distance = infinity;
		self.normal = undefined; /// vector3
	};
	
	static UpdateDirect = function(RCHI){
		self.Update(RCHI.distance, RCHI.shape, RCHI.point, RCHI.normal);
	};
	
	static toString = function(){
		return string("Shape {0}\nPoint {1}\nDistance {2}\nNormal {3}", self.shape, self.point, self.distance, self.normal);	
	};
}