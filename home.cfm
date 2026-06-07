<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Accueil - M-Gaming-Studio Server</title>
</head>
<body class="min-h-screen antialiased">

    <cfinclude template="menu_toggle.cfm">

    <main class="max-w-7xl mx-auto px-6 py-10">
        
        <div class="mb-10">
            <h1 class="text-4xl font-extrabold tracking-tight mb-2">
                Accueil
            </h1>
            <p class="text-slate-400 text-lg">
                Bienvenue sur M-Gaming-Studio Server.
            </p>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
            
            <div class="bg-slate-900 border border-slate-800 rounded-xl p-6 hover:border-slate-700 transition-all duration-300 shadow-xl group">
                <div class="flex items-center justify-between mb-4">
                    <div class="p-3 bg-cyan-500/10 rounded-lg text-cyan-400 text-xl w-12 h-12 flex items-center justify-center">
                        <i class="fa-solid fa-folder-tree"></i>
                    </div>
                    <span class="text-xs font-bold text-slate-500 uppercase tracking-widest">Module FileSystem</span>
                </div>
                <h3 class="text-xl font-bold mb-2 group-hover:text-cyan-400 transition-colors">Gestion des Projets</h3>
                <p class="text-slate-400 text-sm mb-6 leading-relaxed">
                    Explore les fichiers serveurs, crée de nouveaux répertoires pour tes jeux et gère l'arborescence en temps réel.
                </p>
                <a href="projects.cfm" class="inline-flex items-center justify-center bg-slate-800 hover:bg-cyan-500 text-slate-200 hover:text-slate-950 px-4 py-2 rounded-lg text-sm font-semibold transition-all duration-200 w-full md:w-auto gap-2">
                    Accéder aux fichiers <i class="fa-solid fa-arrow-right text-xs"></i>
                </a>
            </div>
            
            <div class="bg-slate-900 border border-slate-800 rounded-xl p-6 hover:border-slate-700 transition-all duration-300 shadow-xl group">
                <div class="flex items-center justify-between mb-4">
                    <div class="p-3 bg-purple-500/10 rounded-lg text-purple-400 text-xl w-12 h-12 flex items-center justify-center">
                        <i class="fa-solid fa-database"></i>
                    </div>
                    <span class="text-xs font-bold text-slate-500 uppercase tracking-widest">Module MySQL</span>
                </div>
                <h3 class="text-xl font-bold mb-2 group-hover:text-purple-400 transition-colors">Bases de Données</h3>
                <p class="text-slate-400 text-sm mb-6 leading-relaxed">
                    Inspecte tes tables DBngin, surveille l'état de l'infrastructure MySQL et analyse les statistiques des joueurs inscrits.
                </p>
                <a href="databases.cfm" class="inline-flex items-center justify-center bg-slate-800 hover:bg-purple-500 text-slate-200 hover:text-slate-950 px-4 py-2 rounded-lg text-sm font-semibold transition-all duration-200 w-full md:w-auto gap-2">
                    Ouvrir l'explorateur <i class="fa-solid fa-arrow-right text-xs"></i>
                </a>
            </div>

        </div>

    </main>

</body>
</html>