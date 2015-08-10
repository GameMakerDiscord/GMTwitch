/// twitch_stream_get_thumbnail(channel_id,size);

// size: [0 = small]  [1 = medium]  [2 = large]

// must have already called 'twitch_stream_get_info()' and received stream info
// start the http request for thumbnail files
// ex: URL = http://www.twitch.tv/xarrotstudios/, channel id = "xarrotstudios"

var channel_info = ds_map_find_value(global.Stream_list,argument0);
if (channel_info != undefined)
    {
    var thumb_url = ds_map_find_value(channel_info,"thumb_url");
    if (thumb_url != undefined)
        {
        // thumbnail dimensions
        switch(argument1)
            {
            case 0: // small
                var tw = 80;
                var th = 45;
                break;
            case 1: // medium
                var tw = 320
                var th = 180;
                break;
            case 2: // large
                var tw = 640;
                var th = 360;
                break;
            }
        
        thumb_url = string_replace(thumb_url,"{width}",string(tw));
        thumb_url = string_replace(thumb_url,"{height}",string(th));
        
        // begin thumbnail download request
        var thm_req = http_get_file(thumb_url,working_directory + "\" + string(argument0)+"-thumb.jpg");
        ds_map_add(global.Thumb_list,thm_req,argument0);
        }
    }
