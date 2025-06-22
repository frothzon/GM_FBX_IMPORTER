function Transform(_objID, _property, _value) constructor{
	id = _objID;
	property = _property;
	value = _value;
}

function KeyFrame(_frame) constructor{
	frame = _frame;
	transforms = [];
	_temp = -1;
	static add_transform = function(transform){
		_temp = transform;
		var _f = function(_element, _index)
		{
		    return (_element.id == _temp.id && _element.property == _temp.property);
		}
		var _ind = array_find_index(self.transforms, _f);
		if(_ind == -1){
			array_push(self.transforms, _temp);
			return array_length(self.transforms)-1;
		}
		self.transforms[_ind].value = transform.value;
		return _ind;
	}
}

function find_nearest_keyframe(keyframe_array, _frame){
	if(array_length(keyframe_array) == 0){
		return 0;
	}
	var output = 0;
	for(var i = 0; i < array_length(keyframe_array); i++){
		if(keyframe_array[i].frame < _frame){
			output = i;	
		} else {
			break;
		}
	}
	return keyframe_array[output];
}