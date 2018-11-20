if (selected_model>=0){
    var md=instance_find(Model, selected_model);
    md.name=get_string("Model name.", md.name);
}
