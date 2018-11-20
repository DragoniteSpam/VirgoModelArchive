/// triangle(x1, y1, z1, nx1, ny1, nz1, xtex1, ytex1, color1, alpha1, x2, y2, z2, nx2, ny2, nz2, xtex2, ytex2, color2, alpha2, x3, y3, z3, nx3, ny3, nz3, xtex3, ytex3, color3, alpha3, index);

with (instance_create(0, 0, TempTriangle)){
    for (var i=0; i<3; i++){
        with (t[i]){
            xx=argument[i*10];
            yy=argument[i*10+1];
            zz=argument[i*10+2];
            nx=argument[i*10+3];
            ny=argument[i*10+4];
            nz=argument[i*10+5];
            xtex=argument[i*10+6];
            ytex=argument[i*10+7];
            color=argument[i*10+8];
            a=argument[i*10+9];
        }
    }
    index=argument[30];
    return id;
}
