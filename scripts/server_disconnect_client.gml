/// server_disconnect_client(usr_id);

var kick_inst = ds_map_find_value(client_id_map,argument0);
if (kick_inst != undefined)
    {
    for(var i=0; i<ds_list_size(client_list); i++;)
        {
        var send_inst = ds_list_find_value(client_list,i);
        if (send_inst != undefined)
            {
            var buff = server_queue_buffer(8,1,send_inst.ip,send_inst.port);
            buffer_write(buff,buffer_u8,255);
            buffer_write(buff,buffer_s8,2);
            buffer_write(buff,buffer_u8,0);
            buffer_write(buff,buffer_u8,kick_inst.usr_id);
            }
        }
    
    ds_map_delete(client_ip_map,string(kick_inst.ip)+":"+string(kick_inst.port));
    ds_map_delete(client_id_map,argument0);
    ds_list_delete(client_list,ds_list_find_index(client_list,kick_inst));
    with(kick_inst)
        instance_destroy();
    
    clients--;
    }