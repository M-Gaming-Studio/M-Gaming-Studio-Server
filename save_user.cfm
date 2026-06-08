<cfif not structKeyExists(form, "username") or not structKeyExists(form, "email") or not structKeyExists(form, "password")>
    <cflocation url="inscription.cfm?error=Formulaire invalide" addToken="false">
</cfif>

<cftry>
    <cfset mongoDB = MongoRegister("ma_connexion_mongo")>
    <cfset usersCollection = mongoDB.getCollection("users")>
    
    <cfset searchFilter = {
        "$or": [
            { "username": form.username },
            { "email": form.email }
        ]
    }>
    
    <cfset checkUser = usersCollection.findOne(searchFilter)>
    
    <cfif not isNull(checkUser)>
        <cflocation url="inscription.cfm?error=Le nom d'utilisateur ou l'email est déjà utilisé" addToken="false">
    </cfif>

    <cfset hashedPassword = hash(form.password, "SHA-512", "UTF-8")>

    <cfset newUser = {
        "username": form.username,
        "email": form.email,
        "password": hashedPassword,
        "created_at": now()
    }>
    
    <cfset usersCollection.insertOne(newUser)>

    <cflocation url="login.cfm?success=Compte créé avec succès ! Connectez-vous." addToken="false">

    <cfcatch type="any">
        <cflocation url="inscription.cfm?error=Erreur de base de données : #urlEncodedFormat(cfcatch.message)#" addToken="false">
    </cfcatch>
</cftry>
