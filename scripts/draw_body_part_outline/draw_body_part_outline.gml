function draw_body_part_outline(body_part, xto=64, yto=64, zto=32){
	gpu_set_cullmode(cull_counterclockwise);
	//vertex_submit(vb_model_seg, pr_trianglelist, sprite_get_texture(spr_tex_test, 0));
	set_shd_3d_outline();
	body_part.draw(xto,yto,zto,0,0);
	shader_reset();
	gpu_set_cullmode(cull_clockwise);
	body_part.draw(xto,yto,zto,0,0);
	gpu_set_cullmode(cull_noculling);
}