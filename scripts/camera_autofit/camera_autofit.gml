/// @description Contains functions for automatically adjusting the camera.

/// @function camera_frame_bounding_box(bbox_struct)
/// @description Adjusts the camera target and distance to frame a bounding box.
/// @param {struct} bbox The bounding box struct { x1, y1, z1, x2, y2, z2 }.
function camera_frame_bounding_box(bbox) {
    if (!is_struct(bbox)) return;

    // Center the camera target on the middle of the bounding box
    cam_target.x = (bbox.x1 + bbox.x2) / 2;
    cam_target.y = (bbox.y1 + bbox.y2) / 2;
    cam_target.z = (bbox.z1 + bbox.z2) / 2;
    
    // Calculate the size of the bounding box
    var size_x = bbox.x2 - bbox.x1;
    var size_y = bbox.y2 - bbox.y1;
    var size_z = bbox.z2 - bbox.z1;
    var model_size = sqrt(sqr(size_x) + sqr(size_y) + sqr(size_z));
    
    // Adjust camera distance based on model size and field of view
    var fov = 60; // Must match the FOV used in the projection matrix
    cam_dist = (model_size / 2) / dtan(fov / 2);
    cam_dist *= 1.5; // Pull back a little extra
    cam_dist = max(cam_dist, 50); // Ensure a minimum distance
    
    show_debug_message("Camera auto-framed to model.");
}