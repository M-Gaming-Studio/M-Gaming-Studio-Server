<cfif not structKeyExists(form, "username") or not structKeyExists(form, "email") or not structKeyExists(form, "password")>
    <cflocation url="inscription.cfm?error=Formulaire invalide" addToken="false">
</cfif>

<cfquery name="checkUser">
    SELECT id FROM users 
    WHERE username = <cfqueryparam value="#form.username#" cfsqltype="cf_sql_varchar">
       OR email = <cfqueryparam value="#form.email#" cfsqltype="cf_sql_varchar">
</cfquery>

<cfif checkUser.recordCount gt 0>
    <cflocation url="inscription.cfm?error=Le nom d'utilisateur ou l'email est déjà utilisé" addToken="false">
</cfif>

<cfset hashedPassword = hash(form.password, "SHA-512", "UTF-8")>

<cfquery name="insertUser">
    INSERT INTO users (username, email, password)
    VALUES (
        <cfqueryparam value="#form.username#" cfsqltype="cf_sql_varchar">,
        <cfqueryparam value="#form.email#" cfsqltype="cf_sql_varchar">,
        <cfqueryparam value="#hashedPassword#" cfsqltype="cf_sql_varchar">
    )
</cfquery>

<cflocation url="login.cfm?success=Compte créé avec succès ! Connectez-vous." addToken="false">