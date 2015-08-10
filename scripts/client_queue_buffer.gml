/// client_queue_buffer(size,priority);

var buff_new = buffer_create(argument0,buffer_fixed,1);
buffer_seek(buff_new,buffer_seek_start,0);

ds_priority_add(buff_queue,buff_new,argument1);
return(buff_new);