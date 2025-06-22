function set_shd_3d_outline(outlineColor = c_black, outlineScale = 1) {
    shader_set(shd_3d_outline);

    // Normalize the camera direction vector
    var u_outlineColor = shader_get_uniform(shd_3d_outline, "u_outlineColor");
	 var u_outlineScale = shader_get_uniform(shd_3d_outline, "u_outlineScale");
	
    shader_set_uniform_f(u_outlineColor, color_get_red(outlineColor)/255, 
		color_get_green(outlineColor)/255, color_get_blue(outlineColor)/255, 1);
	shader_set_uniform_f(u_outlineScale, outlineScale);
}