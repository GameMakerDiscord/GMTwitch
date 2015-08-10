/// twitch_init();

// initialize Twitch API stuff
global.Stream_list = ds_map_create();
global.Update_list = ds_map_create();
global.Thumb_list = ds_map_create();

// change these values depending on your program
global.Auto_update = true;
global.Update_time = room_speed * 15;
global.Twitch_logs = false;
