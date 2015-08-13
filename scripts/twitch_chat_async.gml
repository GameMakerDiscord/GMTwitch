/// twitch_chat_async();

// put this script in the Network Async event to correctly retrieve chat info

// get buffer data
var net_buff = ds_map_find_value(async_load,"buffer");
var net_size = buffer_get_size(net_buff);
buffer_seek(net_buff,buffer_seek_start,0);

var data_list  = ds_list_create();

// received all lines of text and add to list to be evaluated
while(buffer_tell(net_buff) < buffer_get_size(net_buff))
    {
    var str = buffer_read(net_buff,buffer_string);
    ds_list_add(data_list,str);
    }

// loop through received data
for(var i=0; i<ds_list_size(data_list); i++;)
    {
    // next string of data
    var str = ds_list_find_value(data_list,i);
    
    // chat message
    if (string_pos("PRIVMSG",str) != 0)
        {
        var pos_start = 2;
        var pos_end   = string_pos("!",str);
        var name      = string_copy(str,pos_start,pos_end - pos_start);
        
        var pos_start = string_pos(string(global.IRC_channel+" :"),str);
        var pos_end   = string_length(str);
        var data      = string_copy(str,pos_start+string_length(global.IRC_channel+" :"),pos_end - pos_start);
        
        // create chat list if it doesn't exist
        if !(ds_exists(global.Chat_list,ds_type_list))
            global.Chat_list = ds_list_create();
        
        // add the chat message to the list
        ds_list_insert(global.Chat_list,0,string(name)+": "+string(data));
        
        twitch_log("Chat message received!");
        twitch_log(string(name)+": "+string(data));
        }
    // keep alive message
    else if (string_pos("PING", str) != 0)
        {
        var net_buff = buffer_create(128,buffer_fixed,1);
        buffer_seek(net_buff,buffer_seek_start,0);
        buffer_write(net_buff,buffer_string,"PING tmi.twitch.tv"+chr(13)+chr(10));
        network_send_raw(global.IRC_socket,net_buff,buffer_get_size(net_buff));
        buffer_delete(net_buff);
        
        twitch_log("Heartbeat message received!");
        }
    // keep alive reply
    else if (string_pos("PONG",str) != 0)
        {
        twitch_log("Heartbeat reply received!");
        twitch_log(str);
        }
    // error message
    else if(string_pos("NOTICE",str) != 0)
        {
        var pos_start = string_pos(string(global.IRC_channel+" :"),str);
        var pos_end   = string_length(str);
        var data      = string_copy(str,pos_start+string_length(global.IRC_channel+" :"),pos_end - pos_start);
        
        // remove the socket
        if (global.IRC_socket > -1)
            {
            global.IRC_socket = -1;
            network_destroy(global.IRC_socket);
            }
        
        twitch_log("Error notice received!");
        twitch_log(data);
        }
    // unkown
    else
        {
        twitch_log("Unknown data received!");
        twitch_log(str);
        }
    }

ds_list_destroy(data_list);
