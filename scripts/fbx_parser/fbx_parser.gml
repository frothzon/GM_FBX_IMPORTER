/// @description Functions to parse an ASCII FBX file into a generic node tree.

/// @function fbx_parse_file_to_nodetree(filepath)
/// @description Parses an ASCII FBX file and returns the root node of the data tree.
/// @param {string} filepath The path to the .fbx file.
function fbx_parse_file_to_nodetree(filepath) {
    var file_content = [];
    var file = file_text_open_read(filepath);
    if (file < 0) {
        show_debug_message("Error: Could not open FBX file at " + filepath);
        return -1;
    }
    while (!file_text_eof(file)) {
        array_push(file_content, file_text_readln(file));
    }
    file_text_close(file);

    var root_node = _fbx_build_node_tree(file_content);
    if (!is_struct(root_node)) {
        show_debug_message("Error: Failed to parse FBX file into a node tree.");
        return -1;
    }
    
    show_debug_message("FBX file successfully parsed into a node tree.");
    return root_node;
}

/// @function _fbx_build_node_tree(file_content_array)
/// @description Internal: Parses an array of FBX lines into a generic tree of structs.
function _fbx_build_node_tree(content) {
    var root = { _children: {} };
    var stack = ds_stack_create();
    ds_stack_push(stack, root);
    
    var current_node = root;
    for (var i = 0; i < array_length(content); i++) {
        var line = content[i];
        var trimmed_line = string_trim(line);
        if (trimmed_line == "" || string_char_at(trimmed_line, 1) == ";") continue;
        
        if (string_ends_with(trimmed_line, "{")) {
            var line_no_brace = string_trim(string_copy(trimmed_line, 1, string_length(trimmed_line) - 1));
            var colon_pos = string_pos(":", line_no_brace);
            
            var key = string_trim(string_copy(line_no_brace, 1, colon_pos - 1));
            var props = string_trim(string_copy(line_no_brace, colon_pos + 1, string_length(line_no_brace)));
            
            var new_node = { _properties: props, _children: {} };
            
            if (variable_struct_exists(current_node._children, key)) {
                if (!is_array(current_node._children[$ key])) {
                    current_node._children[$ key] = [current_node._children[$ key]];
                }
                array_push(current_node._children[$ key], new_node);
            } else {
                current_node._children[$ key] = new_node;
            }
            
            ds_stack_push(stack, current_node);
            current_node = new_node;
        } else if (trimmed_line == "}") {
            if (!ds_stack_empty(stack)) {
                current_node = ds_stack_pop(stack);
            }
        } else {
            var colon_pos = string_pos(":", trimmed_line);
            if (colon_pos > 0) {
                var key = string_trim(string_copy(trimmed_line, 1, colon_pos - 1));
                var value_str = string_trim(string_copy(trimmed_line, colon_pos + 1, string_length(trimmed_line)));
                current_node[$ key] = value_str;
            }
        }
    }
    
    ds_stack_destroy(stack);
    return root;
}