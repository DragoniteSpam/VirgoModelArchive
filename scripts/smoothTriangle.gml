/// void smoothTriangle(vertex, threshold, id);

var onx=argument2.nx;
var ony=argument2.ny;
var onz=argument2.nz;
var nnx=0;
var nny=0;
var nnz=0;
var mxx=argument0.xx;
var myy=argument0.yy;
var mzz=argument0.zz;

with (TempTriangle){
    if ((onx*nx+ony*ny+onz*nz)>=argument1){
        if ((t[0].xx==argument0.xx)||(t[0].yy==argument0.yy)||(t[0].zz==argument0.zz)||
            (t[1].xx==argument0.xx)||(t[1].yy==argument0.yy)||(t[1].zz==argument0.zz)||
            (t[2].xx==argument0.xx)||(t[2].yy==argument0.yy)||(t[2].zz==argument0.zz)){
            nnx=nnx+nx;
            nny=nny+ny;
            nnz=nnz+nz;
        }
    }
}

var a2=normalize(array_create_3(nnx, nny, nnz));

argument0.nx=a2[0];
argument0.ny=a2[1];
argument0.nz=a2[2];
