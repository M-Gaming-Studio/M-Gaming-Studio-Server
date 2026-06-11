<cfdump var="#application#">
<cfdump var="#server.system.environment#">
<cfoutput>
    DB_HOST : #server.system.environment.DB_HOST ?: "non défini"#<br>
    DB_PORT : #server.system.environment.DB_PORT ?: "non défini"#<br>
    DB_NAME : #server.system.environment.DB_NAME ?: "non défini"#<br>
    DB_USER : #server.system.environment.DB_USER ?: "non défini"#<br>
</cfoutput>
