<style>
    html, body {
        background-color: #020617 !important;
        color: #f8fafc !important;
        font-family: ui-sans-serif, system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif !important;
    }
</style>

<script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

<nav class="bg-slate-900 border-b border-slate-800 text-slate-100 shadow-lg relative z-50">
    <div class="max-w-7xl mx-auto px-6">
        <div class="flex items-center justify-between h-20">
            
            <div class="flex items-center space-x-3">
                <span class="text-xl font-black tracking-wider bg-gradient-to-r from-cyan-400 to-blue-500 bg-clip-text text-transparent">
                    M-GAMING-STUDIO SERVER                    
                </span>
            </div>

            <div class="flex items-center">
                <button id="hamburger-btn" class="text-slate-400 hover:text-cyan-400 focus:outline-none p-2 rounded-lg hover:bg-slate-800 transition-colors cursor-pointer" aria-label="Toggle Menu">
                    <i id="hamburger-icon" class="fa-solid fa-bars text-xl"></i>
                </button>
            </div>

        </div>
    </div>

    <div id="mobile-menu" class="hidden bg-slate-900 border-b border-slate-800 w-full absolute left-0 top-20 shadow-2xl transition-all duration-300">
        <div class="max-w-7xl mx-auto px-6 py-6 grid grid-cols-1 md:grid-cols-2 gap-6">
            
            <div class="space-y-2 flex flex-col justify-between">
                <div class="space-y-1">
                    <a href="home.cfm" class="text-slate-300 hover:text-cyan-400 font-medium py-2.5 border-b border-slate-800/50 flex items-center gap-3 transition-colors">
                        <i class="fa-solid fa-house text-sm text-slate-400 w-5"></i> Accueil
                    </a>
                    <a href="dashboard.cfm" class="text-slate-300 hover:text-cyan-400 font-medium py-2.5 border-b border-slate-800/50 flex items-center gap-3 transition-colors">
                        <i class="fa-solid fa-chart-simple text-sm text-slate-400 w-5"></i> Tableau de Bord                    	
                    </a>
                    <a href="projects.cfm" class="text-slate-300 hover:text-cyan-400 font-medium py-2.5 border-b border-slate-800/50 flex items-center gap-3 transition-colors">
                        <i class="fa-solid fa-folder text-sm text-slate-400 w-5"></i> Projets
                    </a>
                    <a href="databases.cfm" class="text-slate-300 hover:text-cyan-400 font-medium py-2.5 border-b border-slate-800/50 flex items-center gap-3 transition-colors">
                        <i class="fa-solid fa-database text-sm text-slate-400 w-5"></i> Bases
                    </a>
                    <a href="profile.cfm" class="text-slate-300 hover:text-cyan-400 font-medium py-2.5 border-b border-slate-800/50 flex items-center gap-3 transition-colors">
                        <i class="fa-solid fa-user text-sm text-slate-400 w-5"></i> Profil
                    </a>
                </div>
                <a href="about.cfm" class="text-slate-300 hover:text-cyan-400 text-medium transition-colors duration-200 flex items-center gap-3 mt-2 pt-2">
                    <i class="fa-solid fa-circle-info text-slate-400 w-5"></i> À propos du Serveur                    
                </a>
            </div>

            <div class="flex flex-col justify-between gap-4">
                
                <div class="bg-slate-800/40 border border-slate-800 rounded-xl p-4 flex items-center gap-4 shadow-inner">
                    
                    <a href="profile.cfm" class="relative w-12 h-12 flex-shrink-0 block group/avatar cursor-pointer" title="Voir mon profil">
                        <cfif structKeyExists(session, "avatar") AND len(session.avatar) AND fileExists(expandPath("./assets/avatars/#session.avatar#"))>
                            <img src="./assets/avatars/<cfoutput>#session.avatar#</cfoutput>" 
                                 alt="Avatar" 
                                 class="w-full h-full rounded-xl object-cover border border-slate-700/50 shadow-md group-hover/avatar:border-cyan-500/80 group-hover/avatar:scale-105 transition-all duration-300">
                        <cfelse>
                            <div class="w-full h-full rounded-xl bg-slate-800 border border-slate-700/30 flex items-center justify-center text-slate-400 group-hover/avatar:border-cyan-500/50 group-hover/avatar:text-cyan-400 transition-all duration-300">
                                <i class="fa-solid fa-user text-base"></i>
                            </div>
                        </cfif>
                        <span class="absolute -bottom-0.5 -right-0.5 w-3 h-3 bg-emerald-500 border-2 border-slate-900 rounded-full animate-pulse"></span>
                    </a>
                    
                    <div class="text-sm">
                        <p class="text-slate-500 text-xs font-semibold uppercase tracking-wider">Administrateur connecté</p>
                        <a href="profile.cfm" class="font-black text-slate-200 text-lg tracking-wide font-mono mt-0.5 block hover:text-cyan-400 transition-colors">
                            <cfoutput>#session.username#</cfoutput>
                        </a>
                    </div>
                </div>
                
                <a href="logout.cfm" class="w-full text-center bg-red-500/10 hover:bg-red-500 text-red-400 hover:text-white border border-red-500/20 py-3.5 rounded-xl text-xs font-bold uppercase tracking-wider transition-all duration-200 flex items-center justify-center gap-2 cursor-pointer">
                    <i class="fa-solid fa-power-off text-xs"></i> Déconnexion du serveur
                </a>
            </div>

        </div>
    </div>
</nav>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const btn = document.getElementById('hamburger-btn');
        const menu = document.getElementById('mobile-menu');
        const icon = document.getElementById('hamburger-icon');

        btn.addEventListener('click', function() {
            menu.classList.toggle('hidden');
            
            if (menu.classList.contains('hidden')) {
                icon.classList.remove('fa-xmark');
                icon.classList.add('fa-bars');
            } else {
                icon.classList.remove('fa-bars');
                icon.classList.add('fa-xmark');
            }
        });
    });
</script>

<footer class="w-full py-8 border-t border-slate-800/60 bg-slate-950/20 text-center mt-auto">
    <div class="max-w-7xl mx-auto px-6 flex flex-col sm:flex-row items-center justify-between gap-4 text-xs text-slate-500 font-medium">
        <div class="flex items-center gap-2">
            <i class="fa-solid fa-shield-halved text-cyan-500/70 text-sm"></i>
            <span>&copy; <cfoutput>#year(now())#</cfoutput> <span class="font-bold text-slate-400 tracking-wider">M-GAMING-STUDIO SERVER : serveur officiel</span>. Tous droits réservés.</span>
        </div>
        <div class="flex items-center gap-4 text-[11px]">
            <span class="flex items-center gap-1.5"><span class="w-1.5 h-1.5 rounded-full bg-cyan-500"></span> Core System</span>
            <span class="text-slate-600">|</span>
            <a href="privacy.cfm" class="hover:text-cyan-400 transition-colors cursor-pointer no-underline">Termes d'utilisation</a>
        </div>
    </div>
</footer>