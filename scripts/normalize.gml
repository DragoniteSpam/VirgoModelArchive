/// normalize(vector array);
//Returns the unit vector with the same direction
//Also returns the length of the original vector

var v=argument0;
var l=point_distance_3d(0, 0, 0, v[0], v[1], v[2]);

if (l != 0){
    return array_create_3(v[0]/l, v[1]/l, v[2]/l);
}

return array_create_3(0, 0, 1);
