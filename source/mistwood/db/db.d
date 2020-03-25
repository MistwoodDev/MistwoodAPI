module mistwood.db.db;

import vibe.d;
import std.typecons;
import mistwood.data.file : config;
import std.conv;

/++
 + List of all the collections in the database
 +/
public const string[] collectionNames = ["players", "farms", "tokens", "auth-keys"];

private MongoDatabase mongo;

/++
 + Connects to the database.
 +/
public void connect()
{
    connectMongo(
        config["db"]["host"].to!string,
        config["db"]["port"].to!ushort,
        config["db"]["username"].to!string,
        config["db"]["password"].to!string,
        config["db"]["database"].to!string
    );
}

private void connectMongo(string host, ushort port, string username, string password, string dbName)
{
    MongoClientSettings settings = new MongoClientSettings;
    settings.username = username;
    settings.digest = MongoClientSettings.makeDigest(username, password);
    settings.database = dbName;
    settings.hosts = [MongoHost(host, port)];
    mongo = connectMongoDB(settings).getDatabase(dbName);
}

/++
 + Gets the proper collection name to use from a type.
 +/
private string getCollectionName(T)() @safe
{
    import mistwood.data : Farm, Player, Token, AuthKey;

    static if (is(T == Farm))
    {
        return "farms";
    }

    else static if (is(T == Player))
    {
        return "players";
    }

    else static if (is(T == Token))
    {
        return "tokens";
    }

    else static if (is(T == AuthKey))
    {
        return "auth-keys";
    }

    else
    {
        static assert(false, "Cannot get collection name from type " ~ T.stringof);
    }
}

/++
 + Inserts an item into the Mongo DB.
 +
 + The collection is automatically determined from the item type. It will throw an error if you try to insert an invalid type.
 +/
public void insert(T)(T item)
{
    MongoCollection collection = mongo[getCollectionName!T()];

    Json data;
    data = serializeToJson(item);

    collection.insert(data);
}

/++
 + Removes one item from the DB, using the specified query
 +/
public void removeOne(R, T)(T query) @safe
{
    MongoCollection collection = mongo[getCollectionName!R()];
    collection.remove(query);
}

/++
 + Get the count of objects in the collection
 +/
public ulong getCollectionCount(T)()
{
    MongoCollection collection = mongo[getCollectionName!T()];

    return collection.find().count();
}

/++ 
 +
 + Gets one item from the Mongo DB.
 +
 + The collection is automatically determined from the item type. It will throw an error if you try to insert an invalid type.
 +/
public Nullable!R findOne(R, T)(T query) @safe
{
    MongoCollection collection = mongo[getCollectionName!R()];

    return collection.findOne!R(query);
}

/++ 
 +
 + Gets one item from the Mongo DB with the specified id.
 +
 + The collection is automatically determined from the item type. It will throw an error if you try to insert an invalid type.
 +/
public Nullable!R findOneById(R, T)(T id) @safe
{
    return findOne!R(["ID": id]);
}

/++ 
 +
 + Gets one item from the Mongo DB with the specified name.
 +
 + The collection is automatically determined from the item type. It will throw an error if you try to insert an invalid type.
 +/
public Nullable!R findOneByName(R, T)(T name) @safe
{
    return findOne!R(["Name": name]);
}
