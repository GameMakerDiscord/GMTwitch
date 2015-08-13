/// twitch_async();

// put this script in the HTTP Async event to correctly retrieve stream info

var request_id = ds_map_find_value(async_load,"id");
var status = ds_map_find_value(async_load,"status");
var result = ds_map_find_value(async_load,"result");

if (status == 0) and (result != "")
    {
    // received stream info
    for(var i=0; i<ds_map_size(global.Update_list); i++;)
        {
        if (i == 0)
            var update_id = ds_map_find_first(global.Update_list);
        else
            var update_id = ds_map_find_next(global.Update_list,update_id);
        
        if (update_id == undefined)
            continue; 
        else
            {
            // matched incoming request ID with existing ID
            if (request_id == update_id)
                {
                var channel_id = ds_map_find_value(global.Update_list,update_id);
                var channel_info = ds_map_find_value(global.Stream_list,channel_id);
                
                if (global.Twitch_debuglog)
                    {
                    twitch_log("Request successful; stream info received!");
                    }
                
                // remove the request from the update list
                ds_map_delete(global.Update_list,update_id);
                
                var q = chr(34);
                // check if online
                if (string_count(string(q)+"stream"+string(q)+":null",result) > 0)
                    {
                    // offline
                    ds_map_replace(channel_info,"game","");
                    ds_map_replace(channel_info,"status",false);
                    ds_map_replace(channel_info,"viewers","0");
                    }
                else
                    {
                    // online
                    
                    twitch_parse_data(result,channel_id);
                    
                    var name = twitch_parse_data(result,"display_name");
                    var game = twitch_parse_data(result,"game");
                    var url = twitch_parse_data(result,"url");
                    var viewers = twitch_parse_data(result,"viewers");
                    var views = twitch_parse_data(result,"views");
                    var followers = twitch_parse_data(result,"followers");
                    var thumb_url = twitch_parse_data(result,"template");
                    
                    ds_map_replace(channel_info,"name",name);
                    ds_map_replace(channel_info,"game",game);
                    ds_map_replace(channel_info,"url",url);
                    ds_map_replace(channel_info,"status",true);
                    ds_map_replace(channel_info,"viewers",viewers);
                    ds_map_replace(channel_info,"views",views);
                    ds_map_replace(channel_info,"followers",followers);
                    ds_map_replace(channel_info,"thumb_url",thumb_url);
                    }
                break;
                }
            }
        }
    
    // downloaded thumbnail
    var update_id = 0;
    for(var i=0; i<ds_map_size(global.Thumb_list); i++;)
        {
        if (i == 0)
            update_id = ds_map_find_first(global.Thumb_list);
        else
            update_id = ds_map_find_next(global.Thumb_list,update_id);
        
        if (update_id == undefined)
            continue; 
        else
            {
            // matched incoming thumbnail request with existing request
            if (request_id == update_id)
                {
                var channel_id = ds_map_find_value(global.Thumb_list,update_id);
                var channel_info = ds_map_find_value(global.Stream_list,channel_id);
                
                if (global.Twitch_debuglog)
                    {
                    twitch_log("Request successful; thumbnail received!");
                    }
                
                // remove the request from the update list
                ds_map_delete(global.Thumb_list,update_id);
                
                // add the sprite
                var file = working_directory + "\" + string(channel_id)+"-thumb.jpg";
                if (file_exists(file))
                    {
                    var spr = sprite_add(file,1,false,false,0,0);
                    ds_map_replace(channel_info,"thumb",spr);
                    }
                break;
                }
            }
        }
    }
