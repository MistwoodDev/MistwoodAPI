import vibe.d;

public void main()
{
    import mistwood.db : connect;
    import mistwood.rest : FarmingAPI;
    import mistwood.data.file : config;

    URLRouter router = new URLRouter();
    router.registerRestInterface(new FarmingAPI());

    HTTPServerSettings serverSettings = new HTTPServerSettings();
    serverSettings.bindAddresses = [config["server"]["host"].to!string];
    serverSettings.port = config["server"]["port"].to!ushort;

    listenHTTP(serverSettings, router);

    connect();

    runApplication();
}