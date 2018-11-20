var fn=get_open_filename("Virgo Resource Archives (*.vra;*.vrax)|*.vra;*.vrax", "assets.vra")
if (file_exists(fn)){
    NEW();
    window_set_caption("Virgo Model Archive: "+filename_name(fn));
    switch (filename_ext(fn)){
        case ".vra":
            var buffer=buffer_load(fn);
            var n=buffer_read(buffer, T);
            repeat(n){
                var current=instance_create(0, 0, Model);
                current.name=buffer_read_string(buffer);
                current.n_vertices=buffer_read(buffer, T);
                current.vertices=ds_grid_create(10, current.n_vertices);
                d3d_model_primitive_begin(current.model, pr_trianglelist);
                for (var i=0; i<current.n_vertices; i++){
                    current.vertices[# 0, i]=buffer_read(buffer, T);
                    current.vertices[# 1, i]=buffer_read(buffer, T);
                    current.vertices[# 2, i]=buffer_read(buffer, T);
                    current.vertices[# 3, i]=buffer_read(buffer, T);
                    current.vertices[# 4, i]=buffer_read(buffer, T);
                    current.vertices[# 5, i]=buffer_read(buffer, T);
                    current.vertices[# 6, i]=buffer_read(buffer, T);
                    current.vertices[# 7, i]=buffer_read(buffer, T);
                    current.vertices[# 8, i]=buffer_read(buffer, T);
                    current.vertices[# 9, i]=buffer_read(buffer, T);
                    d3d_model_vertex_normal_texture_colour(current.model,
                        current.vertices[# 0, i], current.vertices[# 1, i], current.vertices[# 2, i],
                        current.vertices[# 3, i], current.vertices[# 4, i], current.vertices[# 5, i],
                        current.vertices[# 6, i], current.vertices[# 7, i],
                        current.vertices[# 8, i], current.vertices[# 9, i]);
                }
                d3d_model_primitive_end(current.model);
            }
            buffer_delete(buffer);
            break;
        case ".vrax":
            var buffer=buffer_load(fn);
            
            var data=ds_map_create();
            ds_map_read(data, buffer_read_string(buffer));
            var version=data[? "version"];
            grid_size=data[? "grid_size"];
            
            ds_map_destroy(data);
            
            var n=buffer_read(buffer, T);
            repeat(n){
                var current=instance_create(0, 0, Model);
                current.name=buffer_read_string(buffer);
                current.n_vertices=buffer_read(buffer, T);
                current.vertices=ds_grid_create(10, current.n_vertices);
                d3d_model_primitive_begin(current.model, pr_trianglelist);
                for (var i=0; i<current.n_vertices; i++){
                    current.vertices[# 0, i]=buffer_read(buffer, T);
                    current.vertices[# 1, i]=buffer_read(buffer, T);
                    current.vertices[# 2, i]=buffer_read(buffer, T);
                    current.vertices[# 3, i]=buffer_read(buffer, T);
                    current.vertices[# 4, i]=buffer_read(buffer, T);
                    current.vertices[# 5, i]=buffer_read(buffer, T);
                    current.vertices[# 6, i]=buffer_read(buffer, T);
                    current.vertices[# 7, i]=buffer_read(buffer, T);
                    current.vertices[# 8, i]=buffer_read(buffer, T);
                    current.vertices[# 9, i]=buffer_read(buffer, T);
                    d3d_model_vertex_normal_texture_colour(current.model,
                        current.vertices[# 0, i], current.vertices[# 1, i], current.vertices[# 2, i],
                        current.vertices[# 3, i], current.vertices[# 4, i], current.vertices[# 5, i],
                        current.vertices[# 6, i], current.vertices[# 7, i],
                        current.vertices[# 8, i], current.vertices[# 9, i]);
                }
                d3d_model_primitive_end(current.model);
                
                if (grid_size>0){
                    current.xmin=buffer_read(buffer, T);
                    current.ymin=buffer_read(buffer, T);
                    current.zmin=buffer_read(buffer, T);
                    current.xmax=buffer_read(buffer, T);
                    current.ymax=buffer_read(buffer, T);
                    current.zmax=buffer_read(buffer, T);
                }
            }
            buffer_delete(buffer);
            break;
    }
}

selected_model=clamp(selected_model, 0, instance_number(Model)-1);
