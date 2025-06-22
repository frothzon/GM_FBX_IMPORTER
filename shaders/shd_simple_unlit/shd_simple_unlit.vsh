//
// Simple Unlit Vertex Shader
//
attribute vec3 in_Position;    // The vertex position from your vertex buffer

// This is a built-in GameMaker uniform that provides the combined World, View, and Projection matrix.


void main()
{
    // Transform the incoming vertex position by the WVP matrix to get the final screen position.
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * vec4(in_Position, 1.0);
}