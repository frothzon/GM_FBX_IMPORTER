function create_P3D_segment(r1, r2, distance, c1=c_white, c2=c_white, quality=4){
	var _model = new P3D_Class();
	var _segment = new Segment(new Sphere(0,0,0,r1,c1), new Sphere(distance,0,0,r2,c2));
	var _slices = clamp(quality, 1, 10) * 3 + 2;
	//var _radials = clamp(quality, 1, 10) * 4;
	var _triangles = _segment.generate_triangles(_slices, _slices);

	for(var i = 0; i < array_length(_triangles); i++){
		var triangle = _triangles[i];
		triangle[0].to_point(_model);
		triangle[1].to_point(_model);
		triangle[2].to_point(_model);
	}
	delete _segment;
	return _model;
}

function sigmoid(_x) {
	return 1 / (1 + exp(-_x));
}

function point_distance_vec3(point1, point2) {
	var dx = point2.x - point1.x;
	var dy = point2.y - point1.y;
	var dz = point2.z - point1.z;

	return sqrt(dx * dx + dy * dy + dz * dz);
}

function lerp_vector(point1, point2, t) {
	return new Vec3(
		lerp(point1.x, point2.x, t),
		lerp(point1.y, point2.y, t),
		lerp(point1.z, point2.z, t)
	);
}

function Sphere(_x,_y,_z, _r, _c = c_white) constructor {
	self.x = _x;
	self.y = _y;
	self.z = _z;
	self.r = _r;
	self.color = _c;
	static copy = function(xoff, yoff, zoff){
		return new Sphere(self.x + xoff, self.y + yoff, self.z + zoff, self.r, self.color);	
	}
}

function Vec3(_x,_y,_z) constructor {
	self.x =_x;
	self.y =_y;
	self.z =_z;

	// Method to calculate the magnitude (length) of the vector
	static magnitude = function() {
		return sqrt(self.x * self.x + self.y * self.y + self.z * self.z);
	}

	// Method to normalize the vector (convert it to a unit vector)
	static normalize = function() {
		var mag = self.magnitude();
		if (mag == 0) {
			return new Vec3(0, 0, 0); // Return a_zero vector if the magnitude is 0
		}
		return new Vec3(self.x / mag, self.y / mag, self.z / mag);
	}

	// Method to calculate the cross product with an_other vector
	static crossProduct = function(_other) {
		var _x = self.y * _other.z - self.z * _other.y;
		var _y = self.z * _other.x - self.x * _other.z;
		var _z = self.x * _other.y - self.y * _other.x;
		return new Vec3(_x, _y, _z);
	}

	// Method to calculate the dot product with an_other vector
	static dotProduct = function(_other) {
		return self.x * _other.x + self.y * _other.y + self.z * _other.z;
	}

	// Method to subtract an_other vector from self one
	static subtract = function(_other) {
		return new Vec3(self.x - _other.x, self.y - _other.y, self.z - _other.z);
	}

	// Method to rotate the vector around an axis by a given angle
	static rotateAroundAxis = function(axis, angle) {
		var _sin = sin(angle);
		var _cos = cos(angle);

		var _x = self.x * (_cos + axis.x * axis.x * (1 - _cos)) + self.y * (axis.x * axis.y * (1 - _cos) - axis.z * _sin) + self.z * (axis.x * axis.z * (1 - _cos) + axis.y * _sin);
		var _y = self.x * (axis.x * axis.y * (1 - _cos) + axis.z * _sin) + self.y * (_cos + axis.y * axis.y * (1 - _cos)) + self.z * (axis.y * axis.z * (1 - _cos) - axis.x * _sin);
		var _z = self.x * (axis.x * axis.z * (1 - _cos) - axis.y * _sin) + self.y * (axis.y * axis.z * (1 - _cos) + axis.x * _sin) + self.z * (_cos + axis.z * axis.z * (1 - _cos));

		return new Vec3(_x,_y,_z);
	}

	// Method to multiply the vector by a scalar
	static multiply = function(scalar) {
		return new Vec3(self.x * scalar, self.y * scalar, self.z * scalar);
	}

	// Method to add an_other vector to self one
	static add = function(_other) {
		return new Vec3(self.x + _other.x, self.y + _other.y, self.z + _other.z);
	}
}


function Vertex(_x,_y,_z, nx, ny, nz, u, v, col=c_white) constructor {
	self.position = new Vec3(_x,_y,_z);
	self.normal = new Vec3(nx, ny, nz);
	self.uvs = new Vec3(u, v, 0);
	self.color = col;
	static to_point = function(_model){
		_model.addPoint(
			[self.position.x,self.position.y,self.position.z],
			[self.normal.x,self.normal.y,self.normal.z],
			[self.uvs.x,self.uvs.y],
			self.color,1
		);	
	}
}


