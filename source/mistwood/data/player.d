module mistwood.data.player;

import vibe.data.json;
import vibe.data.bson;
import vibe.data.serialization;

/++
 + The object that holds info about a player
 +/
public struct Player
{
    /++
     + The players id (UUID)
     +/
    @name("ID")
    public string id;

    /++
     + The players name
     +/
    @name("Name")
    public string playerName;

    /++
     + The farm (UUID) the player is currently a member of
     +/
    @name("FarmID")
    public string farm;

    /++
     + The name of the farm the player is currently a member of
     +/
    @name("FarmName")
    public string farmName;

    /++
     + The permission level the player has in the farm
     +/
    @name("FarmPermission")
    public string farmPermission;
}