module mistwood.data.file;

import std.stdio : File, readln;
import std.string : strip;
import vibe.d;

/++ 
 + Configuration Json object.
 +/
@property
public Json config() { return _config; }
private Json _config;

private const string dataPath = "data";

/++
 + Enum that defines all possible data files.
 +/
public enum DataFile
{
    CONFIG
}

static this()
{
    _config = parseJsonString(getTextDataFile(DataFile.CONFIG));
}

/++ 
 + Gets the data file. 
 + Params:
 +   dataFile = Type of data file.
 + Returns: File struct.
 +/
public File getDataFile(DataFile dataFile)
{
    final switch (dataFile)
    {
        case DataFile.CONFIG:
        {
            return File(getDataFilePath("config.json"), "r");
        }
    }
}

/++ 
 + Gets the data file as a string.
 + Params:
 +   dataFile = Type of data file.
 + Returns: String contents of the file.
 +/
public string getTextDataFile(DataFile dataFile)
{
    string res = "";

    File file = getDataFile(dataFile);

    while (!file.eof())
    {
        res ~= strip(file.readln());
    }

    return res;
}

/++ 
 + Gets the path to the data file inside the `dataPath` folder.
 + Params:
 +   filename = Name of the file (with the extension).
 + Returns: The path to the data file.
 +/
private string getDataFilePath(string filename)
{
    import std.file : getcwd;

    return getcwd() ~ "/" ~ dataPath ~ "/" ~ filename;
}