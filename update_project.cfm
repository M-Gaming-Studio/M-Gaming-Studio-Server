<cfif structKeyExists(form, "action")>
    
    <cfif form.action eq "add" AND len(trim(form.name))>
        <cfquery>
            INSERT INTO projects (name, status)
            VALUES (
                <cfqueryparam value="#trim(form.name)#" cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#form.status#" cfsqltype="cf_sql_varchar">
            )
        </cfquery>
    
    <cfelseif form.action eq "delete" AND structKeyExists(form, "id")>
        <cfquery>
            DELETE FROM projects 
            WHERE id = <cfqueryparam value="#form.id#" cfsqltype="cf_sql_integer">
        </cfquery>
    </cfif>

</cfif>

<cflocation url="projects.cfm" addtoken="false">