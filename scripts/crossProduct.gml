var u=argument0;
var v=argument1;

var array;
array[2]=u[0]*v[1]-u[1]*v[0];
array[1]=u[2]*v[0]-u[0]*v[2];
array[0]=u[1]*v[2]-u[2]*v[1];

return array;
