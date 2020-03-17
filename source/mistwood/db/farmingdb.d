module mistwood.db.farmingdb;

import std.file;
import std.json;

import vibe.d;

/++
 + List of all the collections in the database
 +/
public const string[] collectionNames = ["players", "farms"];

private const JSONValue config = parseJSON(read("config.json"));
private MongoDatabase mongo;

/++
 + Connects to the database.
 +/
public void connect()
{
    connectMongo();
}

private void connectMongo(string host, string dbName)
{
    mongo = connectMongoDB();
}

/++
 + Gets the proper collection name to use from a type.
 +/
private string getCollectionName(T)() @safe
{
    import mistwood.data : Farm, Player;

    if (is(T == Farm))
    {
        return "farms";
    }

    else if (is(T == Player))
    {
        return "players";
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
// unused so far
public void insert(T)(T item) { }

/++
 + Removes one item from the DB, using the specified query
 +/
// unused so far
public void removeOne(R, T)(T query) @safe { }

/++
 + Removes an existing object, with the specified id
 +/
// unused so far
public void removeOneById(R, T)(T id) @safe { }

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
    return findOne!R(["ID", id]);
}

/++ 
 +
 + Gets one item from the Mongo DB with the specified name.
 +
 + The collection is automatically determined from the item type. It will throw an error if you try to insert an invalid type.
 +/
public Nullable!R findOneByName(R, T)(T name) @safe
{
    return findOne!R(["Name", name]);
}
