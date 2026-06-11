component {
    this.name = "mgaming_studio_app";
    this.sessionManagement = true;
    this.sessionTimeout = createTimeSpan(0, 0, 30, 0);

    local.dbHost = server.system.environment.DB_HOST ?: "mysql://avnadmin:AVNS_KI24TONUicH7VdrCTOT@mysql-3ef7cd90-debouchony-d171.g.aivencloud.com:27329/defaultdb?ssl-mode=REQUIRED";
    local.dbPort = server.system.environment.DB_PORT ?: "27329";
    local.dbName = server.system.environment.DB_NAME ?: "defaultdb";
    local.dbUser = server.system.environment.DB_USER ?: "avnadmin";
    local.dbPass = server.system.environment.DB_PASS ?: "AVNS_KI24TONUicH7VdrCTOT";

    this.datasources["mgamingDS"] = {
        class: "com.mysql.cj.jdbc.Driver",
        url: "jdbc:mysql://#local.dbHost#:#local.dbPort#/#local.dbName#?useSSL=true&allowPublicKeyRetrieval=true&serverTimezone=UTC",
        username: local.dbUser,
        password: local.dbPass
    };

    this.datasource = "mgamingDS";

    public void function onSessionStart() {
        session.isLoggedIn = false;
        session.user_id = "";
        session.username = "";
    }

    public boolean function onRequestStart(required string targetPage) {
        local.pageName = getFileFromPath(arguments.targetPage);
        local.allowedPages = ["login.cfm", "inscription.cfm", "save_user.cfm", "privacy.cfm"];
        if (session.isLoggedIn == false && !arrayFindNoCase(local.allowedPages, local.pageName)) {
            cflocation(url = "login.cfm", addtoken = false);
        }
        return true;
    }
}
