<cfquery name="qProjects">
    SELECT id, name, status, created_at 
    FROM projects 
    ORDER BY created_at DESC
</cfquery>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Gestion des Projets - M-Gaming-Studio Server</title>
</head>
<body class="min-h-screen antialiased flex flex-col">

    <cfinclude template="menu_toggle.cfm">

    <main class="max-w-7xl mx-auto px-6 py-10 w-full flex-grow">
        
        <div class="mb-10 border-b border-slate-800/60 pb-6">
            <h2 class="text-3xl font-black tracking-tighter uppercase italic text-slate-100">
                Gestion des <span class="text-cyan-500">Projets</span>
            </h2>
            <p class="text-slate-400 text-sm mt-1">Créez, planifiez et suivez l'avancement de vos modules de développement.</p>
        </div>

        <div class="grid grid-cols-1 lg:grid-cols-12 gap-8 items-start">
            
            <div class="lg:col-span-4 bg-slate-900 border border-slate-800 rounded-2xl p-6 shadow-xl space-y-4">
                <h3 class="text-xs font-black uppercase tracking-widest text-cyan-400 flex items-center gap-2 mb-2">
                    <i class="fa-solid fa-plus"></i> Nouveau Projet
                </h3>
                
                <form action="update_project.cfm" method="POST" class="space-y-4">
                    <input type="hidden" name="action" value="add">
                    
                    <div class="space-y-1">
                        <label class="block text-[10px] font-bold text-slate-500 uppercase">Nom du projet</label>
                        <input type="text" name="name" required placeholder="Ex: API Matchmaking" 
                               class="w-full bg-slate-950 border border-slate-800 rounded-lg px-4 py-2.5 text-xs text-slate-200 focus:border-cyan-500 outline-none transition-all">
                    </div>

                    <div class="space-y-1">
                        <label class="block text-[10px] font-bold text-slate-500 uppercase">Statut Initial</label>
                        <select name="status" class="w-full bg-slate-950 border border-slate-800 rounded-lg px-4 py-2.5 text-xs text-slate-300 focus:border-cyan-500 outline-none transition-all cursor-pointer">
                            <option value="En cours">En cours</option>
                            <option value="En pause">En pause</option>
                            <option value="Terminé">Terminé</option>
                        </select>
                    </div>

                    <button type="submit" class="w-full bg-cyan-500 hover:bg-cyan-400 text-slate-950 py-3 rounded-xl text-xs font-black uppercase tracking-wider transition-all duration-150 cursor-pointer shadow-lg shadow-cyan-500/10 active:scale-95">
                        Initialiser le projet
                    </button>
                </form>
            </div>

            <div class="lg:col-span-8 space-y-4">
                <h3 class="text-xs font-black uppercase tracking-widest text-slate-400 flex items-center gap-2 mb-2">
                    <i class="fa-solid fa-list-check"></i> Base de données Projets (<cfoutput>#qProjects.recordCount#</cfoutput>)
                </h3>

                <cfif qProjects.recordCount eq 0>
                    <div class="bg-slate-900 border border-slate-800 border-dashed rounded-2xl p-12 text-center text-slate-500 text-xs italic">
                        <i class="fa-solid fa-folder-open text-3xl text-slate-700 mb-3 block"></i>
                        Aucun projet n'est enregistré pour le moment. Utilisez le panneau latéral pour commencer.
                    </div>
                <cfelse>
                    <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                        <cfoutput query="qProjects">
                            <div class="bg-slate-900 border border-slate-800 rounded-2xl p-5 shadow-xl flex flex-col justify-between hover:border-slate-700/60 transition-all group">
                                <div class="space-y-3">
                                    <div class="flex items-center justify-between gap-2">
                                        <cfif status eq "En cours">
                                            <span class="bg-cyan-500/10 border border-cyan-500/20 text-cyan-400 text-[10px] font-bold px-2.5 py-1 rounded-md flex items-center gap-1.5">
                                                <span class="w-1 h-1 bg-cyan-400 rounded-full animate-pulse"></span> En cours
                                            </span>
                                        <cfelseif status eq "En pause">
                                            <span class="bg-amber-500/10 border border-amber-500/20 text-amber-500 text-[10px] font-bold px-2.5 py-1 rounded-md flex items-center gap-1.5">
                                                <span class="w-1 h-1 bg-amber-500 rounded-full"></span> En pause
                                            </span>
                                        <cfelse>
                                            <span class="bg-emerald-500/10 border border-emerald-500/20 text-emerald-400 text-[10px] font-bold px-2.5 py-1 rounded-md flex items-center gap-1.5">
                                                <span class="w-1 h-1 bg-emerald-500 rounded-full"></span> Terminé
                                            </span>
                                        </cfif>
                                        
                                        <span class="text-[10px] font-mono text-slate-600">ID: ##purple-#id#</span>
                                    </div>
                                    
                                    <h4 class="text-sm font-bold text-slate-200 tracking-wide group-hover:text-cyan-400 transition-colors uppercase font-mono">
                                        #name#
                                    </h4>
                                </div>

                                <div class="flex items-center justify-between pt-4 mt-4 border-t border-slate-800/50 text-[10px]">
                                    <span class="text-slate-500 flex items-center gap-1.5">
                                        <i class="fa-regular fa-calendar text-slate-600"></i> #dateFormat(created_at, "dd/mm/yyyy")#
                                    </span>
                                    
                                    <form action="update_project.cfm" method="POST" onsubmit="return confirm('Supprimer ce projet ?');">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="id" value="#id#">
                                        <button type="submit" class="text-slate-600 hover:text-red-400 transition-colors p-1 cursor-pointer">
                                            <i class="fa-solid fa-trash-can"></i>
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </cfoutput>
                    </div>
                </cfif>
            </div>

        </div>
    </main>

</body>
</html>