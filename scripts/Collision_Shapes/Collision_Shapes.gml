// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function ColPoint(position) constructor {
	self.position = position;			/// Vec3
	
	static CheckPoint = function(point){
		return self.position.Equals(point.position);
	};
	static CheckSphere = function(sphere){
		return self.position.DistanceTo(sphere.position) <= sphere.radius;
	};
	static CheckAABB = function(aabb){
		// if inside rectangle it will have values in between
		// Xmin <= Xpnt <= Xmax, Ymin <= Ypnt <= Ymax, Zmin <= Zpnt <= Zmax
		// So... the absolute value will equal the difference
		var box_min = aabb.GetMin();
		var box_max = aabb.GetMax();
		if(self.position.x < box_min.x || self.position.y < box_min.y || self.position.z < box_min.z) return false;
		if(self.position.x > box_max.x || self.position.y > box_max.y || self.position.z > box_max.z) return false;
		return true;
	};
	static CheckPlane = function(plane){
		var ndot = self.position.Dot(plane.normal);
		return ndot == plane.distance;
	};
	static CheckRay = function(ray, hit_info){
		var nearest = ray.NearestPoint(self.position);
		if(nearest.DistanceTo(self.position) != 0) return false;
		
		/// set hit info
		hit_info.Update(self.position.DistanceTo(ray.origin), self, self.position, undefined);
		
		return true;
	};
	static CheckLine = function(line){
		
	};
	static CheckTriangle = function(triangle){
		var pa = triangle.a.Sub(self.position);
		var pb = triangle.b.Sub(self.position);
		var pc = triangle.c.Sub(self.position);
		
		var normPBC = pb.Cross(pc).Normalize();
		var normPCA = pc.Cross(pa).Normalize();
		var normPAB = pa.Cross(pb).Normalize();
		
		if(normPBC.Dot(normPCA) < 1){
			return false;
		}
		if(normPBC.Dot(normPAB) < 1){
			return false;	
		}
		
		return true;
	};
}
function ColSphere(position, radius) constructor {
	self.position = position;			/// Vec3
	self.radius = radius;				/// Vec3
	
	static CheckPoint = function(point){
		return point.CheckSphere(self);
	};
	static CheckSphere = function(sphere){
		return self.position.DistanceTo(sphere.position) <= (sphere.radius + self.radius);
	};
	static CheckAABB = function(aabb){
		var nearest = aabb.NearestPoint(self.position);
		var dist = nearest.DistanceTo(self.position);
		return dist <= self.radius;
	};
	static CheckPlane = function(plane){
		var nearest = plane.NearestPoint(self.position);
		var dist = nearest.DistanceTo(self.position);
		return dist <= self.radius;
	};
	static CheckRay = function(ray, hit_info){
		var e = self.position.Sub(ray.origin);
		var mag_sq = power(e.Magnitude(), 2);
		var r_sq = power(self.radius, 2);
		var EdotD = e.Dot(ray.direction);
		var offset = r_sq - (mag_sq - power(EdotD, 2));
		if (offset < 0) return false;
		
		var f = sqrt(abs(offset));
		var t = EdotD - f;	/// hit distance
		/// if inside of sphere
		if (mag_sq < r_sq ){
			t = EdotD + f;	
		};
		var contact_point = ray.origin.Add(ray.direction.Mul(t));
		
		/// update hit info
		hit_info.Update(t, self, contact_point, contact_point.Sub(self.position).Normalize());
		
		return true;
		
	};
	static CheckLine = function(line){
		
	};
	static CheckTriangle = function(triangle){
		var nearest = triangle.NearestPoint(self.position);
		var dist = nearest.DistanceTo(self.position);
		return dist <= self.radius;
	};
	static NearestPoint = function(vec3){
		var dist = vec3.Sub(self.position).Normalize();
		var scaled_dist = dist.Mul(self.radius);
		return scaled_dist.Add(self.position);
	};
}
function ColAABB(position, half_extents) constructor {
	self.position = position;			/// Vec3
	self.half_extents = half_extents;	/// Vec3
	
	static CheckPoint = function(point){
		return point.CheckAABB(self);
	};
	static CheckSphere = function(sphere){
		return sphere.CheckAABB(self);
	};
	static CheckAABB = function(aabb){
		var b2mn = aabb.GetMin();
		var b2mx = aabb.GetMax();
		var b1mn = self.GetMin();
		
		var b1mx = self.GetMax();
		return ((b1mn.x <= b2mx.x) && (b1mx.x >= b2mn.x) && (b1mn.y <= b2mx.y) && (b1mx.y >= b2mn.y) && (b1mn.z <= b2mx.z) && (b1mx.z >= b2mn.z));
		//return self.CheckAABBSAT(aabb);
	};
	static CheckPlane = function(plane){
		var anorm = plane.normal.Abs();
		var plength = self.half_extents.Dot(anorm);
		var ndot = plane.normal.Dot(self.position);
		var dist = ndot - plane.distance;
		return abs(dist) < plength;
		
	};
	static CheckRay = function(ray, hit_info){
		var box_min = self.GetMin();	/// corner 0,0,0
		var box_max = self.GetMax();	/// corner X,Y,Z
		
		var ray_dir_safe = ray.direction.CopySafe(); // get copy of vector pointing in ray direction (that can never be 0 length)

		var v1 = box_min.Sub(ray.origin);	/// vector from ray origin pointing to corner 0,0,0
		var v2 = box_max.Sub(ray.origin);   /// vector from ray origin pointing to corner X,Y,Z
		v1 = v1.Div(ray_dir_safe);
		v2 = v2.Div(ray_dir_safe);
		
		var v_min = v1.GetMin(v2); /// shortest vector, V1 or V2
		var v_max = v1.GetMax(v2); /// longest vector, V1 or V2
		
		var min_axis = v_min.MaxAxis(); /// longest AXIS on the shortest Vector
		var max_axis = v_max.MinAxis(); /// shortest AXIS on the longest Vector

		if(max_axis < 0) {
			return false;
		}
		if(min_axis > max_axis) {
			return false;
		}
		
		/// hit information
		var t = max_axis;
		if(min_axis > 0){
			t = min_axis;	
		}
		
		var contact_point = ray.origin.Add(ray.direction.Mul(t));
		
		var tnormal = new Vector3(0,0,0);
		
		/// check which face the collision falls on, and change the normal
		/// to match the surface normal of the face
		switch(t){
			case v1.x: tnormal.x = -1; break;
			case v1.y: tnormal.y = -1; break;
			case v1.z: tnormal.z = -1; break;
			case v2.x: tnormal.x = 1; break;
			case v2.y: tnormal.y = 1; break;
			case v2.z: tnormal.z = 1; break;
			
		};
		
		hit_info.Update(t, self, contact_point, tnormal);
		
		return true;
		
	};
	static CheckLine = function(line){
		
	};
	
	static CheckTriangle = function(triangle){
		var ab = triangle.b.Sub(triangle.a);
		var bc = triangle.c.Sub(triangle.b);
		var ca = triangle.a.Sub(triangle.c);
		
		var nx = new Vector3(1, 0, 0);
		var ny = new Vector3(0, 1, 0);
		var nz = new Vector3(0, 0, 1);
		
			
		var axes = [
			nx,
			ny,
			nz,
			triangle.GetNormal(),
			nx.Cross(ab),
			nx.Cross(bc),
			nx.Cross(ca),
			ny.Cross(ab),
			ny.Cross(bc),
			ny.Cross(ca),
			nz.Cross(ab),
			nz.Cross(bc),
			nz.Cross(ca)
		];
		
		for(var i = 0; i < array_length(axes); i++){
			if(!col_overlap_axis(self, triangle, axes[i])){
				return false;
			}
		}
		
		return true;
		
	};
	
	static GetMin = function(){
		return self.position.Sub(self.half_extents);
	};
	static GetMax = function(){
		return self.position.Add(self.half_extents);
	};
	static NearestPoint = function(vec3){
		var box_min = self.GetMin();
		var box_max = self.GetMax();
		var point_in_box = vec3.GetMax(box_min).GetMin(box_max);
		return(point_in_box);
	};
	static CheckAABBSAT = function(aabb){
		var axes = [
			new Vector3(1, 0, 0),
			new Vector3(0, 1, 0),
			new Vector3(0, 0, 1),
		];
		
		for(var i = 0; i < 3; i++){
			if(!col_overlap_axis(self, aabb, axes[i])){
				return false;
			}
		}
		
		return true;
	};
	
	static getInterval = function(axis){
		var pmin = self.GetMin();
		var pmax = self.GetMax();
		
		var vertices = [
			new Vector3(pmin.x, pmin.y, pmin.z),
			new Vector3(pmin.x, pmin.y, pmax.z),
			new Vector3(pmin.x, pmax.y, pmin.z),
			new Vector3(pmin.x, pmax.y, pmax.z),
			new Vector3(pmax.x, pmin.y, pmin.z),
			new Vector3(pmax.x, pmin.y, pmax.z),
			new Vector3(pmax.x, pmax.y, pmin.z),
			new Vector3(pmax.x, pmax.y, pmax.z)
		];
		
		var imin = infinity;
		var imax = -infinity;
		
		for(var i = 0; i < 8; i++){
			var dot = axis.Dot(vertices[i]);
			imin = min(imin, dot);
			imax = max(imax, dot);
		}
		
		return new ColInterval(imin, imax);
		
	};
}
function ColPlane(normal, distance) constructor {
	self.normal = normal.Normalize();	/// Vec3
	self.distance = distance;			/// Number
	
	static CheckPoint = function(point){
		return point.CheckPlane(self);
	};
	
	static CheckSphere = function(sphere){
		return sphere.CheckPlane(self);
	};
	
	static CheckAABB = function(aabb){
		return aabb.CheckPlane(self)
	};
	
	static CheckPlane = function(plane){
		var cross = self.normal.Cross(plane.normal);
		return (cross.Magnitude() > 0) || (self.distance == plane.distance);
	};
	
	static CheckRay = function(ray, hit_info){
		var DdotN = ray.direction.Dot(self.normal);
		if(DdotN >= 0) return false;
		
		var OdotN = ray.origin.Dot(self.normal);
		var t = (self.distance - OdotN) / OdotN;
		
		if (t < 0) return false;
		
		var contact_point = ray.origin.Add(ray.direction.Mul(t));
		
		hit_info.Update(t, self, contact_point, self.normal);
		
		return true;
	};
	
	static CheckLine = function(line){
		
	};
	
	static CheckTriangle = function(triangle){
		var side_a = self.PlaneEquation(triangle.a);
		var side_b = self.PlaneEquation(triangle.b);
		var side_c = self.PlaneEquation(triangle.c);
		
		//// parallel, intersecting
		if(side_a == 0 && side_b == 0 && side_c == 0) return true;
		
		/// points all on the same side, not intersecting
		if(sign(side_a) == sign(side_b) && sign(side_a) == sign(side_c)) return false;
		
		/// all other cases the plane cuts the triangle
		return true;
	};
	
	static NearestPoint = function(vec3){
		var ndot = self.normal.Dot(vec3);
		var dist = ndot - self.distance;
		var scaled_dist = self.normal.Mul(dist);
		return vec3.Sub(scaled_dist);
	};
	
	// "dot' product for a plane, 0 when on the plane, + when in front, - when in back
	static PlaneEquation = function(vec3){
		var dot = vec3.Dot(self.normal);
		return dot - self.distance;
	};
}
function ColRay(origin, direction) constructor {
	self.origin = origin;							/// Vec3
	self.direction = direction.Normalize();			/// Vec3
	
	static CheckPoint = function(point, hit_info){
		return point.CheckRay(self, hit_info);	
	};
	static CheckSphere = function(sphere, hit_info){
		return sphere.CheckRay(self, hit_info);	
	};
	static CheckAABB = function(aabb, hit_info){
		return aabb.CheckRay(self, hit_info);	
	};
	static CheckPlane = function(plane, hit_info){
		return plane.CheckRay(self, hit_info);	
	};
	static CheckLine = function(line){
		return false;	
	};
	static CheckRay = function(ray, hit_info){
		return false;	
	};
	static CheckTriangle = function(triangle, hit_info){
		return triangle.CheckRay(self, hit_info);
	};
	
	static NearestPoint = function(vec3){
		var diff = vec3.Sub(self.origin);
		var t = max(diff.Dot(self.direction), 0);
		var scaled_dir = self.direction.Mul(t);
		return self.origin.Add(scaled_dir);
	};
	static BuildFromPoints = function(x1,y1,z1,x2,y2,z2){
		self.origin.fromArray([x1,y1,z1]);
		var dir = new Vector3(x2-x1,y2-y1,z2-z1);
		self.direction = dir.Normalize();
	};
}
function ColLine(start, finish) constructor {
	self.start = start;					/// Vec3
	self.finish = finish;				/// Vec3
	
	static CheckPoint = function(point){
		return point.CheckLine(self);	
	};
	static CheckSphere = function(sphere){
		return sphere.CheckLine(self);	
	};
	static CheckAABB = function(aabb){
		return aabb.CheckLine(self);	
	};
	static CheckPlane = function(plane){
		return plane.CheckLine(self);	
	};
	static CheckLine = function(line, hit_info){
		return false;	
	};
	static CheckRay = function(ray, hit_info){
		return false;	
	};
	static CheckTriangle = function(triangle){
		return triangle.CheckLine(self);
	};
	
	static Length = function(){
		return self.start.DistanceTo(self.finish);	
	};
	
	static NearestPoint = function(vec3){
		var line_vec = self.finish.Sub(self.start);
		var point_vec = vec3.Sub(self.start);
		var t = clamp(point_vec.Dot(line_vec)/line_vec.Dot(line_vec), 0, 1);
		var scaled_vec = line_vec.Mul(t);
		return self.start.Add(scaled_vec);
	};
}

