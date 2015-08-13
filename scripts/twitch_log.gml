/// twitch_log(string);

// logs a string to a file if debugging is on

if !(global.Twitch_debuglog)
    return(0);

// compile window debug message
show_debug_message(string(argument0));

// log debug message
var file = file_text_open_append(working_directory+"\debug_log"+string(global.Twitch_debugnum)+".ini");
file_text_write_string(file,string(argument0));
file_text_writeln(file);
file_text_close(file);
