<cfquery name="qStatsUsers">
    SELECT COUNT(id) as total FROM users
</cfquery>

<cfquery name="qUserAdmin">
    SELECT username, avatar, languages, current_project 
    FROM users 
    WHERE id = <cfqueryparam value="#session.user_id#" cfsqltype="cf_sql_integer">
</cfquery>

<cftry>
    <cfquery name="qProjectsEnCours">
        SELECT COUNT(id) as total FROM projects WHERE status = 'En cours'
    </cfquery>
    <cfquery name="qProjectsEnPause">
        SELECT COUNT(id) as total FROM projects WHERE status = 'En pause'
    </cfquery>
    <cfquery name="qProjectsTermines">
        SELECT COUNT(id) as total FROM projects WHERE status = 'Terminé'
    </cfquery>
    <cfcatch>
        <cfset qProjectsEnCours = { total: 0 }>
        <cfset qProjectsEnPause = { total: 0 }>
        <cfset qProjectsTermines = { total: 0 }>
    </cfcatch>
</cftry>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Tableau de Bord - M-Gaming-Studio Server</title>
</head>
<body class="min-h-screen antialiased flex flex-col">

    <cfinclude template="menu_toggle.cfm">

    <main class="max-w-7xl mx-auto px-6 py-10 w-full flex-grow">
        
        <div class="mb-10 flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4 border-b border-slate-800/60 pb-6">
            <div>
                <h2 class="text-3xl font-black tracking-tighter uppercase italic text-slate-100">
                    Tableau de <span class="text-cyan-500">Bord</span>
                </h2>
                <p class="text-slate-400 text-sm mt-1">
                    Bonjour, <span class="text-cyan-400 font-bold font-mono"><cfoutput>#qUserAdmin.username#</cfoutput></span> · Terminal de contrôle général.
                </p>
            </div>
            <div class="text-xs font-mono bg-slate-950 border border-slate-800 px-4 py-2 rounded-xl text-slate-500 flex items-center gap-2">
                <span class="w-2 h-2 rounded-full bg-cyan-400 animate-pulse"></span>
                SYS_STATUS: ONLINE · <cfoutput>#dateFormat(now(), "dd/mm/yyyy")#</cfoutput>
            </div>
        </div>

        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6 mb-10">
            
            <div class="bg-slate-900 border border-slate-800 rounded-2xl p-6 shadow-xl flex items-center justify-between group hover:border-cyan-500/30 transition-all duration-300">
                <div class="space-y-1">
                    <p class="text-[10px] font-bold text-slate-500 uppercase tracking-widest">Production active</p>
                    <p class="text-3xl font-black text-slate-100 font-mono"><cfoutput>#qProjectsEnCours.total#</cfoutput></p>
                    <p class="text-[10px] font-semibold text-cyan-400 flex items-center gap-1 mt-1">
                        <span class="w-1.5 h-1.5 bg-cyan-400 rounded-full animate-pulse"></span> En cours
                    </p>
                </div>
                <div class="w-12 h-12 bg-slate-950 border border-slate-800 rounded-xl flex items-center justify-center text-cyan-400 group-hover:bg-cyan-500 group-hover:text-slate-950 transition-all duration-300">
                    <i class="fa-solid fa-spinner text-lg animate-spin" style="animation-duration: 4s;"></i>
                </div>
            </div>

            <div class="bg-slate-900 border border-slate-800 rounded-2xl p-6 shadow-xl flex items-center justify-between group hover:border-amber-500/30 transition-all duration-300">
                <div class="space-y-1">
                    <p class="text-[10px] font-bold text-slate-500 uppercase tracking-widest">En attente / Standby</p>
                    <p class="text-3xl font-black text-slate-100 font-mono"><cfoutput>#qProjectsEnPause.total#</cfoutput></p>
                    <p class="text-[10px] font-semibold text-amber-500 flex items-center gap-1 mt-1">
                        <span class="w-1.5 h-1.5 bg-amber-500 rounded-full"></span> En pause
                    </p>
                </div>
                <div class="w-12 h-12 bg-slate-950 border border-slate-800 rounded-xl flex items-center justify-center text-amber-500 group-hover:bg-amber-500 group-hover:text-slate-950 transition-all duration-300">
                    <i class="fa-solid fa-pause text-lg"></i>
                </div>
            </div>

            <div class="bg-slate-900 border border-slate-800 rounded-2xl p-6 shadow-xl flex items-center justify-between group hover:border-emerald-500/30 transition-all duration-300">
                <div class="space-y-1">
                    <p class="text-[10px] font-bold text-slate-500 uppercase tracking-widest">Livrables / Déployés</p>
                    <p class="text-3xl font-black text-slate-100 font-mono"><cfoutput>#qProjectsTermines.total#</cfoutput></p>
                    <p class="text-[10px] font-semibold text-emerald-400 flex items-center gap-1 mt-1">
                        <span class="w-1.5 h-1.5 bg-emerald-500 rounded-full"></span> Terminés
                    </p>
                </div>
                <div class="w-12 h-12 bg-slate-950 border border-slate-800 rounded-xl flex items-center justify-center text-emerald-400 group-hover:bg-emerald-500 group-hover:text-slate-950 transition-all duration-300">
                    <i class="fa-solid fa-check-double text-lg"></i>
                </div>
            </div>

        </div>

        <div class="grid grid-cols-1 lg:grid-cols-12 gap-8 items-start">
            
            <div class="lg:col-span-8 space-y-6">
                <div class="bg-slate-900 border border-slate-800 rounded-2xl shadow-xl p-6">
                    <h3 class="text-xs font-black uppercase tracking-widest text-cyan-400 mb-6 flex items-center gap-2">
                        <i class="fa-solid fa-user-check"></i> Statut de votre session active
                    </h3>
                    
                    <div class="space-y-6">
                        <div class="space-y-2">
                            <h4 class="text-[10px] font-bold text-slate-500 uppercase">Langages maîtrisés enregistrés</h4>
                            <div class="flex flex-wrap gap-2">
                                <cfif len(qUserAdmin.languages)>
                                    <cfloop list="#qUserAdmin.languages#" index="local.lang">
                                        <span class="bg-slate-950 border border-slate-800 text-slate-300 text-xs px-3 py-1.5 rounded-lg font-medium flex items-center gap-2">
                                            <span class="w-1 h-1 bg-cyan-400 rounded-full"></span> <cfoutput>#local.lang#</cfoutput>
                                        </span>
                                    </cfloop>
                                <cfelse>
                                    <span class="text-xs text-slate-500 italic">Aucun langage sélectionné. Configurez votre profil.</span>
                                </cfif>
                            </div>
                        </div>

                        <div class="space-y-2 pt-4 border-t border-slate-800/50">
                            <h4 class="text-[10px] font-bold text-slate-500 uppercase">Travail en cours</h4>
                            <div class="bg-slate-950 border border-slate-800/80 rounded-xl p-4">
                                <p class="text-xs text-slate-300 leading-relaxed italic">
                                    <cfif len(qUserAdmin.current_project)>
                                        <cfoutput>"#qUserAdmin.current_project#"</cfoutput>
                                    <cfelse>
                                        "Aucun projet renseigné pour le moment. Mettez votre profil à jour pour l'afficher sur votre tableau de bord."
                                    </cfif>
                                </p>
                            </div>
                        </div>

                        <div class="pt-4 border-t border-slate-800/50 flex items-center justify-between text-xs text-slate-500">
                            <span>Total des comptes sur ce serveur :</span>
                            <span class="font-mono text-slate-300 font-bold bg-slate-950 px-2.5 py-1 rounded border border-slate-800"><cfoutput>#qStatsUsers.total#</cfoutput></span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="lg:col-span-4 space-y-6">
                <div class="bg-slate-900 border border-slate-800 rounded-2xl shadow-xl p-6">
                    <h3 class="text-xs font-black uppercase tracking-widest text-cyan-400 mb-6 flex items-center gap-2">
                        <i class="fa-solid fa-bolt"></i> Actions Rapides
                    </h3>
                    
                    <div class="flex flex-col gap-3">
                        <a href="projects.cfm" class="w-full bg-slate-950 hover:bg-slate-800 border border-slate-800 px-4 py-3 rounded-xl text-xs font-bold uppercase tracking-wider text-slate-300 hover:text-cyan-400 transition-all flex items-center justify-between group">
                            <span class="flex items-center gap-3"><i class="fa-solid fa-folder text-slate-500 group-hover:text-cyan-400"></i> Voir les Projets</span>
                            <i class="fa-solid fa-chevron-right text-[10px] text-slate-600"></i>
                        </a>
                        <a href="databases.cfm" class="w-full bg-slate-950 hover:bg-slate-800 border border-slate-800 px-4 py-3 rounded-xl text-xs font-bold uppercase tracking-wider text-slate-300 hover:text-cyan-400 transition-all flex items-center justify-between group">
                            <span class="flex items-center gap-3"><i class="fa-solid fa-database text-slate-500 group-hover:text-cyan-400"></i> Gérer les Bases</span>
                            <i class="fa-solid fa-chevron-right text-[10px] text-slate-600"></i>
                        </a>
                        <a href="profile.cfm" class="w-full bg-slate-950 hover:bg-slate-800 border border-slate-800 px-4 py-3 rounded-xl text-xs font-bold uppercase tracking-wider text-slate-300 hover:text-cyan-400 transition-all flex items-center justify-between group">
                            <span class="flex items-center gap-3"><i class="fa-solid fa-user-gear text-slate-500 group-hover:text-cyan-400"></i> Paramètres Profil</span>
                            <i class="fa-solid fa-chevron-right text-[10px] text-slate-600"></i>
                        </a>
                    </div>
                </div>
            </div>

        </div>

    </main>

</body>
</html>