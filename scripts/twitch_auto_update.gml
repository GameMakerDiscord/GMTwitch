/// twitch_auto_update();

// if you put this in the step event, this script will auto update
// all stream info every 15 seconds

// update the stream info
if (global.Auto_update)
    {
    global.Update_time--;
    if (global.Update_time < 1)
        {
        global.Update_time = room_speed * 15;
        
        // update all stream information
        for(var i=0; i<ds_map_size(global.Stream_list); i++;)
            {
            if (i == 0)
                {
                var channel_id = ds_map_find_first(global.Stream_list);
                }
            else
                {
                var channel_id = ds_map_find_next(global.Stream_list,channel_id);
                }
            
            if (channel_id != undefined)
                {
                var req = http_get("https://api.twitch.tv/kraken/streams/"+string(channel_id)+"/");
                ds_map_add(global.Update_list,req,channel_id);
                }
            }
        }
    }
