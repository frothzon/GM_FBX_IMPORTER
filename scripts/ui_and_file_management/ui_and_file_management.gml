/// @description Initializes and manages UI elements and file operations.

/// @function fbx_model_calculate_bounding_box(fbx_model_struct)
/// @description Calculates the combined axis-aligned bounding box for an FBXModel.
/// @param {struct} fbx_model_struct An FBXModel struct.
function fbx_model_calculate_bounding_box(fbx_model_struct) {
    var min_x = 99999, min_y = 99999, min_z = 99999;
    var max_x = -99999, max_y = -99999, max_z = -99999;

    if (!is_struct(fbx_model_struct) || !is_array(fbx_model_struct.meshes) || array_length(fbx_model_struct.meshes) == 0) {
        return { x1: -1, y1: -1, z1: -1, x2: 1, y2: 1, z2: 1 };
    }

    // Iterate through each mesh
    for (var i = 0; i < array_length(fbx_model_struct.meshes); i++) {
        var mesh = fbx_model_struct.meshes[i];
        if (!is_struct(mesh) || !is_array(mesh.raw_vertex_data)) continue;
        
        var verts = mesh.raw_vertex_data;
        // Iterate through each vertex in the mesh
        for (var j = 0; j < array_length(verts); j++) {
            var vert_pos = verts[j];
            min_x = min(min_x, vert_pos[0]);
            max_x = max(max_x, vert_pos[0]);
            min_y = min(min_y, vert_pos[1]);
            max_y = max(max_y, vert_pos[1]);
            min_z = min(min_z, vert_pos[2]);
            max_z = max(max_z, vert_pos[2]);
        }
    }

    // Handle case where no vertices were found
    if (min_x == 99999) {
        return { x1: -1, y1: -1, z1: -1, x2: 1, y2: 1, z2: 1 };
    }
    
    show_debug_message("Model bounding box calculated.");
    return { x1: min_x, y1: min_y, z1: min_z, x2: max_x, y2: max_y, z2: max_z };
}

function ui_init() {
    global.ui_button_import = { x: 10, y: 110, w: 120, h: 30, text: "Import FBX" };
}

function draw_ui() {
    if (!show_ui) return;
    var btn = global.ui_button_import;
    var mx = window_mouse_get_x();
    var my = window_mouse_get_y();
    var is_hover = (mx >= btn.x && mx <= btn.x + btn.w && my >= btn.y && my <= btn.y + btn.h);
    var col = is_hover ? c_ltgray : c_dkgray;
    draw_set_color(col);
    draw_rectangle(btn.x, btn.y, btn.x + btn.w, btn.y + btn.h, false);
    draw_set_color(c_white);
    draw_rectangle(btn.x, btn.y, btn.x + btn.w, btn.y + btn.h, true);

    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_color(c_black);
    draw_text(btn.x + btn.w / 2, btn.y + btn.h / 2, btn.text);

    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_color(c_white);
    draw_text(10, 10, "FBX Importer");
    draw_text(10, 30, "Middle Mouse: Orbit");
    draw_text(10, 50, "Right Mouse: Pan");
    draw_text(10, 70, "Mouse Wheel: Zoom");
}

function check_ui_clicks() {
    if (!show_ui) return;

    if (mouse_check_button_pressed(mb_left)) {
        var btn = global.ui_button_import;
        var mx = window_mouse_get_x();
        var my = window_mouse_get_y();

        if (mx >= btn.x && mx <= btn.x + btn.w && my >= btn.y && my <= btn.y + btn.h) {
            ui_import_fbx();
        }
    }
}

function ui_import_fbx() {
    var filepath = get_open_filename_ext("FBX ASCII File|*.fbx|All Files|*.*", "", "Import FBX Model", "Import");

    if (file_exists(filepath)) {
        show_debug_message("Importing FBX file: " + filepath);

        // Destroy old model data to prevent memory leaks
        if (is_struct(fbx_model)) {
            fbx_model.destroy();
        }
        fbx_model = undefined;

        // Load the new model using the full FBX parser
        fbx_model = fbx_parse_file(filepath);

        if (is_struct(fbx_model) && array_length(fbx_model.meshes) > 0) {
            // Calculate the new bounding box and frame the camera
            model_bbox = fbx_model_calculate_bounding_box(fbx_model);
            camera_frame_bounding_box(model_bbox);
        }
        
    } else {
        show_debug_message("File not selected or does not exist.");
    }
    
    var model_valid = is_struct(fbx_model);
    show_debug_message($"Model ready for rendering: {model_valid}");
}