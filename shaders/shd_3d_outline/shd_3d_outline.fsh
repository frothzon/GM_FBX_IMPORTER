// Fragment Shader
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec4 u_outlineColor;

void main()
{
    gl_FragColor = u_outlineColor;
}