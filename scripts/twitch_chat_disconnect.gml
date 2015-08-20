/// twitch_chat_disconnect();

// remove the socket
if (global.IRC_socket > -1)
    {
    global.IRC_socket = -1;
    network_destroy(global.IRC_socket);
    }

// remove old chats if they exist
if (ds_exists(global.Chat_list,ds_type_list))
    {
    global.Chat_list = -1;
    ds_list_destroy(global.Chat_list);
    }

if (global.Twitch_debuglog)
    twitch_log("TCP socket closed; disconnected from chat.");
