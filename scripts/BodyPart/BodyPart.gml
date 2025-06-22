 function BodyPart(radius, color, texture) constructor{
    self.radius = radius;
	self.color = color;
	self.texture = texture;
	self.adjacent = [];
	self.direction = 0;
	self.rot_y = 0;
	self.rot_x = 0;
	
	static copy = function(){
		return new BodyPart(self.radius, self.color, self.texture);	
	}
	
	/// add body part appendage
    static add_appendage = function(body_part, dist=0, dir=180, rot_y=0, rot_x=0, sourceRadius=0){
		
		var new_bod = body_part.copy();
		// generate mesh and body part
		var _vb_model = start_vertex_buffer_model();
		var _p3d = create_P3D_segment(sourceRadius == 0 ? self.radius : sourceRadius, new_bod.radius, dist, self.color, new_bod.color);
		add_P3D_to_vertex_buffer(_vb_model, _p3d, 0, 0, 0);
		finish_vertex_buffer_model(_vb_model);
		
		// copy data into array
		var _data = {
			body: new_bod,
			distance: dist,
			direction: dir,
			rot_y,
			rot_x,
			model: _p3d,
			buffer: _vb_model
		};
		array_push(self.adjacent, _data);
		return _data;
	}
	
	/// recursive draw function...
	static draw = function(xx, yy, zz, angle, rot_y, rot_x = 0){
		// go through all adjacent and call their draws
		var len = array_length(self.adjacent);
		for(var i = 0; i < len; i++){
			var _data = self.adjacent[i];
			var _dir = _data.direction + self.direction + angle;

			var _rot_y = _data.rot_y + self.rot_y + rot_y;
			var _rot_x = _data.rot_x + self.rot_x + rot_x;
			
			// xto, yto, zto, rotate=90, angle=0, rot_y=0
			transform_set_3d(xx, yy, zz, _rot_y, _dir, _rot_x);
			vertex_submit(_data.buffer, pr_trianglelist, self.texture);
			
			/// call children draw functions (recursive)
			var _x = xx + lengthdir_x(_data.distance, _dir) * lengthdir_x(1, _rot_y) * lengthdir_x(1, _rot_x);
			var _y = yy + lengthdir_y(_data.distance, _dir) * lengthdir_x(1, _rot_y);
			var _z = zz - lengthdir_x(_data.distance, _rot_y) * lengthdir_y(1, _rot_x);

			
			_data.body.draw(_x, _y, _z, _dir, _rot_y, _rot_x);
		}
		transform_reset_3d();
		
	}
}