/// twitch_stream_get_info(channel_id);

// start the http request and setup dictionary for the channel info
// ex: URL = http://www.twitch.tv/xarrotstudios/, channel id = "xarrotstudios"

if (ds_map_find_value(global.Stream_list,argument0) == undefined)
    {
    var map = ds_map_create();
    ds_map_add(global.Stream_list,argument0,map);
    
    ds_map_add(map,"name","");
    ds_map_add(map,"game","");
    ds_map_add(map,"url","");
    ds_map_add(map,"status",false);
    ds_map_add(map,"viewers","0");
    ds_map_add(map,"views","0");
    ds_map_add(map,"followers","0");
    ds_map_add(map,"thumb_url","");
    ds_map_add(map,"thumb",-1);
    }

var req = http_get("https://api.twitch.tv/kraken/streams/"+string(argument0)+"/");
ds_map_add(global.Update_list,req,argument0);
