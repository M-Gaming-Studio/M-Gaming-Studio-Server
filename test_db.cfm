<cftry>
    <cfquery name="testQuery" datasource="mgamingDS">
        SELECT 1
    </cfquery>
    <cfoutput>✅ Connexion réussie !</cfoutput>
    <cfcatch type="any">
        <cfoutput>
            ❌ Erreur : #cfcatch.message#<br>
            Détail : #cfcatch.detail#<br>
            Type : #cfcatch.type#
        </cfoutput>
    </cfcatch>
</cftry>
