// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function _fbx_parse_data_array(file_handle) {
	/// @param file_handle

	var data_string = "";
	var line = "";
    
	// Read lines until we find the closing brace of the data array
	while (!file_text_eof(file_handle)) {
		line = file_text_readln(file_handle);
		line = string_trim(line);
        
		if (string_pos("}", line) > 0) {
			data_string += string_copy(line, 1, string_pos("}", line) - 1);
			break;
		} else {
			data_string += line;
		}
	}
    
	// Remove the "a:" prefix and split the string into an array of numbers
	if (string_pos("a:", data_string) == 1) {
		data_string = string_delete(data_string, 1, 2);
	}
    
	return string_split(data_string, ",");
}

function _fbx_parse_properties(file_handle) {
	/// @param file_handle
	var properties = {};
	var line = "";
	
	while(!file_text_eof(file_handle)) {
		line = file_text_readln(file_handle);
		line = string_trim(line);
		
		if (string_pos("}", line) > 0) break; // End of properties block
		
		if (string_pos("P:", line) == 1) {
			var parts = string_split(string_replace_all(line, "\"", ""), ",");
			if (array_length(parts) > 1) {
				var key = string_trim(parts[0]);
				key = string_delete(key, 1, 2); // remove "P:"
				
				// Store all property values
				var values = [];
				for(var i = 1; i < array_length(parts); i++) {
					array_push(values, string_trim(parts[i]));
				}
				properties[$ key] = values;
			}
		}
	}
	
	return properties;
}