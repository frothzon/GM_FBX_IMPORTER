/// @description Initializes and stores vertex formats for the FBX importer.
function fbx_vertex_formats_init() {
    // This format matches the 3D Popup Engine (Position, Normal, UV, Color).
    vertex_format_begin();
    vertex_format_add_position_3d();
    vertex_format_add_normal();
    vertex_format_add_texcoord();
    vertex_format_add_color();
    global.fbx_vertex_format = vertex_format_end();
    
    show_debug_message("FBX Vertex Format Initialized (Popup Engine Compatible).");
}