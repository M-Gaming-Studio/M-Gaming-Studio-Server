<cftry>
    <cfquery datasource="mgamingDS" name="testQuery">
        SELECT 1
    </cfquery>
    <cfoutput>✅ Connexion réussie !</cfoutput>
    <cfcatch>
        <cfoutput>❌ Erreur : #cfcatch.message# — #cfcatch.detail#</cfoutput>
    </cfcatch>
</cftry>