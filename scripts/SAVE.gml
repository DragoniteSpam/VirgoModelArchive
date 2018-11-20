var buffer=buffer_create(1, buffer_grow, 4);

var data=ds_map_create();

ds_map_add(data, "version", 1);
ds_map_add(data, "grid_size", grid_size);

buffer_write_string(buffer, ds_map_write(data));
ds_map_destroy(data);

buffer_write(buffer, T, instance_number(Model));
for (var model=0; model<instance_number(Model); model++){
    var current=instance_find(Model, model);
    buffer_write_string(buffer, current.name);
    var n=current.n_vertices;
    buffer_write(buffer, T, n);
    for (var i=0; i<n; i++){
        buffer_write(buffer, T, current.vertices[# 0, i]);   // x
        buffer_write(buffer, T, current.vertices[# 1, i]);   // y
        buffer_write(buffer, T, current.vertices[# 2, i]);   // z
        buffer_write(buffer, T, current.vertices[# 3, i]);   // nx
        buffer_write(buffer, T, current.vertices[# 4, i]);   // ny
        buffer_write(buffer, T, current.vertices[# 5, i]);   // nz
        buffer_write(buffer, T, round2048(current.vertices[# 6, i]));   // xtex
        buffer_write(buffer, T, round2048(current.vertices[# 7, i]));   // ytex
        buffer_write(buffer, T, current.vertices[# 8, i]);   // color
        buffer_write(buffer, T, current.vertices[# 9, i]);   // alpha
    }
    if (grid_size>0){
        // this is a waste but using buffer_s8 doesn't seem to work well
        // with 4-byte aligned buffers
        buffer_write(buffer, T, current.xmin);
        buffer_write(buffer, T, current.ymin);
        buffer_write(buffer, T, current.zmin);
        buffer_write(buffer, T, current.xmax);
        buffer_write(buffer, T, current.ymax);
        buffer_write(buffer, T, current.zmax);
    }
}

var fn=get_save_filename("Virgo Resource Archives (Extended) (*.vrax)|*.vrax", "assets.vrax")
if (fn!=""){
    buffer_save_ext(buffer, fn, 0, buffer_tell(buffer));
    window_set_caption("Virgo Model Archive: "+filename_name(fn));
}

buffer_delete(buffer);

