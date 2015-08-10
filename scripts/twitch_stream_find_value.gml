/// twitch_stream_find_value(channel_id,key);

/* list of available keys you can use to find stream's info
[R] = returns real value, [S] = returns string value

REQUIRED: [CALLED 'twitch_stream_get_info()']
    "status"        [R] on/offline

REQUIRED: [CALLED 'twitch_stream_get_info()' AND STREAM IS ONLINE]
    "name"          [S] name of the channel
    "game"          [S] game being streamed on the channel
    "url"           [S] URL of the twitch stream
    "viewers"       [S] current viewers
    "views"         [S] total accumulated views
    "followers"     [S] total followers
    "thumb_url"     [S] URL of thumbnail previews of stream

REQUIRED: [CALLED 'twitch_stream_get_info()' AND 'twitch_stream_get_thumbnail()' AND STREAM IS ONLINE]
    "thumb"         [R] thumbnail sprite handle */

var channel_info = ds_map_find_value(global.Stream_list,argument0);
if (channel_info != undefined)
    {
    return(ds_map_find_value(channel_info,argument1));
    }