/*
	triangle time
*/
function ColTriangle(a, b, c) constructor{
	self.a = a;
	self.b = b;
	self.c = c;
	
	static CheckPoint = function(point){
		return point.CheckTriangle(self);
	};
	
	static CheckSphere = function(sphere){
		return sphere.CheckTriangle(self);
	};
	
	static CheckAABB = function(aabb){
		return aabb.CheckTriangle(self);
	};
	
	static CheckPlane = function(plane){
		return plane.CheckTriangle(self);
	};
	
	static CheckLine = function(line){
		var dir = line.finish.Sub(line.start).Normalize();
		var ray = new ColRay(line.start, dir);
		var hit_info = new RaycastHitInformation();
		if(self.CheckRay(ray, hit_info)){
			return(hit_info.distance <= line.Length());	
		}
	};
	
	static CheckRay = function(ray, hit_info){
		var plane = self.GetPlane();
		var plane_hit_info = new RaycastHitInformation();
		if(!plane.CheckRay(ray, plane_hit_info)){
			return false;
		}
		
		var result = plane_hit_info.point;
		var bary = self.Barycentric(result);
		
		if((bary.x >= 0 && bary.x <= 1) && (bary.y >= 0 && bary.y <= 1) && (bary.z >= 0 && bary.z <= 1)){
			
			hit_info.Update(plane_hit_info.distance, self, result, plane_hit_info.normal);
			return true;
		};
		
		return false;
		
	};
	
	static CheckTriangle = function(triangle){
		
	};
	
	static GetNormal = function(){
		var diffAB = self.b.Sub(self.a);
		var diffAC = self.c.Sub(self.a);
		return diffAB.Cross(diffAC).Normalize();
	};
	
	static GetPlane = function(){
		var norm = self.GetNormal();
		var dist = norm.Dot(self.a);
		return new ColPlane(norm, dist);
	};
	
	static NearestPoint = function(vec3){
		var plane = self.GetPlane();
		var nearest_to_plane = plane.NearestPoint(vec3);
		
		if(self.CheckPoint(new ColPoint(nearest_to_plane))){
			return nearest_to_plane;
		}
		
		/// create three lines and check nearest point to them
		var lineAB = new ColLine(self.a, self.b);
		var lineBC = new ColLine(self.b, self.c);
		var lineCA = new ColLine(self.c, self.a);
		
		var nearest_to_ab = lineAB.NearestPoint(vec3);
		var nearest_to_bc = lineBC.NearestPoint(vec3);
		var nearest_to_ca = lineCA.NearestPoint(vec3);
		
		/// get all distances as a scalar
		var dist_ab = vec3.DistanceTo(nearest_to_ab);
		var dist_bc = vec3.DistanceTo(nearest_to_bc);
		var dist_ca = vec3.DistanceTo(nearest_to_ca);
		
		/// ab is shortest distance
		if(dist_ab < dist_bc && dist_ab < dist_ca) {
			return nearest_to_ab;
		}
		
		/// bc is shortest distance
		if(dist_bc < dist_ca && dist_bc < dist_ab) {
			return nearest_to_bc;
		}
		
		return nearest_to_ca;
		
	};
	
	/*
		find a point relative to the three vertices of a triangle
	*/
	static Barycentric = function(vec3){
		var pa = vec3.Sub(self.a);
		var pb = vec3.Sub(self.b);
		var pc = vec3.Sub(self.c);
		
		var ab = self.b.Sub(self.a);
		var ac = self.c.Sub(self.a);
		var bc = self.c.Sub(self.b);
		var cb = self.b.Sub(self.c);
		var ca = self.a.Sub(self.c);
		
		var v = ab.Sub(ab.Project(cb));
		var a = 1 - (v.Dot(pa) / v.Dot(ab));
		
		v = bc.Sub(bc.Project(ac));
		var b = 1 - (v.Dot(pb) / v.Dot(bc));
		
		v = ca.Sub(ca.Project(ab));
		var c = 1 - (v.Dot(pc) / v.Dot(ca));
		
		return new Vector3(a, b, c);
		
	};
	
	static getInterval = function(axis){
		var adot = axis.Dot(self.a);
		var bdot = axis.Dot(self.b);
		var cdot = axis.Dot(self.c);
		
		var imin = min(adot, bdot, cdot);
		var imax = max(adot, bdot, cdot);
		
		return new ColInterval(imin, imax);
	};
}