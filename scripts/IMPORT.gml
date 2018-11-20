var fn=get_open_filename("Model files (*.d3d, *.gmmod, *.obj)|*.d3d;*.gmmod;*.obj", "model.d3d")
if (file_exists(fn)){
    if (filename_ext(fn)==".d3d"||filename_ext(fn)==".gmmod"){
        var m=argument0;
        m.name=filename_name(fn);
        var f=file_text_open_read(fn);
        file_text_readln(f);
        var n=file_text_read_real(f)-2;
        file_text_readln(f);
        d3d_model_clear(m.model);
        d3d_model_primitive_begin(m.model, pr_trianglelist);
        ds_grid_resize(m.vertices, 10, n);
        ds_grid_clear(m.vertices, 0);
        line=0;
        while (!file_text_eof(f)){
            var type=file_text_read_real(f);
            var xx=0;
            var yy=0;
            var zz=0;
            var nx=0;
            var ny=0;
            var nz=0;
            var xtex=0;
            var ytex=0;
            var color=c_white;
            var alpha=1;
            var add=true;
            switch (type){
                case 0:
                    file_text_readln(f);
                    add=false;
                    break;
                case 1:
                    file_text_readln(f);
                    add=false;
                    break;
                case 2:
                    xx=file_text_read_real(f);
                    yy=file_text_read_real(f);
                    zz=file_text_read_real(f);
                    file_text_readln(f);
                    break;
                case 3:
                    xx=file_text_read_real(f);
                    yy=file_text_read_real(f);
                    zz=file_text_read_real(f);
                    color=file_text_read_real(f);
                    alpha=file_text_read_real(f);
                    file_text_readln(f);
                    break;
                case 4:
                    xx=file_text_read_real(f);
                    yy=file_text_read_real(f);
                    zz=file_text_read_real(f);
                    xtex=file_text_read_real(f);
                    ytex=file_text_read_real(f);
                    file_text_readln(f);
                    break;
                case 5:
                    xx=file_text_read_real(f);
                    yy=file_text_read_real(f);
                    zz=file_text_read_real(f);
                    xtex=file_text_read_real(f);
                    ytex=file_text_read_real(f);
                    color=file_text_read_real(f);
                    alpha=file_text_read_real(f);
                    file_text_readln(f);
                    break;
                case 6:
                    xx=file_text_read_real(f);
                    yy=file_text_read_real(f);
                    zz=file_text_read_real(f);
                    nx=file_text_read_real(f);
                    ny=file_text_read_real(f);
                    nz=file_text_read_real(f);
                    file_text_readln(f);
                    break;
                case 7:
                    xx=file_text_read_real(f);
                    yy=file_text_read_real(f);
                    zz=file_text_read_real(f);
                    nx=file_text_read_real(f);
                    ny=file_text_read_real(f);
                    nz=file_text_read_real(f);
                    color=file_text_read_real(f);
                    alpha=file_text_read_real(f);
                    file_text_readln(f);
                    break;
                case 8:
                    xx=file_text_read_real(f);
                    yy=file_text_read_real(f);
                    zz=file_text_read_real(f);
                    nx=file_text_read_real(f);
                    ny=file_text_read_real(f);
                    nz=file_text_read_real(f);
                    xtex=file_text_read_real(f);
                    ytex=file_text_read_real(f);
                    file_text_readln(f);
                    break;
                case 9:
                    xx=file_text_read_real(f);
                    yy=file_text_read_real(f);
                    zz=file_text_read_real(f);
                    nx=file_text_read_real(f);
                    ny=file_text_read_real(f);
                    nz=file_text_read_real(f);
                    xtex=file_text_read_real(f);
                    ytex=file_text_read_real(f);
                    color=file_text_read_real(f);
                    alpha=file_text_read_real(f)
                    file_text_readln(f);
                    break;
                default:
                    show_message("Unsupported structure. Please convert your primitive shapes into triangles. Thank.");
                    add=false;
                    break;
            }
            if (add){
                xtex=round2048(xtex);
                ytex=round2048(ytex);
                if (xtex>1||ytex>1){
                    xtex=xtex%1;
                    ytex=ytex%1;
                }
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
        }
        file_text_close(f);
        d3d_model_primitive_end(m.model);
        m.n_vertices=line;
    } else if (filename_ext(fn)==".obj"){
        var mfn=get_open_filename("Material Template Library files|*.mtl", string_replace(fn, filename_ext(fn), "")+".mtl")
        IMPORT_OBJ(argument0, fn, mfn);
    }
}
