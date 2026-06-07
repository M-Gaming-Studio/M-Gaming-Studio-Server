<!DOCTYPE html>
<html lang="fr" class="bg-slate-950 text-slate-100">
<head>
    <meta charset="UTF-8">
    <title>Inscription - M-Gaming Studio Server</title>
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="min-h-screen flex items-center justify-center font-sans antialiased bg-slate-950">

    <div class="w-full max-w-md bg-slate-900 border border-slate-800 rounded-xl p-8 shadow-2xl">
        <div class="text-center mb-8">
            <span class="text-4xl"></span>
            <h2 class="text-2xl font-bold tracking-tight mt-3 bg-gradient-to-r from-cyan-400 to-blue-500 bg-clip-text text-transparent">
                Inscrivez-vous et créer un compte 
            </h2>
            <p class="text-slate-400 text-sm mt-1">* Vous devez remplir ces champs obligatoirement</p>
        </div>

        <cfif structKeyExists(url, "error")>
            <div class="mb-6 bg-red-500/10 border border-red-500/20 text-red-400 text-sm p-3 rounded-lg text-center">
                <cfoutput>#url.error#</cfoutput>
            </div>
        </cfif>

        <form action="save_user.cfm" method="POST" class="space-y-5">
            <div>
                <label for="username" class="block text-sm font-medium text-slate-300 mb-1">* Nom d'utilisateur</label>
                <input type="text" id="username" name="username" required class="w-full bg-slate-950 border border-slate-800 rounded-lg px-4 py-2.5 text-slate-100 placeholder-slate-600 focus:outline-none focus:border-cyan-500 transition-colors">
            </div>
            
            <div>
                <label for="email" class="block text-sm font-medium text-slate-300 mb-1">* Adresse Email</label>
                <input type="email" id="email" name="email" required class="w-full bg-slate-950 border border-slate-800 rounded-lg px-4 py-2.5 text-slate-100 placeholder-slate-600 focus:outline-none focus:border-cyan-500 transition-colors">
            </div>
            
            <div>
                <label for="password" class="block text-sm font-medium text-slate-300 mb-1">* Mot de passe</label>
                <div class="relative flex items-center">
                    <input type="password" id="password" name="password" required class="w-full bg-slate-950 border border-slate-800 rounded-lg pl-4 pr-10 py-2.5 text-slate-100 placeholder-slate-600 focus:outline-none focus:border-cyan-500 transition-colors">
                    <button type="button" id="togglePassword" class="absolute right-3 text-slate-500 hover:text-cyan-400 transition-colors cursor-pointer focus:outline-none">
                        <i class="fa-solid fa-eye" id="eyeIcon"></i>
                    </button>
                </div>
            </div>

            <div class="flex items-start gap-3 pt-1">
                <div class="flex items-center h-5">     	
                    <input id="privacy" name="privacy" type="checkbox" required     	
                    class="w-4 h-4 bg-slate-950 border-slate-800 rounded text-cyan-500 focus:ring-cyan-500/50 focus:ring-2 accent-cyan-500 cursor-pointer">
                </div>
                <div class="text-xs text-slate-400 leading-tight">
                    <label for="privacy" class="cursor-pointer select-none" required>     	
                        Vous acceptez que vos données soient stockées conformément à la Politique de Confidentialité dans le serveur.                  	
                    </label>
                </div>
            </div>

            <button type="submit" class="w-full bg-gradient-to-r from-cyan-500 to-blue-600 hover:from-cyan-400 hover:to-blue-500 text-slate-950 font-bold py-3 rounded-lg transition-all duration-200 shadow-lg shadow-cyan-500/10 mt-2">
                S'inscrire
            </button>
        </form>

        <div class="mt-6 text-center text-sm">
            <a href="login.cfm" class="text-cyan-400 hover:underline">Déjà un compte ? Se connecter</a>
        </div>
    </div>

    <footer class="absolute bottom-0 left-0 w-full py-6 bg-slate-950/40 backdrop-blur-sm border-t border-slate-900 text-center z-10">
        <div class="max-w-7xl mx-auto px-6 flex flex-col sm:flex-row items-center justify-between gap-3 text-[11px] text-slate-500 font-medium">     	
            <div class="flex items-center gap-2">     	
                <i class="fa-solid fa-shield-halved text-cyan-500/50 text-xs"></i>     	
                <span>&copy; <cfoutput>#year(now())#</cfoutput> <span class="font-bold text-slate-400 tracking-wider">M-GAMING-STUDIO SERVER : serveur officiel</span>. Tous droits réservés.</span>
            </div>
            <div class="flex items-center gap-4">
                <span class="flex items-center gap-1.5"><span class="w-1 h-1 rounded-full bg-cyan-500/70"></span> Security Node</span>     	
                <span class="text-slate-800">|</span>
            </div>
        </div>
    </footer>

    <script>
        const togglePassword = document.querySelector('#togglePassword');
        const passwordInput = document.querySelector('#password');
        const eyeIcon = document.querySelector('#eyeIcon');

        togglePassword.addEventListener('click', function () {
            const isPassword = passwordInput.getAttribute('type') === 'password';
            passwordInput.setAttribute('type', isPassword ? 'text' : 'password');
            
            if (isPassword) {
                eyeIcon.classList.remove('fa-eye');
                eyeIcon.classList.add('fa-eye-slash');
            } else {
                eyeIcon.classList.remove('fa-eye-slash');
                eyeIcon.classList.add('fa-eye');
            }
        });
    </script>

</body>
</html>