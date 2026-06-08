component {
    // Paramètres généraux de l'application
    this.name = "mgaming_studio_app";
    this.sessionManagement = true; // Indispensable pour que vos variables "session.isLoggedIn" fonctionnent !
    this.sessionTimeout = createTimeSpan(0, 0, 30, 0); // Session de 30 minutes

    // Configuration de la source de données MongoDB Atlas
    this.datasources["mgamingDS"] = {
        class: "lucee.extension.io.mongodb.MongoDBDataSource", // Classe corrigée pour le driver Lucee
        bundleName: "lucee.extension.io.mongodb",
        bundleVersion: "3.5.0", // Optionnel mais recommandé pour figer la version stable
        // REMPLACEZ impérativement <db_password> par votre vrai mot de passe (sans les < >)
        connectionString: "mongodb+srv://mgaming_studio:mgamingstudio_db@datacluster.jyh70tq.mongodb.net/mgamingstudio_db?appName=DataCluster"
    };

    // Définir MongoDB comme base par défaut pour toute l'application
    this.datasource = "mgamingDS";

    // Début de session
    public void function onSessionStart() {
        // Utilisateur non connecté par défaut
        session.isLoggedIn = false;
        session.user_id = ""; // MongoDB utilise des chaînes de caractères (String) pour ses identifiants (_id)
        session.username = "";
    }

    // Sécurité pour toutes les pages
    public boolean function onRequestStart(required string targetPage) {

        // Nom exact de la page demandée
        local.pageName = getFileFromPath(arguments.targetPage);

        // Liste des pages publiques accessibles sans connexion
        local.allowedPages = [
            "login.cfm",
            "inscription.cfm",
            "save_user.cfm",
            "privacy.cfm"
        ];

        // Règle de sécurité : si l'utilisateur n'est pas connecté et demande une page protégée
        if (session.isLoggedIn == false && !arrayFindNoCase(local.allowedPages, local.pageName)) {
            // Redirection vers la page de connexion (syntaxe compatible native cflocation)
            cflocation(url = "login.cfm", addtoken = false);
        }

        return true;
    }
}
