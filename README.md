# GMTwitch

<b><span style="color:#00DD00;">MAJOR UPDATE:</span></b> Added the ability to chat using four new functions described at the bottom of this doc!

> What is GMTwitch?

GMTwitch is a lightweight, open source Twitch API wrapper/interface for Game Maker: Studio

> You say lightweight, how complicated is it?

This interface uses only **fifteen** scripts, all vanilla code withouth any extensions or included files.

> How do I use these scripts?

Getting stream details is easy as pie as soon as you understand the workflow. It's simply:

**Initialization -> Request Info -> Receive Info -> Utilize Info**

With the new version, you can even send and receive chat messages to any live stream!

Below, I'm going to initially go into detail on the process of how to get the details of any live stream using
GMTwitch in your own project. I'll even give you a quick code example. Then I'll quickly go over the chat functions.

Ready? **Let's go!**

___

**Initialization**

The first step is really only one line of code, usually in the create event of a controller object.
No arguments, parameters or requirements. No extensions to setup, no libraries or DLL's. Just one script.

```javascript
twitch_init();
```

All this does is initiallize some variables, and more importantly create the necessary data structures
to store information we will request later.

___

**Request Info**

Next we move on to the part where we ask Twitch for stream details. This only involves two scripts.
You can drop these scripts anywhere in your code, just note that putting them in the step event is not only
wasteful, but it will probably crash the game/cause unexpected errors. You only need to call each script once
for it to request the info. Of course you can put them on a timer or use the auto update script I'll cover later.

```javascript
twitch_stream_get_info( channel_id );
twitch_stream_get_thumbnail( channel_id, size );
```

> You'll notice both of these scripts require a single, shared parameter: *channel_id*
> This is simply the unique channel identification handle for the live stream to be hosted on. So, for example, say
> you are trying to find the details for a livestream being broadcasted at the URL: http://twitch.tv/xarrotstudios/
> To find the channel id, just take the string after the "twitch.tv/" part, not including the backslash following it
> For our example, the channel id would be *xarrotstudios*. Make sure it's represented as a string, and you're all set.

The first script makes an HTTP GET request to the exposed Twitch API, asking for the full details (JSON formatted)
for the channel id provided. This also sets up the data structure to store the payload we are waiting for.

The second script is a little trickier, but not much at all. The only requirement to use the second script is that
the first script *twitch_stream_get_info()* must have been called *and* the corresponding data received. You will
not get an error calling it before, it just doesn't do anything useful if the preceding script wasn't called.
Once you have got your info for the stream, and then you request the thumbnail properly, all it does is make a
new, separate request for a thumbnail in a specified size. You can fiddle with the sizes in that script, it's all
up to the user on what size thumbnail the server will respond with. That's it for the requests

___

**Receive Info**

This one is the easiest, but the most complex step at the same time. It's easy because it's a single, static script
that just gets plopped into the HTTP Async event. Set it and forget it. It's complex because the code inside the
script does some dirty stuff with strings and data structures to put up with errors and still keep things running.
Anyways, it just looks like this:

```javascript
twitch_async();
```

Done. Finished. Complete. Moving on!

___

**Utilize Info**

Arguably the hardest step of the whole process, only because we have a bunch of keys to throw at you, and they return
all sorts of different things. You'll find that it's actually a breeze to use once you take a look at the keys.
It's all packed into one tight script, so I thought this was the best way to keep the whole
motif of 'simple scripts, simple parameters' going smoothly. Here is the mentioned script:

```javascript
var info = twitch_stream_find_value( channel_id, key );
```

