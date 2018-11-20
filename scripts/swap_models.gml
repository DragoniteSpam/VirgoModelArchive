/// void swap_models(model a, model b);

var t_vertices=argument0.vertices;
var t_model=argument0.model;
var t_name=argument0.name;
var t_n_vertices=argument0.n_vertices;

argument0.vertices=argument1.vertices;
argument0.model=argument1.model;
argument0.name=argument1.name;
argument0.n_vertices=argument1.n_vertices;

argument1.vertices=t_vertices;
argument1.model=t_model;
argument1.name=t_name;
argument1.n_vertices=t_n_vertices;
