/// twitch_parse_data(data,id);

// this only gets used by the API, you don't use this

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
