var n=instance_number(Model);
for (var i=0; i<n-1; i++){
    var model_a=instance_find(Model, i);
    for (var j=i+1; j<n; j++){
        var model_b=instance_find(Model, j);
        if (string_lower(model_a.name)>string_lower(model_b.name)){
            swap_models(model_a, model_b);
            i=0;
        }
    }
}
