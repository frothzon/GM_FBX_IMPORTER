/// @description Initializes and stores vertex formats for the FBX importer.

function fbx_vertex_formats_init() {

    // -- Main Skinned Vertex Format --
    // This format contains all the data needed to render a skinned and textured model.
    vertex_format_begin();
    
    // Position data (x, y, z)
    vertex_format_add_position_3d();
    
    // Normal data (nx, ny, nz) for lighting
    vertex_format_add_normal();
    
    // Texture coordinate data (u, v)
    vertex_format_add_texcoord();
    
    // We'll use two vec4 attributes for skinning data.
    // A single vertex can be influenced by up to 4 bones.
    
    // Bone Weights (w1, w2, w3, w4)
    // Stored as a 4-component float.
    vertex_format_add_custom(vertex_type_float4, vertex_usage_color);
    
    // Bone Indices (i1, i2, i3, i4)
    // Also stored as a 4-component float for simplicity in GML.
    // We will treat them as integers in the shader.
    vertex_format_add_custom(vertex_type_float4, vertex_usage_color);

    global.fbx_skinned_format = vertex_format_end();
    
    show_debug_message("FBX Skinned Vertex Format Initialized.");
}