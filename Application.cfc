component {
    this.name = "mgaming_studio_app";
    this.sessionManagement = true;
    this.sessionTimeout = createTimeSpan(0, 0, 30, 0);

    this.datasources = {
        "mgamingDS" = {
            class: "com.mysql.cj.jdbc.Driver",
            url: "jdbc:mysql://mysql-3ef7cd90-debouchony-d171.g.aivencloud.com:27329/defaultdb?useSSL=true&allowPublicKeyRetrieval=true&serverTimezone=UTC",
            username: "avnadmin",
            password: "AVNS_KI24TONUicH7VdrCTOT"
        }
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
