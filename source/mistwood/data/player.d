module mistwood.data.player;

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
    public string name;

    /++
     + The farm (UUID) the player is currently a member of
     +/
    @name("Farm")
    public string farm;

    /++
     + The permission level the player has in the farm
     +/
    @name("FarmPermission")
    public string farmPermission;
}