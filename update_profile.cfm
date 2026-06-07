<cfif structKeyExists(form, "action")>

    <cfif form.action eq "avatar" and structKeyExists(form, "avatarFile") and len(form.avatarFile)>
        
        <cffile action="upload" 
                fileField="avatarFile" 
                destination="#expandPath('./assets/avatars/')#" 
                nameConflict="makeunique">
        
        <cfset nouveauNomAvatar = cffile.serverFile>
        
        <cfquery>
            UPDATE users 
            SET avatar = <cfqueryparam value="#nouveauNomAvatar#" cfsqltype="cf_sql_varchar">
            WHERE id = <cfqueryparam value="#session.user_id#" cfsqltype="cf_sql_integer">
        </cfquery>
        
        <cfset session.avatar = nouveauNomAvatar>
        
        <cflocation url="profile.cfm?msg=1" addtoken="false">

    <cfelseif form.action eq "info">
        
        <cfset selectedLanguages = structKeyExists(form, "languages") ? form.languages : "">
        
        <cfquery>
            UPDATE users 
            SET username = <cfqueryparam value="#trim(form.username)#" cfsqltype="cf_sql_varchar">,
                email = <cfqueryparam value="#trim(form.email)#" cfsqltype="cf_sql_varchar">,
                languages = <cfqueryparam value="#selectedLanguages#" cfsqltype="cf_sql_varchar">,
                current_project = <cfqueryparam value="#trim(form.current_project)#" cfsqltype="cf_sql_varchar">
            WHERE id = <cfqueryparam value="#session.user_id#" cfsqltype="cf_sql_integer">
        </cfquery>
        
        <cfset session.username = trim(form.username)>
        <cflocation url="profile.cfm?msg=1" addtoken="false">

    <cfelseif form.action eq "password" and form.new_password eq form.confirm_password>
        
        <cfset hashedNewPassword = hash(form.new_password, "SHA-512", "UTF-8")>
        
        <cfquery>
            UPDATE users 
            SET password = <cfqueryparam value="#hashedNewPassword#" cfsqltype="cf_sql_varchar">
            WHERE id = <cfqueryparam value="#session.user_id#" cfsqltype="cf_sql_integer">
        </cfquery>
        
        <cflocation url="profile.cfm?msg=1" addtoken="false">

    <cfelseif form.action eq "add" AND len(trim(form.name))>
        <cfquery>
            INSERT INTO projects (name, status)
            VALUES (
                <cfqueryparam value="#trim(form.name)#" cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#form.status#" cfsqltype="cf_sql_varchar">
            )
        </cfquery>
        <cflocation url="projects.cfm" addtoken="false">
    
    <cfelseif form.action eq "delete" AND structKeyExists(form, "id")>
        <cfquery>
            DELETE FROM projects 
            WHERE id = <cfqueryparam value="#form.id#" cfsqltype="cf_sql_integer">
        </cfquery>
        <cflocation url="projects.cfm" addtoken="false">

    </cfif>

</cfif>