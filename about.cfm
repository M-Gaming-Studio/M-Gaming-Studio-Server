<cfset rootPath = expandPath("./")>
<cfset diskFile = CreateObject("java", "java.io.File").init(rootPath)>

<cfset totalDiskSpace = diskFile.getTotalSpace()>
<cfset freeDiskSpace = diskFile.getFreeSpace()>
<cfset usedDiskSpace = totalDiskSpace - freeDiskSpace>

<cfset maxQuotaBytes = 10 * 1024 * 1024 * 1024> 
<cfif usedDiskSpace gt maxQuotaBytes>
    <cfset usedDiskSpace = maxQuotaBytes>
</cfif>

<cfset usedGB = numberFormat(usedDiskSpace / (1024 * 1024 * 1024), "0.00")>
<cfset maxGB = 10.00>
<cfset freeQuotaGB = numberFormat(maxGB - usedGB, "0.00")>

<cfset storagePercent = int((usedGB / maxGB) * 100)>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>A propos du Serveur - M-Gaming-Studio Server</title>

    <cfinclude template="analytics.cfm">
</head>
<body class="min-h-screen flex flex-col justify-between antialiased bg-slate-950 text-slate-100">

    <cfinclude template="menu_toggle.cfm">

    <main class="max-w-5xl mx-auto px-6 py-10 w-full flex-grow">
        
        <div class="mb-10 flex items-center gap-4">
            <div class="p-3 bg-cyan-500/10 text-cyan-400 text-2xl rounded-xl">
                <i class="fa-solid fa-circle-info"></i>
            </div>
            <div>
                <h2 class="text-3xl font-black tracking-tighter uppercase italic text-slate-100">
                    À Propos du <span class="text-cyan-500">Serveur</span>
                </h2>
                <p class="text-slate-400 text-sm mt-1">Spécifications techniques de l'infrastructure de M-Gaming-Studio Server.</p>
            </div>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
            
            <div class="md:col-span-2 space-y-6">
                
                <div class="bg-slate-900 border border-slate-800 rounded-2xl p-6 shadow-xl">
                    <div class="flex items-center justify-between mb-2">
                        <h3 class="text-sm font-bold uppercase tracking-wider text-slate-300 flex items-center gap-2">
                            <i class="fa-solid fa-hard-drive text-cyan-400"></i> Stockage Alloué au Projet
                        </h3>
                        <span class="text-xs font-mono font-bold bg-slate-950 border border-slate-800 px-2 py-0.5 rounded text-cyan-400">
                            <cfoutput>#storagePercent#</cfoutput>% Utilisé
                        </span>
                    </div>

                    <div class="w-full bg-slate-950 rounded-full h-4 border border-slate-800 p-0.5 overflow-hidden mb-6">
                        <div class="bg-gradient-to-r from-cyan-500 to-blue-500 h-full rounded-full transition-all duration-500" 
                             style="width: <cfoutput>#storagePercent#</cfoutput>%;"></div>
                    </div>

                    <div class="grid grid-cols-3 gap-4 text-center">
                        <div class="bg-slate-950/50 border border-slate-800/60 p-3 rounded-xl">
                            <p class="text-[10px] font-bold text-slate-500 uppercase">Espace Utilisé</p>
                            <p class="text-lg font-black text-slate-200 font-mono mt-0.5"><cfoutput>#usedGB#</cfoutput> GB</p>
                        </div>
                        <div class="bg-slate-950/50 border border-slate-800/60 p-3 rounded-xl">
                            <p class="text-[10px] font-bold text-slate-500 uppercase">Espace Libre</p>
                            <p class="text-lg font-black text-emerald-400 font-mono mt-0.5"><cfoutput>#freeQuotaGB#</cfoutput> GB</p>
                        </div>
                        <div class="bg-slate-950/50 border border-slate-800/60 p-3 rounded-xl">
                            <p class="text-[10px] font-bold text-slate-500 uppercase">Limite Max</p>
                            <p class="text-lg font-black text-cyan-500 font-mono mt-0.5"><cfoutput>#maxGB#</cfoutput> GB</p>
                        </div>
                    </div>
                </div>

                <div class="bg-slate-900 border border-slate-800 rounded-2xl p-6 shadow-xl space-y-4">
                    <h3 class="text-sm font-bold uppercase tracking-wider text-slate-300 flex items-center gap-2">
                        <i class="fa-solid fa-cubes text-purple-400"></i> Écosystème M-Gaming-Studio Server
                    </h3>
                    <p class="text-slate-400 text-sm leading-relaxed">
                        Ce panneau de contrôle est une architecture propriétaire conçue pour centraliser les micro-services de projets. Il fait le pont entre le système de fichiers (FileSystem) pour la création instantanée d'environnements serveurs et la structure relationnelle MySQL via l'utilitaire DBngin.
                    </p>
                    <div class="pt-4 border-t border-slate-800/50 flex gap-6 text-xs text-slate-500">
                        <div><i class="fa-solid fa-code-branch mr-1.5 text-slate-600"></i> Version : <span class="text-slate-300 font-semibold">v2.4.0-Beta</span></div>
                        <div><i class="fa-solid fa-user-shield mr-1.5 text-slate-600"></i> Environnement : <span class="text-emerald-400 font-semibold">Production</span></div>
                    </div>
                </div>

            </div>

            <div class="md:col-span-1">
                <div class="bg-slate-900 border border-slate-800 rounded-2xl shadow-xl overflow-hidden h-full flex flex-col justify-between">
                    <div>
                        <div class="px-6 py-4 bg-slate-800/30 border-b border-slate-800">
                            <h4 class="text-xs font-black uppercase tracking-widest text-slate-400 flex items-center gap-2">
                                <i class="fa-solid fa-server text-cyan-500"></i> Engine Specs
                            </h4>
                        </div>
                        
                        <div class="p-6 space-y-4 font-mono text-xs">
                            <div class="border-b border-slate-800 pb-3">
                                <p class="text-[10px] text-slate-500 uppercase font-sans font-bold tracking-wider">Serveur d'application</p>
                                <p class="text-slate-200 font-bold mt-0.5"><cfoutput>#server.coldfusion.productname#</cfoutput></p>
                            </div>
                            <div class="border-b border-slate-800 pb-3">
                                <p class="text-[10px] text-slate-500 uppercase font-sans font-bold tracking-wider">Version Engine</p>
                                <p class="text-cyan-400 font-bold mt-0.5"><cfoutput>#server.coldfusion.productversion#</cfoutput></p>
                            </div>
                            <div class="border-b border-slate-800 pb-3">
                                <p class="text-[10px] text-slate-500 uppercase font-sans font-bold tracking-wider">Système d'Exploitation</p>
                                <p class="text-slate-300 mt-0.5"><cfoutput>#server.os.name# (#server.os.version#)</cfoutput></p>
                            </div>
                            <div>
                                <p class="text-[10px] text-slate-500 uppercase font-sans font-bold tracking-wider">Runtime Java (JVM)</p>                                     
                                <p class="text-slate-400 mt-0.5">Java <cfoutput>#server.java.version#</cfoutput></p>
                            </div>
                        </div>
                    </div>

                    <div class="p-6 bg-slate-950/40 border-t border-slate-800/50 flex items-center justify-between text-xs text-slate-500 font-mono">
                        <span>Cluster Nodes : 1</span>
                        <span class="text-emerald-500 font-bold flex items-center gap-1">
                            <span class="w-1.5 h-1.5 rounded-full bg-emerald-500 animate-pulse"></span> ONLINE
                        </span>
                    </div>
                </div>
            </div>

        </div>

    </main>

    </body>
</html>
