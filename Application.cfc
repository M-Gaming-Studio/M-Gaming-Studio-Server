component {
    // Parameters

    this.datasources["mgamingDS"] = {
        class: "com.mysql.cj.jdbc.Driver",
        bundleName: "com.mysql.cj",
        connectionString: "jdbc:mysql://127.0.0.1:3306/mgaming_studio?useSSL=false&allowPublicKeyRetrieval=true",
        username: "root",
        password: ""
    }

    // Configure database

    this.datasource = "mgamingDS";

    // Session begin

    public void function onSessionStart() {

        // User not connected

        session.isLoggedIn = false;
        session.user_id = 0;
        session.username = "";
    }

    // For all pages

    public boolean function onRequestStart(required string targetPage) {

        // Exact name

        local.pageName = getFileFromPath(arguments.targetPage);

        // Pages list

        local.allowedPages = [
            "login.cfm",
            "inscription.cfm",
            "save_user.cfm",
            "privacy.cfm"
        ];

        // Security rules

        // If usernot connected

        if (session.isLoggedIn == false && !arrayFindNoCase(local.allowedPages, local.pageName)) {

            // Got to login page

            location(url = "login.cfm", addtoken = false);
        }

        return true;
    }
}