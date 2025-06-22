/// @description Initializes and manages UI elements and file operations.

function ui_init() {
    /// @description Defines UI element properties.
    global.ui_button_import = { x: 10, y: 110, w: 120, h: 30, text: "Import FBX" };
}

function draw_ui() {
    /// @description Draws all UI elements.
    if (!show_ui) return;

    var btn = global.ui_button_import;
    var mx = window_mouse_get_x();
    var my = window_mouse_get_y();

    // Draw Import Button
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
    
    // Draw help text
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_color(c_white);
    draw_text(10, 10, "FBX Importer");
    draw_text(10, 30, "Middle Mouse: Orbit");
    draw_text(10, 50, "Right Mouse: Pan");
    draw_text(10, 70, "Mouse Wheel: Zoom");
}

function check_ui_clicks() {
    /// @description Checks for clicks on UI elements.
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
    /// @description Opens file dialog and initiates parsing.
    var filepath = get_open_filename_ext("FBX ASCII File|*.fbx|All Files|*.*", "", "Import FBX Model", "Import");
    
    if (file_exists(filepath)) {
        show_debug_message("Importing FBX file: " + filepath);
        
        // Clean up old model first to prevent memory leaks
        if (is_struct(fbx_model)) {
            fbx_model.destroy();
        }
        
        // Call the main parser function
        fbx_model = fbx_parse_file(filepath);
        
    } else {
        show_debug_message("File not selected or does not exist.");
    }
}