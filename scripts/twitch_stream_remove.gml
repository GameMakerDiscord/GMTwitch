/// twitch_stream_remove(channel_id);

// remove stream from dictionary and update list
// ex: URL = http://www.twitch.tv/xarrotstudios/, channel id = "xarrotstudios"

var channel_info = ds_map_find_value(global.Stream_list,argument0);
if (channel_info != undefined)
    {
    var spr = ds_map_find_value(channel_info,"thumb");
    if (spr != undefined)
        {
        if (sprite_exists(spr))
            {
            sprite_delete(spr);
            }
        }
    
    ds_map_destroy(channel_info);
    
    for(var i=0; i<ds_map_size(global.Update_list); i++;)
        {
        if (i == 0)
            {
            var update_id = ds_map_find_first(global.Update_list);
            }
        else
            {
            var update_id = ds_map_find_next(global.Update_list,update_id);
            }
        
        if (ds_map_find_value(global.Update_list,update_id) == argument0)
            {
            ds_map_delete(global.Update_list,update_id);
            break;
            }
        }
        
    for(var i=0; i<ds_map_size(global.Thumb_list); i++;)
        {
        if (i == 0)
            {
            var update_id = ds_map_find_first(global.Thumb_list);
            }
        else
            {
            var update_id = ds_map_find_next(global.Thumb_list,update_id);
            }
        
        if (ds_map_find_value(global.Thumb_list,update_id) == argument0)
            {
            ds_map_delete(global.Thumb_list,update_id);
            break;
            }
        }
    }
