<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Confidentialité - M-Gaming-Studio Server</title>

    <cfinclude template="analytics.cfm">
</head>
<body class="min-h-screen flex flex-col justify-between antialiased bg-slate-950 text-slate-100">

    <cfinclude template="menu_toggle.cfm">

    <main class="max-w-4xl mx-auto px-6 py-10 w-full flex-grow">
        
        <div class="mb-10 flex items-center gap-4">
            <div class="p-3 bg-cyan-500/10 text-cyan-400 text-2xl rounded-xl">
                <i class="fa-solid fa-user-lock"></i>
            </div>
            <div>
                <h2 class="text-3xl font-black tracking-tighter uppercase italic text-slate-100">
                    Sécurité & <span class="text-cyan-500">Confidentialité</span>
                </h2>
                <p class="text-slate-400 text-sm mt-1">Règles de protection des données et de gestion des sessions de l'infrastructure.</p>
            </div>
        </div>

        <div class="space-y-6">
            
            <div class="bg-slate-900 border border-slate-800 rounded-2xl p-6 shadow-xl">
                <h3 class="text-base font-bold uppercase tracking-wider text-slate-200 flex items-center gap-2.5 mb-3">
                    <i class="fa-solid fa-database text-cyan-400 text-sm"></i> 1. Collecte Limitée au Strict Minimum
                </h3>
                <p class="text-slate-400 text-sm leading-relaxed mb-4">
                    Dans le cadre de l'administration du serveur <code class="text-cyan-400 font-mono bg-slate-950 px-1.5 py-0.5 rounded text-xs">M-Gaming-Studio Server</code>, les seules données stockées en base relationnelle (MySQL) concernent l'authentification de votre compte :
                </p>
                <ul class="list-none space-y-2 text-xs text-slate-300 font-mono pl-2">
                    <li class="flex items-center gap-2"><i class="fa-solid fa-caret-right text-cyan-500"></i> L'identifiant système unique (User ID)</li>
                    <li class="flex items-center gap-2"><i class="fa-solid fa-caret-right text-cyan-500"></i> Le pseudonyme d'affichage (Username)</li>
                    <li class="flex items-center gap-2"><i class="fa-solid fa-caret-right text-cyan-500"></i> L'adresse e-mail de correspondance administrative</li>
                    <li class="flex items-center gap-2"><i class="fa-solid fa-caret-right text-cyan-500"></i> Le nom de fichier de votre image de profil (Avatar)</li>
                </ul>
            </div>

            <div class="bg-slate-900 border border-slate-800 rounded-2xl p-6 shadow-xl">
                <h3 class="text-base font-bold uppercase tracking-wider text-slate-200 flex items-center gap-2.5 mb-3">
                    <i class="fa-solid fa-key text-amber-500 text-sm"></i> 2. Chiffrement et Résistance Cryptographique
                </h3>
                <p class="text-slate-400 text-sm leading-relaxed">
                    Les mots de passe ne sont <strong>jamais</strong> stockés en clair. Dès leur modification dans votre espace profil, ils subissent un hachage irréversible via l'algorithme <span class="text-amber-400 font-bold font-mono">SHA-512</span>. Même en cas d'accès physique aux tables via TablePlus ou DBngin, vos clés d'accès restent mathématiquement indéchiffrables.
                </p>
            </div>

            <div class="bg-slate-900 border border-slate-800 rounded-2xl p-6 shadow-xl">
                <h3 class="text-base font-bold uppercase tracking-wider text-slate-200 flex items-center gap-2.5 mb-3">
                    <i class="fa-solid fa-cookie-bite text-purple-400 text-sm"></i> 3. Gestion des Traces et Sessions (Lucee)
                </h3>
                <p class="text-slate-400 text-sm leading-relaxed mb-3">
                    Le serveur utilise des cookies techniques de session temporaires (<code class="text-purple-400 font-mono text-xs">CFID</code> et <code class="text-purple-400 font-mono text-xs">CFTOKEN</code>) gérés par le moteur Lucee. 
                </p>
                <p class="text-slate-400 text-sm leading-relaxed">
                    Ces jetons servent uniquement à maintenir votre état connecté lorsque vous naviguez d'une page à l'autre (par exemple, pour afficher votre nom dans le menu). Ils sont détruits automatiquement dès que vous cliquez sur <span class="text-red-400 font-semibold">Déconnexion</span> ou après une période prolongée d'inactivité.
                </p>
            </div>

            <div class="bg-slate-900 border border-slate-800 rounded-2xl p-6 shadow-xl">
                <h3 class="text-base font-bold uppercase tracking-wider text-slate-200 flex items-center gap-2.5 mb-3">
                    <i class="fa-solid fa-folder-open text-emerald-400 text-sm"></i> 4. Isolation du FileSystem
                </h3>
                <p class="text-slate-400 text-sm leading-relaxed">
                    Les fichiers multimédias importés (comme les avatars dans le dossier <code class="text-slate-300 font-mono text-xs">/assets/avatars/</code>, par exemple) sont renommés de manière unique. Le système applique des filtres stricts sur les types MIME pour empêcher l'exécution de scripts malveillants sur votre espace disque de 10 Go.
                </p>
            </div>

        </div>

    </main>

    </body>
</html>
