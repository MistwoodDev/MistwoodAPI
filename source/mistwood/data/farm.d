module mistwood.data.farm;

import vibe.data.json;
import vibe.data.bson;
import vibe.data.serialization;

/++
 + The object that holds info about a farm
 +/
public struct Farm
{
    /++
     + The farms id (UUID)
     +/
    @name ("ID")
    public string id;

    /++
     + The farms name
     +/
    @name("Name")
    public string farmName;

    /++
     + The farms owner (ID)
     +/
    @name("Owner")
    public string owner;

    /++
     + All the members (UUID) in the farm
     +/
    @name("Players")
    public string[] players;

    /++
     + Info about the farm region
     +/
    @name("Info")
    public string info;

    /++
     + The date the farm was created
     +/
    @name("Date")
    public string date;
}