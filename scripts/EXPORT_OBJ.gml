var model=argument0;
var yzswap=argument1;
var uvswap=argument2;

var filename=get_save_filename("Wavefront OBJ files|*.obj", model.name+".obj");
var matfilename=get_save_filename("Material Template Library files|*.mtl", model.name+".mtl");

if (filename!=""&&matfilename!=""){
    var buffer=buffer_create(buffer_grow, 1, 1024);

    buffer_write(buffer, buffer_text, "# Virgo Model Archive OBJ file: "+filename_name(matfilename));
    buffer_newline(buffer);
    buffer_newline(buffer);
    
    buffer_write(buffer, buffer_text, "mtllib "+filename_name(matfilename));
    buffer_newline(buffer);
    
    var active_mtl="None";
    var mtl_warned=false;
    
    var mtl_alpha=ds_map_create();
    var mtl_r=ds_map_create();
    var mtl_g=ds_map_create();
    var mtl_b=ds_map_create();
    
    ds_map_add(mtl_alpha, "None", 1);
    ds_map_add(mtl_r, "None", 255);
    ds_map_add(mtl_g, "None", 255);
    ds_map_add(mtl_b, "None", 255);
    
    var c, a;
    c[2]=c_white;
    c[1]=c_white;
    c[0]=c_white;
    a[2]=1;
    a[1]=1;
    a[0]=1;
    
    for (var i=0; i<model.n_vertices; i+=3){
        for (var j=0; j<3; j++){
            var xx=model.vertices[# 0, i+j];
            var yy=model.vertices[# 1, i+j];
            var zz=model.vertices[# 2, i+j];
            var nx=model.vertices[# 3, i+j];
            var ny=model.vertices[# 4, i+j];
            var nz=model.vertices[# 5, i+j];
            var xtex=round2048(model.vertices[# 6, i+j]);
            var ytex=round2048(model.vertices[# 7, i+j]);
            var color=floor(model.vertices[# 8, i+j]);
            var alpha=model.vertices[# 9, i+j];
            
            if (yzswap){
                var t=xx;
                xx=yy;
                yy=zz;
                zz=t;
            }
            
            if (uvswap){
                ytex=1-ytex;
            }
            
            var str_vert="v "+string(xx)+" "+string(yy)+" "+string(zz);
            var str_texture="vt "+string_format(xtex, 1, 8)+" "+string_format(ytex, 1, 8);
            var str_normal="vn "+string(nx)+" "+string(ny)+" "+string(nz);
            
            buffer_write(buffer, buffer_text, str_vert);
            buffer_newline(buffer);
            buffer_write(buffer, buffer_text, str_texture);
            buffer_newline(buffer);
            buffer_write(buffer, buffer_text, str_normal);
            buffer_newline(buffer);
        }
        
        c[0]=model.vertices[# 8, i];
        c[1]=model.vertices[# 8, i+1];
        c[2]=model.vertices[# 8, i+2];
        a[0]=model.vertices[# 9, i];
        a[1]=model.vertices[# 9, i+1];
        a[2]=model.vertices[# 9, i+2];
        
        var color=floor((c[0]+c[1]+c[2])/3);
        var alpha=(a[0]+a[1]+a[2])/3;
        
        if (!mtl_warned&&color!=c[0]||alpha!=a[0]){
            mtl_warned=true;
            show_message("You have triangles with different colors/alpha values on different vertices. "+
                "The Wavefront OBJ file format only supports per-face color/alpha values. The average value will be used instead.");
        }
        
        var str_mtl="";
        
        var mtl_name=string(color)+","+string(alpha);
        
        if (!ds_map_exists(mtl_alpha, mtl_name)){
            ds_map_set(mtl_alpha, mtl_name, alpha);
            ds_map_set(mtl_r, mtl_name, colour_get_red(color));
            ds_map_set(mtl_g, mtl_name, colour_get_green(color));
            ds_map_set(mtl_b, mtl_name, colour_get_blue(color));
        }
        
        if (mtl_name!=active_mtl){
            active_mtl=mtl_name;
            str_mtl=mtl_name;
        }
        
        if (string_length(str_mtl)>0){
            buffer_write(buffer, buffer_text, "usemtl "+str_mtl);
            buffer_newline(buffer);
        }
        var str="f "+string(i+1)+"/"+string(i+1)+"/"+string(i+1)+" "+
            string(i+2)+"/"+string(i+2)+"/"+string(i+2)+" "+
            string(i+3)+"/"+string(i+3)+"/"+string(i+3);

        buffer_write(buffer, buffer_text, str);
        buffer_newline(buffer);
        buffer_newline(buffer);        
    }
    
    buffer_save(buffer, filename);
    
    var f=file_text_open_write(matfilename);
    file_text_write_string(f, "# Virgo Model Archive MTL file: "+filename_name(matfilename));
    file_text_writeln(f);
    file_text_write_string(f, "# Material count: "+string(ds_map_size(mtl_alpha)));
    file_text_writeln(f);
    file_text_writeln(f);
    
    var mtl="";
    do {
        if (string_length(mtl)==0){
            mtl=ds_map_find_first(mtl_alpha);
        } else {
            mtl=ds_map_find_next(mtl_alpha, mtl);
        }
        file_text_write_string(f, "newmtl "+mtl);
        file_text_writeln(f);
        var kd_string="Kd "+string(ds_map_find_value(mtl_r, mtl)/255)+" "+
            string(ds_map_find_value(mtl_g, mtl)/255)+" "+string(ds_map_find_value(mtl_b, mtl)/255);
        var d_string="d "+string(ds_map_find_value(mtl_alpha, mtl));
        file_text_write_string(f, kd_string);
        file_text_writeln(f);
        file_text_write_string(f, d_string);
        file_text_writeln(f);
        file_text_write_string(f, "illum 2");
        file_text_writeln(f);
        file_text_writeln(f);
    } until(mtl==ds_map_find_last(mtl_alpha));
    file_text_close(f);
}
