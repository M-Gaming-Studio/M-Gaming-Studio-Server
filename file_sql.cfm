<cfparam name="url.table" default="">

<cfset cleanTableName = rereplace(url.table, "[^a-zA-Z0-9_-]", "", "all")>

<cfif len(cleanTableName) gt 0>
    <cftry>
        <cfquery name="qDescribeTable">
            DESCRIBE #cleanTableName#;
        </cfquery>
    <cfcatch>
        <cfset errorMessage = "Impossible d'inspecter la table demandée ou la table n'existe pas.">
    </cfcatch>
    </cftry>
<cfelse>
    <cfset errorMessage = "Aucune table valide n'a été spécifiée pour l'inspection.">
</cfif>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Inspection SQL - M-Gaming-Studio Server</title>
</head>
<body class="min-h-screen antialiased">

    <cfinclude template="menu_toggle.cfm">

    <main class="max-w-7xl mx-auto px-6 py-10">
        
        <div class="mb-6">
            <a href="databases.cfm" class="inline-flex items-center gap-2 text-sm text-slate-400 hover:text-purple-400 transition-colors">
                <i class="fa-solid fa-arrow-left"></i> Retour à l'explorateur de bases
            </a>
        </div>

        <div class="mb-8 flex items-center gap-4">
            <div class="p-3 bg-purple-500/10 text-purple-400 text-2xl rounded-xl">
                <i class="fa-solid fa-rectangle-list"></i>
            </div>
            <div>
                <h2 class="text-3xl font-extrabold tracking-tight">
                    Inspecteur de Structure SQL
                </h2>
                <p class="text-slate-400 text-sm mt-0.5">
                    Analyse de la table : 
                    <cfif len(cleanTableName) gt 0>
                        <code class="text-purple-400 font-mono text-base bg-slate-900 border border-slate-800 px-2 py-0.5 rounded ml-1"><cfoutput>#cleanTableName#</cfoutput></code>
                    <cfelse>
                        <span class="text-red-400 italic">Aucune</span>
                    </cfif>
                </p>
            </div>
        </div>

        <cfif structKeyExists(variables, "errorMessage")>
            <div class="bg-red-500/10 border border-red-500/20 text-red-400 text-sm p-4 rounded-xl flex items-center gap-2 max-w-2xl">
                <i class="fa-solid fa-triangle-exclamation text-base"></i>
                <cfoutput>#variables.errorMessage#</cfoutput>
            </div>
        <cfelse>
            
            <div class="mb-4 flex items-center gap-2">
                <i class="fa-solid fa-circle-info text-slate-500 text-xs"></i>
                <h3 class="text-lg font-bold text-slate-200">Schéma des colonnes (Détails MySQL)</h3>
            </div>

            <div class="bg-slate-900 border border-slate-800 rounded-xl overflow-hidden shadow-xl">
                <table class="w-full text-left border-collapse">
                    <thead>
                        <tr class="bg-slate-800/50 border-b border-slate-800 text-purple-400 text-xs uppercase tracking-wider">
                            <th class="p-4 font-bold">Champ (Field)</th>
                            <th class="p-4 font-bold">Type de Donnée</th>
                            <th class="p-4 font-bold text-center">Null</th>
                            <th class="p-4 font-bold text-center">Clé (Key)</th>
                            <th class="p-4 font-bold">Valeur par Défaut</th>
                            <th class="p-4 font-bold text-right">Extra</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-slate-800 text-slate-300">
                        <cfoutput query="qDescribeTable">
                            <tr class="hover:bg-slate-800/30 transition-colors">
                                <td class="p-4 font-mono font-bold text-slate-100">
                                    <i class="fa-solid fa-hashtag text-[10px] text-slate-600 mr-1.5"></i>#qDescribeTable.Field#
                                </td>
                                <td class="p-4 font-mono text-sm text-cyan-400">
                                    #qDescribeTable.Type#
                                </td>
                                <td class="p-4 text-sm text-center font-medium">
                                    <if qDescribeTable.Null eq "YES">
                                        <span class="text-slate-500">Oui</span>
                                    <else>
                                        <span class="text-slate-400 font-bold">Non</span>
                                    </if>
                                </td>
                                <td class="p-4 text-center">
                                    <cfif qDescribeTable.Key eq "PRI">
                                        <span class="inline-flex items-center gap-1 bg-amber-500/10 text-amber-400 border border-amber-500/20 px-2 py-0.5 rounded text-xs font-bold uppercase tracking-wide">
                                            <i class="fa-solid fa-key text-[9px]"></i> PRI
                                        </span>
                                    <cfelse>
                                        <span class="text-slate-600 font-mono text-xs">#qDescribeTable.Key#</span>
                                    </cfif>
                                </td>
                                <td class="p-4 text-sm font-mono text-slate-400">
                                    <cfif len(qDescribeTable.Default) gt 0>
                                        #qDescribeTable.Default#
                                    <cfelse>
                                        <span class="text-slate-600 italic">NULL</span>
                                    </cfif>
                                </td>
                                <td class="p-4 text-right text-xs font-mono text-purple-400 font-semibold">
                                    #qDescribeTable.Extra#
                                </td>
                            </tr>
                        </cfoutput>
                    </tbody>
                </table>
            </div>

        </cfif>

    </main>

</body>
</html>