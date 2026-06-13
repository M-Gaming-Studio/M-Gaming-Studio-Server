<cfquery name="qUser">
    SELECT username, email, avatar, languages, current_project 
    FROM users 
    WHERE id = <cfqueryparam value="#session.user_id#" cfsqltype="cf_sql_integer">
</cfquery>

<!DOCTYPE html>
<html lang="fr" class="bg-slate-950 text-slate-100">
<head>
    <meta charset="UTF-8">
    <title>Paramètres Profil - M-Gaming-Studio Server</title>
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <cfinclude template="analytics.cfm">
</head>
<body class="min-h-screen antialiased bg-slate-950 text-slate-100">

    <cfinclude template="menu_toggle.cfm">

    <main class="max-w-6xl mx-auto px-6 py-10">
        
        <div class="mb-10 flex items-center justify-between">
            <div>
                <h2 class="text-3xl font-black tracking-tighter uppercase italic text-slate-100">Configuration du <span class="text-cyan-500">Compte</span></h2>
                <p class="text-slate-400 text-sm mt-1">Personnalisez votre identity et sécurisez vos accès.</p>
            </div>
            <cfif structKeyExists(url, "msg")>
                <div class="bg-emerald-500/10 border border-emerald-500/20 text-emerald-400 text-xs font-bold px-4 py-2 rounded-lg animate-bounce">
                    <i class="fa-solid fa-circle-check mr-2"></i> Modification enregistrée !
                </div>
            </cfif>
        </div>

        <div class="grid grid-cols-1 lg:grid-cols-12 gap-8">
            
            <div class="lg:col-span-4 space-y-6">
                <form action="update_profile.cfm" method="POST" enctype="multipart/form-data" class="bg-slate-900 border border-slate-800 rounded-2xl p-8 text-center shadow-2xl">
                    <input type="hidden" name="action" value="avatar">
                    <div class="relative w-32 h-32 mx-auto mb-6">
                        
                        <cfif structKeyExists(session, "avatar") AND len(session.avatar)>
                            <img src="./assets/avatars/<cfoutput>#session.avatar#</cfoutput>" class="w-full h-full object-cover rounded-full border-4 border-slate-800 shadow-xl">
                        <cfelse>
                            <div class="w-full h-full bg-slate-800 rounded-full flex items-center justify-center border-4 border-slate-700">
                                <i class="fa-solid fa-user-gear text-4xl text-slate-600"></i>
                            </div>
                        </cfif>
                        
                        <label for="avatarFile" class="absolute bottom-0 right-0 bg-cyan-500 hover:bg-cyan-400 text-slate-950 w-10 h-10 rounded-full flex items-center justify-center cursor-pointer border-4 border-slate-900 transition-all">
                            <i class="fa-solid fa-camera text-sm"></i>
                        </label>
                        <input type="file" id="avatarFile" name="avatarFile" class="hidden" onchange="this.form.submit()">
                    </div>
                    <h3 class="text-lg font-bold text-slate-100"><cfoutput>#qUser.username#</cfoutput></h3>
                    <p class="text-[10px] text-slate-500 uppercase tracking-widest mt-1">Administrateur Serveur</p>
                    <p class="text-[11px] text-slate-400 mt-4 italic">Cliquez sur l'icône photo pour changer votre image de profil.</p>
                </form>
            </div>

            <div class="lg:col-span-8 space-y-8">
                
                <div class="bg-slate-900 border border-slate-800 rounded-2xl shadow-xl overflow-hidden">
                    <div class="px-6 py-4 bg-slate-800/30 border-b border-slate-800">
                        <h4 class="text-xs font-black uppercase tracking-widest text-cyan-400 flex items-center gap-2">
                            <i class="fa-solid fa-id-card"></i> Identité & Expérience du compte
                        </h4>
                    </div>
                    
                    <form action="update_profile.cfm" method="POST" class="p-6 space-y-6">
                        <input type="hidden" name="action" value="info">
                        
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                            <div>
                                <label class="block text-[10px] font-bold text-slate-500 uppercase mb-2">Nom d'utilisateur</label>
                                <input type="text" name="username" value="<cfoutput>#qUser.username#</cfoutput>" class="w-full bg-slate-950 border border-slate-800 rounded-lg px-4 py-2.5 text-slate-200 focus:border-cyan-500 outline-none transition-all">
                            </div>
                            <div>
                                <label class="block text-[10px] font-bold text-slate-500 uppercase mb-2">Adresse Email</label>
                                <input type="email" name="email" value="<cfoutput>#qUser.email#</cfoutput>" class="w-full bg-slate-950 border border-slate-800 rounded-lg px-4 py-2.5 text-slate-200 focus:border-cyan-500 outline-none transition-all">
                            </div>
                        </div>

                        <div class="space-y-2">
                            <label class="block text-[10px] font-bold text-slate-500 uppercase">Quels langages de programmation connaissez-vous ?</label>
                            <div class="grid grid-cols-2 sm:grid-cols-3 gap-3 bg-slate-950 p-4 border border-slate-800 rounded-lg">
                                <cfset local.languagesList = ["ColdFusion/Lucee", "JavaScript", "HTML/CSS", "SQL", "Python", "PHP"]>
                                <cfloop array="#local.languagesList#" index="local.lang">
                                    <label class="flex items-center gap-3 cursor-pointer select-none text-xs text-slate-300 hover:text-slate-100">
                                        <input type="checkbox" name="languages" value="#local.lang#"
                                               <cfif len(qUser.languages) AND listFindNoCase(qUser.languages, local.lang)>checked</cfif>
                                               class="w-4 h-4 bg-slate-900 border-slate-800 rounded text-cyan-500 focus:ring-cyan-500/50 focus:ring-2 accent-cyan-500 cursor-pointer">
                                        <span><cfoutput>#local.lang#</cfoutput></span>
                                    </label>
                                </cfloop>
                            </div>
                        </div>

                        <div class="space-y-2">
                            <label class="block text-[10px] font-bold text-slate-500 uppercase">Sur quoi travaillez-vous actuellement ?</label>
                            <textarea name="current_project" rows="3" placeholder="Décrivez votre projet ou vos tâches en cours..."
                                      class="w-full bg-slate-950 border border-slate-800 rounded-lg px-4 py-3 text-xs text-slate-200 focus:border-cyan-500 outline-none transition-all resize-none"><cfoutput>#qUser.current_project#</cfoutput></textarea>
                        </div>

                        <div class="flex justify-end pt-2">
                            <button type="submit" class="bg-slate-800 hover:bg-cyan-500 text-slate-200 hover:text-slate-950 px-6 py-2 rounded-lg text-xs font-bold uppercase transition-all duration-300 flex items-center gap-2 cursor-pointer">
                                <i class="fa-solid fa-floppy-disk"></i> Enregistrer les modifications
                            </button>
                        </div>
                    </form>
                </div>

                <div class="bg-slate-900 border border-slate-800 rounded-2xl shadow-xl overflow-hidden">
                    <div class="px-6 py-4 bg-slate-800/30 border-b border-slate-800 text-amber-500">
                        <h4 class="text-xs font-black uppercase tracking-widest flex items-center gap-2">
                            <i class="fa-solid fa-lock"></i> Sécurité du mot de passe
                        </h4>
                    </div>
                    <form action="update_profile.cfm" method="POST" class="p-6 space-y-6">
                        <input type="hidden" name="action" value="password">
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                            <div>
                                <label class="block text-[10px] font-bold text-slate-500 uppercase mb-2">Nouveau mot de passe</label>
                                <input type="password" name="new_password" required class="w-full bg-slate-950 border border-slate-800 rounded-lg px-4 py-2.5 text-slate-200 focus:border-amber-500 outline-none transition-all">
                            </div>
                            <div>
                                <label class="block text-[10px] font-bold text-slate-500 uppercase mb-2">Confirmer le mot de passe</label>
                                <input type="password" name="confirm_password" required class="w-full bg-slate-950 border border-slate-800 rounded-lg px-4 py-2.5 text-slate-200 focus:border-amber-500 outline-none transition-all">
                            </div>
                        </div>
                        <div class="flex justify-end">
                            <button type="submit" class="bg-slate-800 hover:bg-amber-600 text-slate-200 hover:text-white px-6 py-2 rounded-lg text-xs font-bold uppercase transition-all duration-300 flex items-center gap-2 cursor-pointer">
                                <i class="fa-solid fa-shield-halved"></i> Mettre à jour la clé
                            </button
