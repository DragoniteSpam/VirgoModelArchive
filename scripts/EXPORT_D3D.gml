var fn=get_save_filename("Game Maker models (*.d3d)|*.d3d", "model.d3d")
if (fn!=""){
    var model=argument0;
    var f=file_text_open_write(fn);
    file_text_write_string(f, "100");
    file_text_writeln(f);
    file_text_write_string(f, string(ds_grid_height(model.vertices)+2));
    file_text_writeln(f);
    file_text_write_string(f, "0 4");
    file_text_writeln(f);
    for (var i=0; i<ds_grid_height(model.vertices); i++){
        var str="9 "+string(model.vertices[# 0, i])+" "+string(model.vertices[# 1, i])+" "+
            string(model.vertices[# 2, i])+" "+string(model.vertices[# 3, i])+" "+
            string(model.vertices[# 4, i])+" "+string(model.vertices[# 5, i])+" "+
            string(model.vertices[# 6, i])+" "+string(model.vertices[# 7, i])+" "+
            string(model.vertices[# 8, i])+" "+string(model.vertices[# 9, i]);
        file_text_write_string(f, str);
        file_text_writeln(f);
        
    }
    file_text_write_string(f, "1");
    file_text_writeln(f);
    file_text_close(f);
}
