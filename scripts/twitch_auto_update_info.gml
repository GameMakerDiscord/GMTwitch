/// twitch_auto_update_info();

// if you put this in the step event, this script will auto update
// all stream info every 15 seconds

// update the stream info
if (global.Update_autochck)
    {
    global.Update_timeleft--;
    if (global.Update_timeleft < 1)
        {
        global.Update_timeleft = global.Update_interval;
        
        // update all stream information
        for(var i=0; i<ds_map_size(global.Stream_list); i++;)
            {
            if (i == 0)
                var channel_id = ds_map_find_first(global.Stream_list);
            else
                var channel_id = ds_map_find_next(global.Stream_list,channel_id);
            
            // if stream info exists
            if (channel_id != undefined)
                {
                // request new info
                var headers = ds_map_create(); //List of headers to be sent with the request. Mostly needed for Client ID, but useful for version number and potentialy oauth tokens.
                ds_map_add(headers, "Client-ID", global.Client_ID); //Twitch requires a Client ID
                ds_map_add(headers, "Accept", "application/vnd.twitchtv.v3+json"); //We want v3, it has more stuff

                var req = http_request("https://api.twitch.tv/kraken/streams/"+string(channel_id)+"/", "GET", headers, "");
                ds_map_add(global.Update_list,req,channel_id);
                }
            }
        }
    }
