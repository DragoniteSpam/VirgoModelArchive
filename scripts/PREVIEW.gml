var fn=get_open_filename("Image files (png, bmp, jpg)|*.png;*.bmp;*.jpg;*.jpeg", "texture.png")
if (file_exists(fn)){
    if (background_exists(def_tex_background)){
        background_delete(def_tex_background);
    }
    def_tex_background=background_add(fn, false, false);
    def_tex=background_get_texture(def_tex_background);
}
