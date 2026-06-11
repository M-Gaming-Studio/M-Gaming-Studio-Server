<cfif not structKeyExists(form, "username") or not structKeyExists(form, "email") or not structKeyExists(form, "password")>
    <cflocation url="inscription.cfm?error=Formulaire invalide" addToken="false">
</cfif>

<cftry>
    <!--- Vérifier si l'utilisateur ou l'email existe déjà --->
    <cfquery name="checkUser" datasource="mgamingDS">
        SELECT id FROM users
        WHERE username = <cfqueryparam value="#form.username#" cfsqltype="cf_sql_varchar">
        OR email = <cfqueryparam value="#form.email#" cfsqltype="cf_sql_varchar">
    </cfquery>

    <cfif checkUser.recordCount gt 0>
        <cflocation url="inscription.cfm?error=Le nom d'utilisateur ou l'email est déjà utilisé" addToken="false">
    </cfif>

    <!--- Hasher le mot de passe --->
    <cfset hashedPassword = hash(form.password, "SHA-512", "UTF-8")>

    <!--- Insérer le nouvel utilisateur --->
    <cfquery datasource="mgamingDS">
        INSERT INTO users (username, email, password, created_at)
        VALUES (
            <cfqueryparam value="#form.username#" cfsqltype="cf_sql_varchar">,
            <cfqueryparam value="#form.email#" cfsqltype="cf_sql_varchar">,
            <cfqueryparam value="#hashedPassword#" cfsqltype="cf_sql_varchar">,
            <cfqueryparam value="#now()#" cfsqltype="cf_sql_timestamp">
        )
    </cfquery>

    <cflocation url="login.cfm?success=Compte créé avec succès ! Connectez-vous." addToken="false">

    <cfcatch type="any">
        <cflocation url="inscription.cfm?error=Erreur de base de données : #urlEncodedFormat(cfcatch.message)#" addToken="false">
    </cfcatch>
</cftry>
