function lerp_array(_array, _ratio) {

    // Total number of indices
    var totalIndices = array_length(_array) - 1;
	if(totalIndices < 1){
		return _array[0];	
	}

    // Calculate the exact position in the _array
    var exactPosition = _ratio * totalIndices;

    // Calculate indices and fraction
    var floorIndex = floor(exactPosition);
    var nextIndex = min(floorIndex + 1, totalIndices);
    var fraction = exactPosition - floorIndex;

    // Handle edge cases
    if (floorIndex >= totalIndices) {
        return _array[totalIndices];
    }
    if (floorIndex < 0) {
        return _array[0];
    }

    // Interpolate between the two values
    return lerp(_array[floorIndex], _array[nextIndex], fraction);
}
