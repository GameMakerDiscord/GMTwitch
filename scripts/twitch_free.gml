/// twitch_free();

// call this to free EVERYTHING from memory

for(var i=0; i<ds_map_size(global.Stream_list); i++;)
    {
    if (i == 0)
        var channel_id = ds_map_find_first(global.Stream_list);
    else
        var channel_id = ds_map_find_next(global.Stream_list,channel_id);
    
    if (channel_id != undefined)
        {
        var channel_info = ds_map_find_value(global.Stream_list,channel_id);
        
        var spr = ds_map_find_value(channel_info,"thumb");
        if (spr != undefined)
            {
            if (sprite_exists(spr))
                sprite_delete(spr);
            }
        
        ds_map_destroy(channel_info);
        }
    }

ds_map_destroy(global.Update_list);
ds_map_destroy(global.Thumb_list);
