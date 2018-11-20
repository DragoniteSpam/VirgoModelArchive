if (grid_size==0){
    show_message("You need to have set a non-zero grid size to use this. (You may still set the bounds manually, though.)");
} else if (show_question("Auto-calculate the bounds for this model?")){
    var m=instance_find(Model, selected_model);
    
    var xmin=0;
    var ymin=0;
    var zmin=0;
    var xmax=0;
    var ymax=0;
    var zmax=0;
    
    for (var i=0; i<ds_grid_height(m.vertices); i++){
        xmin=min(xmin, m.vertices[# 0, i]);
        xmax=max(xmax, m.vertices[# 0, i]);
        ymin=min(ymin, m.vertices[# 1, i]);
        ymax=max(ymax, m.vertices[# 1, i]);
        zmin=min(zmin, m.vertices[# 2, i]);
        zmax=max(zmax, m.vertices[# 2, i]);
    }
    
    m.xmin=floor(xmin/grid_size);
    m.ymin=floor(ymin/grid_size);
    m.zmin=floor(zmin/grid_size);
    m.xmax=ceil(xmax/grid_size);
    m.ymax=ceil(ymax/grid_size);
    m.zmax=ceil(zmax/grid_size);
}
