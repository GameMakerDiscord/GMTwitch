/// twitch_update();

// update all twitch streams manually, so don't put this in the step

// update the stream info
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
        var headers = ds_map_create();                                  
        ds_map_add(headers, "Client-ID", global.Client_ID);
        ds_map_add(headers, "Accept", "application/vnd.twitchtv.v3+json"); 

        var req = http_request("https://api.twitch.tv/kraken/streams/"+string(channel_id)+"/", "GET", headers, "");
        ds_map_add(global.Update_list,req,channel_id);
        }
    }
