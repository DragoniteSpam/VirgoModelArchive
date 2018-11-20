/// void d3d_model_cage(Model);

var xmin=argument0.xmin*grid_size;
var ymin=argument0.ymin*grid_size;
var zmin=argument0.zmin*grid_size;

var xmax=argument0.xmax*grid_size;
var ymax=argument0.ymax*grid_size;
var zmax=argument0.zmax*grid_size;

d3d_primitive_begin(pr_linelist);

// pillars
d3d_vertex_colour(xmin, ymin, zmin, c_black, 1);
d3d_vertex_colour(xmin, ymin, zmax, c_black, 1);

d3d_vertex_colour(xmin, ymax, zmin, c_black, 1);
d3d_vertex_colour(xmin, ymax, zmax, c_black, 1);

d3d_vertex_colour(xmax, ymin, zmin, c_black, 1);
d3d_vertex_colour(xmax, ymin, zmax, c_black, 1);

d3d_vertex_colour(xmax, ymax, zmin, c_black, 1);
d3d_vertex_colour(xmax, ymax, zmax, c_black, 1);

// bottom
d3d_vertex_colour(xmin, ymin, zmin, c_black, 1);
d3d_vertex_colour(xmax, ymin, zmin, c_black, 1);

d3d_vertex_colour(xmin, ymin, zmin, c_black, 1);
d3d_vertex_colour(xmin, ymax, zmin, c_black, 1);

d3d_vertex_colour(xmin, ymin, zmin, c_black, 1);
d3d_vertex_colour(xmax, ymin, zmin, c_black, 1);

d3d_vertex_colour(xmax, ymin, zmin, c_black, 1);
d3d_vertex_colour(xmax, ymax, zmin, c_black, 1);

// top
d3d_vertex_colour(xmin, ymin, zmax, c_black, 1);
d3d_vertex_colour(xmax, ymin, zmax, c_black, 1);

d3d_vertex_colour(xmin, ymin, zmax, c_black, 1);
d3d_vertex_colour(xmin, ymax, zmax, c_black, 1);

d3d_vertex_colour(xmin, ymin, zmax, c_black, 1);
d3d_vertex_colour(xmax, ymin, zmax, c_black, 1);

d3d_vertex_colour(xmax, ymin, zmax, c_black, 1);
d3d_vertex_colour(xmax, ymax, zmax, c_black, 1);

d3d_primitive_end();
