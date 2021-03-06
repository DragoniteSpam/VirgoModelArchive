if (show_question("Set all surface normals to (0, 0, 1)? (This is a test script.)")){
    var m=instance_find(Model, selected_model);
    
    d3d_model_clear(m.model);
    d3d_model_primitive_begin(m.model, pr_trianglelist);
    
    for (var i=0; i<ds_grid_height(m.vertices); i++){
        m.vertices[# 3, i]=0;
        m.vertices[# 4, i]=0;
        m.vertices[# 5, i]=1;
        d3d_model_vertex_normal_texture_colour(m.model,
            m.vertices[# 0, i], m.vertices[# 1, i], m.vertices[# 2, i],
            m.vertices[# 3, i], m.vertices[# 4, i], m.vertices[# 5, i],
            m.vertices[# 6, i], m.vertices[# 7, i],
            m.vertices[# 8, i], m.vertices[# 9, i]);
    }
    
    d3d_model_primitive_end(m.model);
}
