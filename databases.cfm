<cfquery name="qTables">
    SHOW TABLES;
</cfquery>

<cfquery name="qCountUsers">
    SELECT COUNT(id) AS totalUsers FROM users
</cfquery>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Bases de données - M-Gaming-Studio Server</title>

    <cfinclude template="analytics.cfm">
</head>
<body class="min-h-screen antialiased">

    <cfinclude template="menu_toggle.cfm">

    <main class="max-w-7xl mx-auto px-6 py-10">
        
        <div class="mb-8 flex items-center gap-4">
            <div class="p-3 bg-purple-500/10 text-purple-400 text-2xl rounded-xl">
                <i class="fa-solid fa-database"></i>
            </div>
            <div>
                <h2 class="text-3xl font-extrabold tracking-tight">Statut de la Base de Données (DBngin)</h2>
                <p class="text-slate-400 text-sm mt-0.5 flex items-center gap-2">
                    Statut de la connexion : <span class="inline-flex items-center gap-1.5 text-emerald-400 font-bold"><span class="w-2 h-2 rounded-full bg-emerald-400 animate-pulse"></span> En ligne</span>
                </p>
            </div>
        </div>

        <div class="grid grid-cols-1 sm:grid-cols-2 gap-6 mb-10">
            <div class="bg-slate-900 border border-slate-800 p-6 rounded-xl shadow-xl flex items-center justify-between">
                <div>
                    <h4 class="text-sm font-semibold text-slate-400 uppercase tracking-wider">Tables Détectées</h4>
                    <p class="text-4xl font-black mt-2 text-cyan-400"><cfoutput>#qTables.recordCount#</cfoutput></p>
                </div>
                <i class="fa-solid fa-table-list text-3xl text-slate-700"></i>
            </div>

            <div class="bg-slate-900 border border-slate-800 p-6 rounded-xl shadow-xl flex items-center justify-between">
                <div>
                    <h4 class="text-sm font-semibold text-slate-400 uppercase tracking-wider">Utilisateurs inscrits</h4>
                    <p class="text-4xl font-black mt-2 text-purple-400"><cfoutput>#qCountUsers.totalUsers#</cfoutput></p>
                </div>
                <i class="fa-solid fa-users text-3xl text-slate-700"></i>
            </div>
        </div>

        <div class="mb-4">
            <h3 class="text-xl font-bold">Structure de la base <code class="text-cyan-400 font-mono text-base">mgaming_studio</code></h3>
        </div>

        <div class="bg-slate-900 border border-slate-800 rounded-xl overflow-hidden shadow-xl max-w-2xl">
            <table class="w-full text-left border-collapse">
                <thead>
                    <tr class="bg-slate-800/50 border-b border-slate-800 text-cyan-400 text-xs uppercase tracking-wider">
                        <th class="p-4 font-bold">Nom de la Table</th>
                        <th class="p-4 font-bold text-center w-32">Action</th>
                    </tr>
                </thead>
                <tbody class="divide-y divide-slate-800 text-slate-300">
                    <cfoutput query="qTables">
                        <cfset tableName = qTables[qTables.columnList][qTables.currentRow]>
                        <tr class="hover:bg-slate-800/30 transition-colors">
                            <td class="p-4 font-mono text-slate-200 flex items-center gap-3">
                                <i class="fa-solid fa-table text-purple-500"></i> `\##tableName##`
                            </td>
                            <td class="p-4 text-center">
                                <a href="file_sql.cfm?table=#tableName#" class="inline-flex items-center gap-1.5 bg-slate-800 hover:bg-purple-500/20 text-purple-400 border border-purple-500/30 px-3 py-1 rounded-lg text-xs font-bold uppercase tracking-wider transition-colors">
                                    <i class="fa-solid fa-magnifying-glass text-[10px]"></i> Inspecter
                                </a>
                            </td>
                        </tr>
                    </cfoutput>
                </tbody>
            </table>
        </div>
    </main>

</body>
</html>
