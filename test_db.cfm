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

<cfoutput>
    <br><br>
    Driver : com.mysql.cj.jdbc.Driver<br>
    URL : jdbc:mysql://mysql-3ef7cd90-debouchony-d171.g.aivencloud.com:27329/defaultdb<br>
    <cfdump var="#application#">
</cfoutput>
