var t_start=get_timer();

var m=instance_find(Model, selected_model);
var tangle=dcos(argument0);
var normal_map=ds_map_create();

var posX=array_create_3(0, 0, 0);
var posY=array_create_3(0, 0, 0);
var posZ=array_create_3(0, 0, 0);

for (var i=0; i<ds_grid_height(m.vertices); i+=3){
    for (var j=0; j<3; j++){
        posX[j]=m.vertices[# 0, i+j];
        posY[j]=m.vertices[# 1, i+j];
        posZ[j]=m.vertices[# 2, i+j];
    }
    
    var nx=normalX(posX[0], posY[0], posZ[0], posX[1], posY[1], posZ[1], posX[2], posY[2], posZ[2]);
    var ny=normalY(posX[0], posY[0], posZ[0], posX[1], posY[1], posZ[1], posX[2], posY[2], posZ[2]);
    var nz=normalZ(posX[0], posY[0], posZ[0], posX[1], posY[1], posZ[1], posX[2], posY[2], posZ[2]);
    
    for (var j=0; j<3; j++){
        var key=string(posX[j])+","+string(posY[j])+","+string(posZ[j])
        if (is_undefined(normal_map[? key])){
            normal_map[? key]=array_create_3(nx, ny, nz);
        } else {
            var sN=normal_map[? key];
            normal_map[? key]=array_create_3(sN[0]+nx, sN[1]+ny, sN[2]+nz);
        }
    }
}

for (var j=0; j<ds_grid_height(m.vertices); j++){
    var px=m.vertices[# 0, j];
    var py=m.vertices[# 1, j];
    var pz=m.vertices[# 2, j];
    var key=string(px)+","+string(py)+","+string(pz);
    if (is_array(normal_map[? key])){
        var sN=normalize(normal_map[? key]);
        m.vertices[# 3, j]=sN[0];
        m.vertices[# 4, j]=sN[1];
        m.vertices[# 5, j]=sN[2];
    }
}

d3d_model_clear(m.model);
d3d_model_primitive_begin(m.model, pr_trianglelist);

for (var i=0; i<ds_grid_height(m.vertices); i++){
    d3d_model_vertex_normal_texture_colour(m.model,
        m.vertices[# 0, i], m.vertices[# 1, i], m.vertices[# 2, i],
        m.vertices[# 3, i], m.vertices[# 4, i], m.vertices[# 5, i],
        m.vertices[# 6, i], m.vertices[# 7, i],
        m.vertices[# 8, i], m.vertices[# 9, i]);
}

d3d_model_primitive_end(m.model);

ds_map_destroy(normal_map);

show_debug_message("Smoothing "+string(ds_grid_height(m.vertices))+" vertices took "+string((get_timer()-t_start)/1000000)+" seconds.");
