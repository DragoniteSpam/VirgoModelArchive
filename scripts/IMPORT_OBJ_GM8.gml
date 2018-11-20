/// void IMPORT_OBJ_GM8(model, filename);

var m=argument0;
m.name=filename_name(argument1);

var file=file_text_open_read(argument1);
var n=0;
while(!file_text_eof(file)){
    var str=file_text_read_string(file);
    file_text_readln(file);
    if (string_starts_with(str, "v ")){
        n++;
    }
}
file_text_close(file);

var file=file_text_open_read(argument1);

d3d_model_clear(m.model);
d3d_model_primitive_begin(m.model, pr_trianglelist);
ds_grid_resize(m.vertices, 10, n);
ds_grid_clear(m.vertices, 0);
line=0;

var r, g, b;

var short_filename=string_replace(filename_name(argument0), filename_ext(argument0), "")+".mtl"
var matFileName = get_open_filename("Material files|"+short_filename, short_filename);
if (file_exists(matFileName)){
    var vertexColor = c_white;
     
    var v_listX = ds_list_create();
    var v_listY = ds_list_create();
    var v_listZ = ds_list_create();
     
    var vt_listX = ds_list_create();
    var vt_listY = ds_list_create();
    var vt_listZ = ds_list_create();
     
    var vn_listX = ds_list_create();
    var vn_listY = ds_list_create();
    var vn_listZ = ds_list_create();
     
    var model = d3d_model_create();
    d3d_model_primitive_begin(model, pr_trianglelist);
     
    var zeile,nx,ny,nz,tx,ty,sx,vx,vy,vz;
     
    while (!file_text_eof(file)){
        zeile = file_text_read_string(file);
        if (string_char_at(zeile,1) != '#'){ //if the first character is not a comment
     
            switch (string_char_at(zeile,1)){
                case 'v':
               
                switch (string_char_at(zeile,2)){
                    case 'n':
                        zeile=string_delete(zeile,1,string_pos(" ",zeile));
                        nx=real(string_copy(zeile,1,string_pos(" ",zeile)));
                        zeile=string_delete(zeile,1,string_pos(" ",zeile));
                        ny=-1*real(string_copy(zeile,1,string_pos(" ",zeile)));
                        zeile=string_delete(zeile,1,string_pos(" ",zeile));
                        nz=real(string_copy(zeile,1,string_length(zeile)));
                       
                        ds_list_add(vn_listX,nx);
                        ds_list_add(vn_listY,ny);
                        ds_list_add(vn_listZ,nz);  
                    break;
                   
                    case 't':
                        zeile=string_delete(zeile,1,string_pos(" ",zeile));
                        tx=real(string_copy(zeile,1,string_pos(" ",zeile)));
                        zeile=string_delete(zeile,1,string_pos(" ",zeile));
                        ty=1-real(string_copy(zeile,1,string_length(zeile)));
                       
                        ds_list_add(vt_listX,tx);
                        ds_list_add(vt_listY,ty);
                    break;
                   
                   
                    default:
                        zeile=string_delete(zeile,1,string_pos(" ",zeile));
                        vx=real(string_copy(zeile,1,string_pos(" ",zeile)));
                        zeile=string_delete(zeile,1,string_pos(" ",zeile));
                        vy=real(string_copy(zeile,1,string_pos(" ",zeile)))*-1;
                        zeile=string_delete(zeile,1,string_pos(" ",zeile));
                        vz=real(string_copy(zeile,1,string_length(zeile)));
                       
                        ds_list_add(v_listX,vx);
                        ds_list_add(v_listY,vy);
                        ds_list_add(v_listZ,vz);
                    break;
                   
                }
               
                break;
               
               
                case 's':   // smooth shading - unused
                    zeile=string_delete(zeile,1,string_pos(" ",zeile));
                    sx=string(string_copy(zeile,1,string_pos(" ",zeile)));
                    if (sx != "off"){
                   
                    }
               
                break;
               
               
                case 'u':
                    if(string_copy(zeile,2,5) == "semtl"){  // short for "usemtl"
                        zeile=string_delete(zeile,1,string_pos(" ",zeile));
                        var vertexColorName=string(string_copy(zeile,1,string_length(zeile))); //Materialname in modelfile
                     
                        var matFile = file_text_open_read(matFileName);
           
                       
                        while (file_text_eof(matFile)==false){
                            zeile = file_text_read_string(matFile);
                           
                            if (string_char_at(zeile,1) != '#'){ //if not comment
                       
                                switch (string_char_at(zeile,1)){
                                   
                                    case 'n':
                                   
                                        if(string_copy(zeile,2,5) == "ewmtl"){
                                       
                                            zeile=string_delete(zeile,1,string_pos(" ",zeile));
                                            vertexColorNameMat=string(string_copy(zeile,1,string_length(zeile))); //Colorname in Materialfile
                                        }                
                                   
                                   
                                    break;
                                   
                                   
                                    case 'K':
                                   
                                    switch (string_char_at(zeile,2)){
                                        case 'd':
                                       
                                            if (vertexColorName == vertexColorNameMat){//if colorname in modelfile and materialfile are equal
                                       
                                                zeile=string_delete(zeile,1,string_pos(" ",zeile));
                                                r=256*real(string_copy(zeile,1,string_pos(" ",zeile)));
                                                zeile=string_delete(zeile,1,string_pos(" ",zeile));
                                                g=256*real(string_copy(zeile,1,string_pos(" ",zeile)));
                                                zeile=string_delete(zeile,1,string_pos(" ",zeile));
                                                b=256*real(string_copy(zeile,1,string_length(zeile)));
                                               
                                                vertexColor = make_color_rgb(r,g,b);
                                            }
                                        break;
                                       
                                    }
                                   
                                    break;
                                }
                               
                            }
                            file_text_readln(matFile);
                       
                        }
                       
                        file_text_close(matFile);
                       
                        //---------------------------------------------------------------------------------------------------
                    }
               
                break;
               
               
                case 'f':
                var f;
               
                zeile=string_delete(zeile,1,string_pos(" ",zeile));
                f[0]=string(string_copy(zeile,1,string_pos(" ",zeile)));
                zeile=string_delete(zeile,1,string_pos(" ",zeile));
                f[2]=string(string_copy(zeile,1,string_pos(" ",zeile)));
                zeile=string_delete(zeile,1,string_pos(" ",zeile));
                f[1]=string(string_copy(zeile,1,string_length(zeile)));
               
                    var p,z,e1,e2,e3;
                    p=0;
                    repeat(3){
                        z = f[p];
                       
                        z=string_delete(z,0,string_pos("/",z));
                        e1=real(string(string_copy(z,1,string_pos("/",z)-1)))-1;
                        z=string_delete(z,1,string_pos("/",z));
                        e2=real(string(string_copy(z,1,string_pos("/",z)-1)))-1;
                        z=string_delete(z,1,string_pos("/",z));
                        e3=real(string(string_copy(z,1,string_length(z))))-1;
                       
                        p++;

                        var xx=v_listX[| e1];
                        var yy=v_listY[| e1];
                        var zz=v_listZ[| e1];
                        var nx=vn_listX[| e3];
                        var ny=vn_listY[| e3];
                        var nz=vn_listZ[| e3];
                        var xtex=vt_listX[| e2];
                        var ytex=vt_listY[| e2];
                        var color=vertexColor;
                        var alpha=1;

                        d3d_model_vertex_normal_texture_colour(m.model, xx, yy, zz, nx, ny, nz, xtex, ytex, color, alpha);
                        m.vertices[# 0, line]=xx;
                        m.vertices[# 1, line]=yy;
                        m.vertices[# 2, line]=zz;
                        m.vertices[# 3, line]=nx;
                        m.vertices[# 4, line]=ny;
                        m.vertices[# 5, line]=nz;
                        m.vertices[# 6, line]=xtex;
                        m.vertices[# 7, line]=ytex;
                        m.vertices[# 8, line]=color;
                        m.vertices[# 9, line]=alpha;
                        line++;
                   
                    }
                break;
            }
        }
        file_text_readln(file);
    }
     
    file_text_close(file);
     
    d3d_model_primitive_end(m.model);
    m.n_vertices=line;
     
    //delete lists
    ds_list_destroy(v_listX);
    ds_list_destroy(v_listY);
    ds_list_destroy(v_listZ);
    ds_list_destroy(vt_listX);
    ds_list_destroy(vt_listY);
    ds_list_destroy(vn_listX);
    ds_list_destroy(vn_listY);
    ds_list_destroy(vn_listZ);
}
