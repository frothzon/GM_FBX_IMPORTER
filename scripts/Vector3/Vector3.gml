// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function Vector3(x=0, y=0, z=0) constructor{
	self.x = x;
	self.y = y;
	self.z = z;
	
	static Add = function(val){
		if(is_numeric(val)){
			return new Vector3(self.x + val, self.y + val, self.z + val);
		} else {
			return new Vector3(self.x + val.x, self.y + val.y, self.z + val.z);
		}
	};
	
	static Sub = function(val){
		if(!is_struct(val)){
			return new Vector3(self.x - val, self.y - val, self.z - val);
		} else {
			return new Vector3(self.x - val.x, self.y - val.y, self.z - val.z);
		}
	};
	
	static Mul = function(val){
		if(is_numeric(val)){
			return new Vector3(self.x * val, self.y * val, self.z * val);
		}
		return new Vector3(self.x * val.x, self.y * val.y, self.z * val.z);
		
	};
	
	static Div = function(val){
		if(is_numeric(val)){
			return new Vector3(self.x / val, self.y / val, self.z / val);
		}
		return new Vector3(self.x / val.x, self.y / val.y, self.z / val.z);
		
	};
	
	static Magnitude = function(){
		return point_distance_3d(0,0,0,self.x,self.y,self.z);	
	};
	
	static DistanceTo = function(val){
		return point_distance_3d(val.x,val.y,val.z,self.x,self.y,self.z);	
	};
	
	static Dot = function(val){
		return dot_product_3d(val.x,val.y,val.z,self.x,self.y,self.z);
	};
	
	static Cross = function(val){
		var cx = self.y * val.z - self.z * val.y;
		var cy = self.z * val.x - self.x * val.z;
		var cz = self.x * val.y - self.y * val.x;
		return new Vector3(cx, cy, cz);
	};
	
	static Equals = function(val){
		return self.x == val.x && self.y == val.y && self.z == val.z;	
	};
	
	static Normalize = function(){
		var mag = self.Magnitude();
		if(mag == 0) return new Vector3(0, 0, 0);
		//var invmag = self.InverseMag();
		return new Vector3(self.x/mag, self.y/mag, self.z/mag);
	};
	
	static Abs = function(){
		return new Vector3(abs(self.x), abs(self.y), abs(self.z));	
	};
	
	static GetMin = function(val){
		return new Vector3(min(self.x, val.x), min(self.y, val.y), min(self.z, val.z));
	};
	
	static GetMax = function(val){
		return new Vector3(max(self.x, val.x), max(self.y, val.y), max(self.z, val.z));
	};
	
	static Copy = function(){
		return new Vector3(self.x, self.y, self.z);	
	};
	
	static CopySafe = function(){
		var safe_x = self.x == 0 ? 0.0001 : self.x;
		var safe_y = self.y == 0 ? 0.0001 : self.y;
		var safe_z = self.z == 0 ? 0.0001 : self.z;
		return new Vector3(safe_x, safe_y, safe_z);	
	};
	
	static MinAxis = function(){
		return min(self.x, self.y, self.z);
	};
	
	static MaxAxis = function(){
		return max(self.x, self.y, self.z);
	};
	
	static toArray = function(){
		return [self.x, self.y, self.z];	
	};
	
	static fromArray = function(arr){
		self.x = arr[0];
		self.y = arr[1];
		self.z = arr[2];
	};
	
	static toMatrix = function(){
		var mat = matrix_build(self.x, self.y, self.z, 0, 0, 0, 1, 1, 1);
		return mat;
	};
	
	static Project = function(direction){
		var dot = self.Dot(direction);
		var mag = direction.Magnitude();
		//mag = mag.CopySafe();
		return direction.Mul(dot / (mag * mag));
	};
	
	static Change = function(x1, y1, z1){
		self.x = x1;
		self.y = y1;
		self.z = z1;
	};
	
	static fromSphere = function(radius, phi, alpha){
		self.x = radius * dsin(phi) * dcos(alpha);
		self.y = radius * dsin(phi) * dsin(alpha);
		self.z = radius * dcos(phi);
	};
	
	static Lerp = function(vec, ratio){
		self.x = lerp(self.x, vec.x, ratio);	
		self.y = lerp(self.y, vec.y, ratio);
		self.z = lerp(self.z, vec.z, ratio);
	};
	
	// New method to create a vector from length and rotations
    static fromLengthAndRotation = function(length, rotx, roty, rotz) {
        var _x = length * dcos(roty) * dcos(rotz);
        var _y = length * dcos(rotx) * dsin(rotz);
        var _z = length * dsin(rotx) * dcos(roty);

        self.x = _x;
        self.y = _y;
        self.z = _z;
    };

}