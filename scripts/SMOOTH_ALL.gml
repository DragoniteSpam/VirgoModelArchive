/// void SMOOTH_ALL(angle);

var index=selected_model;
for (selected_model=0; selected_model<instance_number(Model); selected_model++){
    var name=instance_find(Model, selected_model).name;
    if (string_copy(name, 1, 2)=="C_"){
        continue;
    }
    SMOOTH(argument0);
}
selected_model=index;
