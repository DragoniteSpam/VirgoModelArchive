var m=instance_find(Model, selected_model);

d3d_model_clear(m.model);
d3d_model_primitive_begin(m.model, pr_trianglelist);

for (var i=0; i<ds_grid_height(m.vertices); i+=3){
    for (var j=0; j<3; j++){
        m.vertices[# 3, i+j]=normalX(m.vertices[# 0, i], m.vertices[# 1, i], m.vertices[# 2, i],
                m.vertices[# 0, i+1], m.vertices[# 1, i+1], m.vertices[# 2, i+1],
                m.vertices[# 0, i+2], m.vertices[# 1, i+2], m.vertices[# 2, i+2]);
        m.vertices[# 4, i+j]=normalY(m.vertices[# 0, i], m.vertices[# 1, i], m.vertices[# 2, i],
                m.vertices[# 0, i+1], m.vertices[# 1, i+1], m.vertices[# 2, i+1],
                m.vertices[# 0, i+2], m.vertices[# 1, i+2], m.vertices[# 2, i+2]);
        m.vertices[# 5, i+j]=normalZ(m.vertices[# 0, i], m.vertices[# 1, i], m.vertices[# 2, i],
                m.vertices[# 0, i+1], m.vertices[# 1, i+1], m.vertices[# 2, i+1],
                m.vertices[# 0, i+2], m.vertices[# 1, i+2], m.vertices[# 2, i+2]);
    }
    for (var j=0; j<3; j++){
        d3d_model_vertex_normal_texture_colour(m.model,
            m.vertices[# 0, i+j], m.vertices[# 1, i+j], m.vertices[# 2, i+j],
            m.vertices[# 3, i+j], m.vertices[# 4, i+j], m.vertices[# 5, i+j],
            m.vertices[# 6, i+j], m.vertices[# 7, i+j],
            m.vertices[# 8, i+j], m.vertices[# 9, i+j]);
    }
}

d3d_model_primitive_end(m.model);
