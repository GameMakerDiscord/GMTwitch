/// twitch_parse_data(data);
// twitch_parse_data(data,id);

// this only gets used by the API, you don't use this

var data = string_replace(argument0," ","");
var data = string_replace(data,string(chr(13) + chr(10)),"");

//var info_map = ds_map_create();
var json_map = json_decode(data);
if (json_map > -1)
    {
    if (ds_exists(json_map,ds_type_map))
        {
        list = ds_map_find_value(json_map,"default");
        if (ds_exists(list,ds_type_list))
            {
            for(var i=0; i<ds_list_size(list); i++;)
                {
                var map = ds_list_find_value(list,i);
                for(var j=0; j<ds_map_size(map); j++;)
                    {
                    if (j == 0)
                        var key = ds_map_find_first(map);
                    else
                        var key = ds_map_find_next(map,key);
                    
                    var val = ds_map_find_value(map,key);
                    twitch_log("["+string(key)+"] "+string(val));
                    }
                }
            }
        else
            {
            for(var i=0; i<ds_map_size(json_map); i++;)
                {
                if (i == 0)
                    var key = ds_map_find_first(json_map);
                else
                    var key = ds_map_find_next(json_map,key);
                
                var val = ds_map_find_value(json_map,key);
                twitch_log("["+string(key)+"] "+string(val));
                }
            }
        }
    }
else
    twitch_log("Error decoding JSON!");

/*
for(var i=0; i<ds_map_size(info_map); i++;)
    {
    if (i == 0)
        var key = ds_map_find_first(info_map);
    else
        var key = ds_map_find_next(info_map,key);
    
    var val = ds_map_find_value(info_map,key);
    twitch_log("["+string(key)+"] "+string(val));
    }
*/

//ds_map_destroy(info_map);
ds_map_destroy(json_map);
/*
var data = argument0;
var iden = argument1;

var q = chr(34);
var len = string_length(argument0);
var pos = string_pos(string(q)+string(argument1)+string(q),argument0);
while((string_char_at(data,pos) != ":"))
    {
    pos++;
    if (pos > len-1)
        return("");
    }

pos++;

var str = "";
while((string_char_at(data,pos) != ","))
    {
    str = string(str) + string(string_char_at(data,pos));
    pos++;
    
    if (pos > len-1)
        return("");
    }

str = string_replace_all(str," ","");
str = string_replace_all(str,string(chr(34)),"");

for(var i=0; i<=2; i++;)
    {
    var len = string_length(str);
    if (string_char_at(str,len-i) == "}")
        {
        str = string_copy(str,0,len-(i+1));
        }
    }

return(str);

*/
