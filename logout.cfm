<cfset structClear(session)>

<cfset session.isLoggedIn = false>
<cfset session.user_id = 0>
<cfset session.username = "">

<cflocation url="login.cfm?success=Vous avez été déconnecté avec succès." addToken="false">