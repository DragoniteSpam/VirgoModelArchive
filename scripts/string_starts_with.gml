/// boolean string_starts_with(str, substr);

for (var i=1; i<=min(string_length(argument0), string_length(argument1)); i++){
    if (string_char_at(argument0, i)!=string_char_at(argument1, i)){
        return false;
    }
}

return true;
