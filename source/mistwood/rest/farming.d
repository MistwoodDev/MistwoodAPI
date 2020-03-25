module mistwood.rest.farming;

import mistwood.data;
import vibe.d;

/++
 + API interface for the `/api/vX/farming` endpoint.
 +/
@path("/api/v" ~ apiVersion ~ "/farming")
public interface IFarmingAPI
{
    /++
     + GET /players/:playerName
     +
     + Gets a player
     +/
    @path("/players/:playerName")
    @method(HTTPMethod.GET)
    Json getPlayer(string _playerName) @safe;

    /++
     + GET /farms/:farmName
     +
     + Gets a farm
     +/
    @path("/farms/:farmName")
    @method(HTTPMethod.GET)
    Json getFarm(string _farmName) @safe;

    /++
     + GET /farms/:farmName/members
     +
     + Gets all the members in the farm
     +/
    @path("/farms/:farmName/members")
    @method(HTTPMethod.GET)
    Json getFarmPlayers(string _farmName) @safe;

    /++
     + GET /farms/:farmName/members/:playerName
     +
     + Gets a specific member from the farm
     +/
    @path("/farms/:farmName/members/:playerName")
    @method(HTTPMethod.GET)
    Json getFarmPlayer(string _farmName, string _playerName) @safe;
}

/++
 + API for the `/api/vX/farming` endpoint.
 +/
public class FarmingAPI : IFarmingAPI
{
    /++
     + GET /players/:playerName
     +
     + Gets a player
     +/
    public Json getPlayer(string _playerName) @safe
    {
        import mistwood.db : findOneByName;

        auto res = findOneByName!Player(_playerName);

        enforceHTTP(!res.isNull, HTTPStatus.notFound, "Could not find player with name: " ~ _playerName);

        return serializeToJson(res.get());
    }

    /++
     + GET /farms/:farmName
     +
     + Gets a farm
     +/
    public Json getFarm(string _farmName) @safe
    {
        import mistwood.db : findOneByName;

        auto res = findOneByName!Farm(_farmName);

        enforceHTTP(!res.isNull, HTTPStatus.notFound, "Could not find farm with name: " ~ _farmName);

        return serializeToJson(res.get());
    }

    /++
     + GET /farms/:farmName/members
     +
     + Gets all the members in the farm
     +/
    public Json getFarmPlayers(string _farmName) @safe
    {
        import mistwood.db : findOneByName;

        auto res = findOneByName!Farm(_farmName);

        enforceHTTP(!res.isNull, HTTPStatus.notFound, "Could not find farm with name: " ~ _farmName);

        return serializeToJson(res.get().players);
    }

    /++
     + GET /farms/:farmName/members/:playerName
     +
     + Gets a specific member from the farm
     +/
    public Json getFarmPlayer(string _farmName, string _playerName) @safe
    {
        import mistwood.db : findOneByName, findOneById;

        auto res = findOneByName!Farm(_farmName);

        enforceHTTP(!res.isNull, HTTPStatus.notFound, "Could not find farm with name: " ~ _farmName);

        foreach (player; res.get().players)
        {
            auto playerObj = findOneById!Player(player);
            if (!playerObj.isNull)
            {
                if (playerObj.get().playerName == _playerName)
                {
                    return serializeToJson(playerObj.get());
                }
            }
        }

        enforceHTTP(false, HTTPStatus.notFound, "Could not find player with name: " ~ _playerName);
        return serializeToJson(["ERROR": "404 - NOT FOUND"]);
    }
}