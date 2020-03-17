import vibe.d;

public void main()
{
    import mistwood.db : connect;
    import mistwood.rest : FarmingAPI;

    URLRouter router = new URLRouter();
    router.registerRestInterface(new FarmingAPI());

    HTTPServerSettings serverSettings = new HTTPServerSettings();
    serverSettings.bindAddresses = ["127.0.0.1"];
    serverSettings.port = 5000;

    listenHTTP(serverSettings, router);

    connect();

    runApplication();
}