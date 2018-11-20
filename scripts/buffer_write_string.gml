/// void buffer_write_string(buffer, string);
// Writes a string to fit a buffer of float32s.

for (var i=1; i<=string_length(argument1); i++){
    buffer_write(argument0, T, ord(string_char_at(argument1, i)));
}
buffer_write(argument0, T, 0.0);