function Segment (sphere1, sphere2) constructor{
	self.sphere1 = sphere1;
	self.sphere2 = sphere2;
	// angle between sphere1 and sphere 2
	self.p1 = new Vec3(sphere1.x, sphere1.y, sphere1.z);
	self.p2 = new Vec3(sphere2.x, sphere2.y, sphere2.z);
	self.segment_normal = (new Vec3(self.p2.x - self.p1.x, self.p2.y - self.p1.y, self.p2.z - self.p1.z)).normalize();
	self.distance = point_distance_vec3(self.p1, self.p2);
	// find points furthest from each _other on segment
	self.point_start = (self.segment_normal.multiply(-self.sphere1.r)).add(self.p1);
	self.point_end = (self.segment_normal.multiply(self.sphere2.r)).add(self.p2);
	self.segment_distance = point_distance_vec3(self.point_start, self.point_end);
	// ratio of radius of sphere1
	self.ratio_r1 = self.sphere1.r / self.segment_distance;
	self.ratio_r2 = (self.segment_distance-self.sphere2.r) / self.segment_distance;

	static get_vertex = function(ratio, angle, u, v) {
	    // Calculate the central point along the capsule's axis
	    var p_center = lerp_vector(self.point_start, self.point_end, ratio);
    
	    // Initialize variables
	    var normal = new Vec3(0, 0, 0);
	    var scale = 1;
    
	    // Calculate the radial angle
	    var radial = new Vec3(
	        cos(angle),
	        sin(angle),
	        0
	    );
    
	    // Rotate the radial vector to align with the capsule's orientation
	    radial = self.rotateVectorToAlign(radial, self.segment_normal);
    
	    // Calculate the ratio along the capsule's length
	    var ratio2 = point_distance_vec3(self.p1, p_center) / self.distance;
	    ratio2 = max(0, min(1, ratio2)); // Clamp ratio2 between 0 and 1
    
	    // Interpolate the scale between the two sphere radii
	    scale = lerp(self.sphere1.r, self.sphere2.r, ratio2);
    
	    // Handle spherical ends and transition areas
	    if (ratio <= self.ratio_r1) {
	        var t = ratio / self.ratio_r1;
	        scale *= sqrt(1 - (1 - t) * (1 - t)); // Use circular function for smooth transition
	    } else if (ratio >= self.ratio_r2) {
	        var t = (ratio - self.ratio_r2) / (1 - self.ratio_r2);
	        scale *= sqrt(1 - t * t); // Use circular function for smooth transition
	    }
    
	    // Calculate the final position
	    var scaling = radial.multiply(scale);
	    var position = p_center.add(scaling);
    
	    // Calculate the normal
	    if (ratio <= self.ratio_r1) {
	        var t = ratio / self.ratio_r1;
	        var end_normal = self.segment_normal.multiply(-1);
	        var side_normal = radial;
	        normal = lerp_vector(end_normal, side_normal, t).normalize();
	    } else if (ratio >= self.ratio_r2) {
	        var t = (ratio - self.ratio_r2) / (1 - self.ratio_r2);
	        var end_normal = self.segment_normal;
	        var side_normal = radial;
	        normal = lerp_vector(side_normal, end_normal, t).normalize();
	    } else {
	        normal = radial;
	    }
		
		var color = merge_color(self.sphere1.color, self.sphere2.color, clamp(ratio2, 0, 1))
		color = merge_color(color, c_black, abs(dot_product_3d(normal.x, normal.y, normal.z, 0, 1, 0)*0.3));
    
	    return new Vertex(position.x, position.y, position.z, normal.x, normal.y, normal.z, u, v, color);
	}

	// Helper method to rotate a vector to align with a given angle
	static rotateVectorToAlign = function(vector, angle) {
		// Calculate the axis of rotation
		var axis = new Vec3(0, 0, 1).crossProduct(angle).normalize();
		
		// Calculate the angle of rotation
		var calc_angle = arccos(new Vec3(0, 0, 1).dotProduct(angle));
		
		// Perform the rotation (using quaternion rotation would be more efficient for production code)
		return vector.rotateAroundAxis(axis, calc_angle);
	}

	static generate_triangles = function(length_slices, angle_slices) {
		var vertices = [];
		var slice_count = length_slices + 2; // Reduced by 1 to handle the ends
		var pi2 = pi * 2;

		for (var i = 0; i < angle_slices; i++) {
			var theta0 = i / angle_slices * pi2
			var theta1 = (((i+1) / angle_slices) % angle_slices) * pi2;
			var ratio0 = sigmoid(1 / slice_count * 12 - 6);

			// Handle the start cap
			var vert1 = self.get_vertex(0, theta0, 0, 0);
			var vert2 = self.get_vertex(ratio0, theta0, 0, 1);
			var vert3 = self.get_vertex(ratio0, theta1, 1, 1);
			var vert4 = self.get_vertex(0, theta0, 1, 0);

			array_push(vertices, [vert1, vert2, vert3]);

			for (var j = 1; j < slice_count-1; j++) {
				ratio0 = sigmoid(j / slice_count * 12 - 6)
				var ratio1 = sigmoid((j+1) / slice_count * 12 - 6);
				
				

				// Compute the positions for the four vertices of the quad
				vert1 = self.get_vertex(ratio0, theta0, 0, 0);
				vert2 = self.get_vertex(ratio1, theta0, 1, 0);
				vert3 = self.get_vertex(ratio1, theta1, 1, 1);
				vert4 = self.get_vertex(ratio0, theta1, 0, 1);
				

				// Add the vertices to the triangle array
				var triangle1 = [vert1, vert2, vert3];
				var triangle2 = [vert1, vert3, vert4];


				array_push(vertices, triangle1);
				array_push(vertices, triangle2);
				
			}
			
			var ratio0 = sigmoid((slice_count-1) / slice_count * 12 - 6);

			// Handle the end cap
			var vert5 = self.get_vertex(ratio0, theta0, 0, 0);
			var vert6 = self.get_vertex(ratio0, theta1, 0, 1);
			var vert7 = self.get_vertex(1, theta1, 1, 1);
			//var vert8 = self.get_vertex(1, theta0, 1, 0);

			array_push(vertices, [vert5, vert7, vert6]);

		}

		return vertices;
	}

}