Again, you have your *channel_id* handle, but now we are using a key to indentify the data we want to retrieve. Also,
this is the first script we've covered that has a return value. Let's see if I can cover this stuff in an neat way.
The return value is the data you want that has already been picked up by the *twitch_async()* script. It was already
stored (if you did everything right, come on there's no way to screw this up) and now we are just using this
newly acquired tool to seamlessly extract the information. If the info has not made it to us yet, (for example
we forgot to request the info in the first place or there's heavy traffic and we experience a delay) the return value
will be a constant Game Maker recognizes as *undefined*. So, typically you would make sure to do a quick check before
you compare anything, by making sure it's not an undefined value. If we didn't have any delays and we remembered to
write our code to request the info in the first place, we did great! All of the stream's details are ready for us to
access. But how do we access those details? Keys! The following table will kindly explain what each key does and
what you should expect to be returned using each key:

| Key           | Returns       | Return Type  |
|:-------------:|:-------------:|:-----:|
| "status"      | online/offline | True/False |
| "name"        | stream's channel name | String |
| "game" | game the stream is broadcasting | String |
| "url"        | URL to watch stream | String |
| "viewers" | current viewer count | String |
| "views" | total viewer count | String |
| "followers" | total follower count | String |
| "thumb_url" | URL template for preview thumbnail | String |
| "thumb" | sprite handle of thumbnail | Real |

___

**Stream Details Example Code**

It's super easy to use, almost everything is done behind the scenes for you. Here's a small example, we will see if a stream is online and broadcasting. All we will do is initiallize, request, recieve, then utilize. Check it out:

```javascript
// Create Event
twitch_init();
twitch_stream_get_info("xarrotstudios");

// HTTP Async Event
twitch_async();

// Draw Event
if (twitch_stream_find_value("xarrotstudios","status"))
    draw_text(12,12,"Xarrot Studios is ONLINE!");
else
    draw_text(12,12,"Xarrot Studios is OFFLINE!");
```

Just **seven**, easily digestable lines of code, and you can almost immediately show if the channel is live. No dealing with crazy, messy webs of handles, bloated code or extensions. It's just the bare minimum and I think you'll agree it's all you'll ever need.

___

**Twitch Chat Functions**

*credit goes to [u/Aidan63](https://www.reddit.com/user/Aidan63) for providing a foundation to these new scripts*

You can now send and receive chat messages from any Twitch stream using the four new functions added in the latest update:

```javascript
// connects to a Twitch IRC chat channel
twitch_chat_connect( channel_id, username, oauth);

// receives data in the Networking Async event
twitch_chat_async();

// allows you to send a string as a chat message
twitch_chat_say( string );

// disconnects from a connected chat channel
twitch_chat_disconnect();
```

Using these functions are covered in the source of the example, and they are very self explanitory, so I won't go
through any examples or get into details with these. All chat messages are stored in a single list, even the chat
messages you send yourself. That's pretty much the gist of it. What I will go on to say is that to connect
to a Twitch IRC channel, you must have *two previously created resources* that can't be created
through the scope of my scripts. The first is a **valid Twitch user account**. That's the simple part.
The second half, involves getting an **Oauth token** for the Twitch user account you will be connecting
to the chat with. You can get a working Oauth token here: http://www.twitchapps.com/tmi/

One thing to note: sending more than [20 messages to a stranger's chat] or [100 messages to your own stream's chat]
will **ban you for 8 hours from all Twitch IRC activity**. So be careful when testing these new chat scripts. *There is
no getting around the ban*, and you will have to wait eight more hours to test again. Test wisely!

You just saw the entirety of the new chat functions! Easy and simple!

___

**Wrapping Up The Wrapper**

That's it! Those are the core functions used to wrap up the API nice and neat for you guys. Use it, abuse it, fork it,
spoon it. I don't care. No credit required. Just don't claim this as your own! Now, before you leave, I'll
list the last of the scripts and give a brief description of each:

```javascript
// Place in the step event to auto update all active channel info on a timer
twitch_auto_update();

// Place anywhere to manually update all active channel information
twitch_update();

// Removes an active channel; you will not be able to use the data from this channel until requesting it again
twitch_remove( channel_id );

// Free the data structures and sprites used by this API, call when you want to stop using it
twitch_free();

// Used internally. You will probably never use this script, up until the heat death of the universe.
twitch_parse();
```

___

Have fun with it guys!
