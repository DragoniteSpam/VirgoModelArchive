if (selected_model>=0){
    with (instance_find(Model, selected_model)){
        instance_destroy();
    }
    if (selected_model==instance_number(Model)){
        selected_model--;
    }
}
