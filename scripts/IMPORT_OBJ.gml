/// void IMPORT_OBJ(model, filename, matfilename);

if (file_exists(argument1)){
    var mtl_name="";
    var active_mtl="None";
    var mtl_alpha=ds_map_create();
    var mtl_color_r=ds_map_create();
    var mtl_color_g=ds_map_create();
    var mtl_color_b=ds_map_create();
    ds_map_set(mtl_alpha, "None", 1);
    ds_map_set(mtl_color_r, "None", 255);
    ds_map_set(mtl_color_g, "None", 255);
    ds_map_set(mtl_color_b, "None", 255);
    
    if (file_exists(argument2)){
        var matfile=file_text_open_read(argument2);
        while (!file_text_eof(matfile)){
            var line=file_text_read_string(matfile);
            file_text_readln(matfile);
            var spl=split(line, " ");
            switch (ds_queue_dequeue(spl)){
                case "newmtl":
                    // Set the material name
                    mtl_name=ds_queue_dequeue(spl);
                    break;
                case "Kd":
                    // Diffuse color (the color we're concerned with)
                    ds_map_set(mtl_color_r, mtl_name, real(ds_queue_dequeue(spl))*255);
                    ds_map_set(mtl_color_g, mtl_name, real(ds_queue_dequeue(spl))*255);
                    ds_map_set(mtl_color_b, mtl_name, real(ds_queue_dequeue(spl))*255);
                    break;
                case "d":
                    // "dissolved" (alpha)
                    ds_map_set(mtl_alpha, mtl_name, real(ds_queue_dequeue(spl)));
                    break;
                default:
                    // There are way more attributes available than I'm going to use in this tutorial
                    break;
            }
            ds_queue_destroy(spl);
        }
        file_text_close(matfile);
    }
    var f=file_text_open_read(argument1);
    var m=argument0;
    m.name=filename_name(argument1);
    var illegal=false;
    var line_number=0;
    
    var v_x=ds_list_create();
    var v_y=ds_list_create();
    var v_z=ds_list_create();
    var v_nx=ds_list_create();
    var v_ny=ds_list_create();
    var v_nz=ds_list_create();
    var v_xtex=ds_list_create();
    var v_ytex=ds_list_create();
    
    var xx, yy, zz, nx, ny, nz, r, g, b, a, xtex, ytex;
    xx[3]=0;
    yy[3]=0;
    zz[3]=0;
    nx[3]=0;
    ny[3]=0;
    nz[3]=0;
    xtex[3]=0;
    ytex[3]=0;
    r[3]=0;
    g[3]=0;
    b[3]=0;
    a[3]=0;
    
    var temp_vertices=ds_list_create();
    
    while(!file_text_eof(f)&&!illegal){
        line_number++;
        var str=file_text_read_string(f);
        file_text_readln(f);
        if (string_length(string_lettersdigits(str))==0||string_char_at(str, 1)="#"){
            continue;
        }
        var q=split(str, " ", false, false);
        
        switch (ds_queue_dequeue(q)){
            case "v":
                if (ds_queue_size(q)>=3){
                    ds_list_add(v_x, real(ds_queue_dequeue(q)));
                    ds_list_add(v_y, real(ds_queue_dequeue(q)));
                    ds_list_add(v_z, real(ds_queue_dequeue(q)));
                } else {
                    show_message("Malformed vertex found (line "+string(line_number)+")");
                    illegal=true;
                }
                break;
            case "vt":
                if (ds_queue_size(q)>=2){
                    ds_list_add(v_xtex, real(ds_queue_dequeue(q)));
                    ds_list_add(v_ytex, real(ds_queue_dequeue(q)));
                } else {
                    show_message("Malformed vertex texture found (line "+string(line_number)+")");
                    illegal=true;
                }
                break;
            case "vn":
                if (ds_queue_size(q)>=3){
                    ds_list_add(v_nx, real(ds_queue_dequeue(q)));
                    ds_list_add(v_ny, real(ds_queue_dequeue(q)));
                    ds_list_add(v_nz, real(ds_queue_dequeue(q)));
                } else {
                    show_message("Malformed vertex normal found (line "+string(line_number)+")");
                    illegal=true;
                }
                break;
            case "usemtl":
                active_mtl=ds_queue_dequeue(q);
                break;
            case "f":
                if (ds_queue_size(q)>=3){
                    var s=ds_queue_size(q);
                    for (var i=0; i<s; i++){
                        var vertex_q=split(ds_queue_dequeue(q), "/", false, true);
                        switch (ds_queue_size(vertex_q)){
                            case 1:
                                var vert=real(ds_queue_dequeue(vertex_q))-1;    // each of these are -1 because they start indexing from 1 instead of 0.
                                xx[i]=v_x[| vert];
                                yy[i]=v_y[| vert];
                                zz[i]=v_z[| vert];
                                nx[i]=0;
                                ny[i]=0;
                                ny[i]=1;
                                xtex[i]=0;
                                ytex[i]=0;
                                if (ds_map_exists(mtl_color_r, active_mtl)){
                                    r[i]=ds_map_find_value(mtl_color_r, active_mtl);
                                } else {
                                    r[i]=255;
                                }
                                if (ds_map_exists(mtl_color_g, active_mtl)){
                                    g[i]=ds_map_find_value(mtl_color_g, active_mtl);
                                } else {
                                    g[i]=255;
                                }
                                if (ds_map_exists(mtl_color_b, active_mtl)){
                                    b[i]=ds_map_find_value(mtl_color_b, active_mtl);
                                } else {
                                    b[i]=255;
                                }
                                if (ds_map_exists(mtl_alpha, active_mtl)){
                                    a[i]=ds_map_find_value(mtl_alpha, active_mtl);
                                } else {
                                    a[i]=1;
                                }
                                break;
                            case 2:
                                var vert=real(ds_queue_dequeue(vertex_q))-1;
                                var tex=real(ds_queue_dequeue(vertex_q))-1;
                                xx[i]=v_x[| vert];
                                yy[i]=v_y[| vert];
                                zz[i]=v_z[| vert];
                                xtex[i]=v_xtex[| tex];
                                ytex[i]=v_ytex[| tex];
                                nx[i]=0;
                                ny[i]=0;
                                ny[i]=1;
                                if (ds_map_exists(mtl_color_r, active_mtl)){
                                    r[i]=ds_map_find_value(mtl_color_r, active_mtl);
                                } else {
                                    r[i]=255;
                                }
                                if (ds_map_exists(mtl_color_g, active_mtl)){
                                    g[i]=ds_map_find_value(mtl_color_g, active_mtl);
                                } else {
                                    g[i]=255;
                                }
                                if (ds_map_exists(mtl_color_b, active_mtl)){
                                    b[i]=ds_map_find_value(mtl_color_b, active_mtl);
                                } else {
                                    b[i]=255;
                                }
                                if (ds_map_exists(mtl_alpha, active_mtl)){
                                    a[i]=ds_map_find_value(mtl_alpha, active_mtl);
                                } else {
                                    a[i]=1;
                                }
                                break;
                            case 3:
                                var vert=real(ds_queue_dequeue(vertex_q))-1;
                                var tex=real(ds_queue_dequeue(vertex_q))-1;
                                var normal=real(ds_queue_dequeue(vertex_q))-1;
                                xx[i]=v_x[| vert];
                                yy[i]=v_y[| vert];
                                zz[i]=v_z[| vert];
                                nx[i]=v_nx[| normal];
                                ny[i]=v_ny[| normal];
                                nz[i]=v_nz[| normal];
                                xtex[i]=v_xtex[| tex];
                                ytex[i]=v_ytex[| tex];
                                if (ds_map_exists(mtl_color_r, active_mtl)){
                                    r[i]=ds_map_find_value(mtl_color_r, active_mtl);
                                } else {
                                    r[i]=255;
                                }
                                if (ds_map_exists(mtl_color_g, active_mtl)){
                                    g[i]=ds_map_find_value(mtl_color_g, active_mtl);
                                } else {
                                    g[i]=255;
                                }
                                if (ds_map_exists(mtl_color_b, active_mtl)){
                                    b[i]=ds_map_find_value(mtl_color_b, active_mtl);
                                } else {
                                    b[i]=255;
                                }
                                if (ds_map_exists(mtl_alpha, active_mtl)){
                                    a[i]=ds_map_find_value(mtl_alpha, active_mtl);
                                } else {
                                    a[i]=1;
                                }
                                if (is_undefined(xtex[i])||is_undefined(ytex[i])){
                                    xtex[i]=0;
                                    ytex[i]=0;
                                }
                                break;
                        }
                    }
                    // Only the first triangle of a face will be added.
                    for (var i=1; i<array_length_1d(xx)-2; i++){
/*                        ds_list_add(temp_vertices, new_temp_vertex(xx[i], yy[i], zz[i], nx[i], ny[i], nz[i], xtex[i], ytex[i], r[i], g[i], b[i], a[i]));
                        ds_list_add(temp_vertices, new_temp_vertex(xx[i+1], yy[i+1], zz[i+1], nx[i+1], ny[i+1], nz[i+1], xtex[i+1], ytex[i+1], r[i+1], g[i+1], b[i+1], a[i+1]));
                        ds_list_add(temp_vertices, new_temp_vertex(xx[i+2], yy[i+2], zz[i+2], nx[i+2], ny[i+2], nz[i+2], xtex[i+2], ytex[i+2], r[i+2], g[i+2], b[i+2], a[i+2]));*/
                        ds_list_add(temp_vertices, new_temp_vertex(xx[0], yy[0], zz[0], nx[0], ny[0], nz[0], xtex[0], ytex[0], r[0], g[0], b[0], a[0]));
                        ds_list_add(temp_vertices, new_temp_vertex(xx[i], yy[i], zz[i], nx[i], ny[i], nz[i], xtex[i], ytex[i], r[i], g[i], b[i], a[i]));
                        ds_list_add(temp_vertices, new_temp_vertex(xx[i+1], yy[i+1], zz[i+1], nx[i+1], ny[i+1], nz[i+1], xtex[i+1], ytex[i+1], r[i+1], g[i+1], b[i+1], a[i+1]));
                    }
                    ds_queue_destroy(vertex_q);
                } else {
                    show_message("Malformed face found (tee hee) (line "+string(line_number)+")");
                    illegal=true;
                }
                break;
            case "s":   // surface something
                break;
            case "mtllib":
                break;
            case "g":   // group
                break;
            case "o":
/*                ds_list_clear(v_x);
                ds_list_clear(v_y);
                ds_list_clear(v_z);
                ds_list_clear(v_nx);
                ds_list_clear(v_ny);
                ds_list_clear(v_nz);
                ds_list_clear(v_xtex);
                ds_list_clear(v_ytex);*/
                break;
            case "l":   // line
                break;
            default:
                show_message("Unsupported thing found in your model, skipping everything (line "+string(line_number)+")");
                illegal=true;
                break;
        }
        
        ds_queue_destroy(q);
    }
    file_text_close(f);
    
    ds_list_destroy(v_x);
    ds_list_destroy(v_y);
    ds_list_destroy(v_z);
    ds_list_destroy(v_nx);
    ds_list_destroy(v_ny);
    ds_list_destroy(v_nz);
    ds_list_destroy(v_xtex);
    ds_list_destroy(v_ytex);

    ds_map_destroy(mtl_alpha);
    ds_map_destroy(mtl_color_r);
    ds_map_destroy(mtl_color_g);
    ds_map_destroy(mtl_color_b);
    
    if (!illegal){
        var n=ds_list_size(temp_vertices);
        ds_grid_resize(m.vertices, 10, n);
        d3d_model_primitive_begin(m.model, pr_trianglelist);
        for (var i=0; i<n; i++){
            var v=temp_vertices[| i];
            if (round2048(v.xtex)>1||round2048(v.ytex)>1){
                v.xtex=v.xtex%1;
                v.ytex=v.ytex%1;
            }
            d3d_model_vertex_normal_texture_colour(m.model, v.xx, v.yy, v.zz, v.nx, v.ny, v.nz, v.xtex, v.ytex, make_color_rgb(v.r, v.g, v.b), v.a);
            m.vertices[# 0, i]=v.xx;
            m.vertices[# 1, i]=v.yy;
            m.vertices[# 2, i]=v.zz;
            m.vertices[# 3, i]=v.nx;
            m.vertices[# 4, i]=v.ny;
            m.vertices[# 5, i]=v.nz;
            m.vertices[# 6, i]=v.xtex;
            m.vertices[# 7, i]=v.ytex;
            m.vertices[# 8, i]=make_color_rgb(v.r, v.g, v.b);
            m.vertices[# 9, i]=v.a;
        }
        m.n_vertices=n;
        d3d_model_primitive_end(m.model);
    }
    
    ds_list_destroy(temp_vertices);
    with (TempVertex){
        instance_destroy();
    }
}
