function vertex_add_point(buffer, pos_v3, norm_v3, uv_v2, color, alpha){
	vertex_position_3d(buffer, pos_v3[0], pos_v3[1], pos_v3[2]);
	vertex_normal(buffer, norm_v3[0], norm_v3[1], norm_v3[2]);
	vertex_texcoord(buffer, uv_v2[0], uv_v2[1]);
	vertex_color(buffer, color, alpha);
}