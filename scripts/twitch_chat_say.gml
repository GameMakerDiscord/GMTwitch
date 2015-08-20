/// twitch_chat_say(msg);

// send a chat message to a channel
// CAUTION: sending more than 20 messages in a 30 second period will ban you from IRC for 8 HOURS!
// the limit is more forgiving with 100 messages in 30 seconds if you are the mod of the channel!

// make sure we can send
if (global.IRC_socket < 0) or (global.IRC_channel == "") or (string(argument0) == "")
    {
    twitch_log("Message sending failed, check connection and message content");
    return(-1);
    }

var send_str = "PRIVMSG "+string(global.IRC_channel)+" :"+string(argument0);

// write the packet and send it
var send_buff = buffer_create(8+string_length(send_str),buffer_fixed,1);
buffer_seek(send_buff,buffer_seek_start,0);
buffer_write(send_buff,buffer_string,string(send_str) + string(chr(13) + chr(10)));
network_send_raw(global.IRC_socket,send_buff,buffer_tell(send_buff));
buffer_delete(send_buff);

ds_list_add(global.Chat_list,string(global.IRC_name)+": "+string(argument0));

twitch_log("Chat message sent!");
twitch_log(string(global.IRC_name)+": "+string(argument0) + chr(10));
