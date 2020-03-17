module mistwood.data.farm;

/++
 + The object that holds info about a farm
 +/
public struct Farm
{
    /++
     + The farms id (UUID)
     +/
    @name("ID")
    public string id;

    /++
     + The farms name
     +/
    @name("Name")
    public string name;

    /++
     + The farms owner (ID)
     +/
    @name("Owner")
    public string owner;

    /++
     + All the members (UUID) in the farm
     +/
    @name("Players")
    public string[] players; // TODO: ?
}