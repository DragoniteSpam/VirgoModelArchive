/// TempVertex new_temp_vertex(x, y, z, nx, ny, nz, xtex, ytex, r, g, b, a);

with (instance_create(0, 0, TempVertex)){
    xx=argument0;
    yy=argument1;
    zz=argument2;
    
    nx=argument3;
    ny=argument4;
    nz=argument5;
    
    xtex=argument6;
    ytex=argument7;
    
    r=argument8;
    g=argument9;
    b=argument10;
    a=argument11;
    
    return id;
}
