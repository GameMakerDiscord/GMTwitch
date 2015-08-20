/// twitch_chat_connect(channel_id,username,oauth);

// ex: URL = http://www.twitch.tv/xarrotstudios/, channel id = "xarrotstudios"
// username is a valid twitch username, signed up with Twitch
// oauth is the Oauth token given to you by Twitch API here: http://www.twitchapps.com/tmi/
// an example of a valid Oauth key: "oauth:123456789012345678901234567890"

// irc chat login info
global.IRC_channel = "#"+string(argument0);
global.IRC_name    = argument1;
global.IRC_oauth   = argument2;

// remove old chats if they exist
if (ds_exists(global.Chat_list,ds_type_list))
    ds_list_clear(global.Chat_list);
else
    global.Chat_list = ds_list_create();

// create the tcp socket we will connect with
if (global.IRC_socket == -1)
    global.IRC_socket = network_create_socket(network_socket_tcp);
else
    {
    twitch_log("Failed to create new socket, socket already exists!");
    return(-1);
    }

// make sure the socket was successfully created
if (global.IRC_socket < 0)
    {
    network_destroy(global.IRC_socket);
    global.IRC_socket = -1;
    twitch_log("Failed to create TCP socket");
    return(-1);
    }
else
    twitch_log("TCP Socket created, attempting to connect...");

// resolve ip address
var address = network_resolve("irc.twitch.tv");
twitch_log("Connecting to 'irc.twitch.tv' ["+string(address)+"]");

// connect
var success = network_connect_raw(global.IRC_socket,"irc.twitch.tv",6667);
if (success < 0)
    {
    network_destroy(global.IRC_socket);
    global.IRC_socket = -1;
    twitch_log("Failed to connect to "+string(address)+" on port 6667");
    return(-1);
    }
else
    twitch_log("Successfully connected to "+string(address)+" on port 6667");

// chr(13) = \r and chr(10) = \n
// put \r and \n together at the end of a string to escape (end) the string

// handshake the chat server with our info
var send_buff = buffer_create(128,buffer_fixed,1);
for(var i=0; i<3; i++;)
    {
    // Oauth packet details
    if (i == 0)
        var send_str = "PASS "+string(global.IRC_oauth);
    // nickname packet details
    else if (i == 1)
        var send_str = "NICK "+string(global.IRC_name);
    // channel packet details
    else
        var send_str = "JOIN "+string(global.IRC_channel);
    
    // write the packet and send it
    buffer_seek(send_buff,buffer_seek_start,0);
    buffer_write(send_buff,buffer_string,string(send_str) + string(chr(13) + chr(10)));
    network_send_raw(global.IRC_socket,send_buff,buffer_get_size(send_buff));
    }

buffer_delete(send_buff);
