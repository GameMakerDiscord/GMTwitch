/// server_queue_buffer(size,priority,ip,port);

var priority = argument1;
var buff_new = buffer_create(argument0,buffer_fixed,1);
buffer_seek(buff_new,buffer_seek_start,0);

var client = ds_map_find_value(client_ip_map,string(argument2)+":"+string(argument3));
if (instance_exists(client))
    {
    with(client)
        ds_priority_add(buff_queue,buff_new,priority);
    }

return(buff_new);