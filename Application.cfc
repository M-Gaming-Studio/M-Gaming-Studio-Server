component {
    this.name = "mgaming_studio_app";
    this.sessionManagement = true;
    this.sessionTimeout = createTimeSpan(0, 0, 30, 0);

    this.datasources["mgamingDS"] = {
        type: "mysql",
        host: "mysql-3ef7cd90-debouchony-d171.g.aivencloud.com",
        port: 27329,
        database: "defaultdb",
        username: "avnadmin",
        password: "AVNS_KI24TONUicH7VdrCTOT",
        connectionLimit: 10,
        blob: false,
        clob: false,
        connectionTimeout: 1,
        timezone: "UTC",
        custom: "useSSL=true&allowPublicKeyRetrieval=true"
    };

    this.datasource = "mgamingDS";

    public void function onSessionStart() {
        session.isLoggedIn = false;
        session.user_id = "";
        session.username = "";
    }

    public boolean function onRequestStart(required string targetPage) {
        local.pageName = getFileFromPath(arguments.targetPage);
        local.allowedPages = ["login.cfm", "inscription.cfm", "save_user.cfm", "privacy.cfm", "test_db.cfm"];
        if (session.isLoggedIn == false && !arrayFindNoCase(local.allowedPages, local.pageName)) {
            cflocation(url = "login.cfm", addtoken = false);
        }
        return true;
    }
}
