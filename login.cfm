<cfif structKeyExists(form, "username") and structKeyExists(form, "password")>
    <cfset hashedInputPassword = hash(form.password, "SHA-512", "UTF-8")>
    
    <cftry>
        <cfset mongoClient = MongoConnect("mgamingDS")>
        <cfset mongoDB = mongoClient.getDB("mgaming_db")>
        <cfset usersCollection = mongoDB.getCollection("users")>
        
        <cfset searchFilter = {
            "username": form.username,
            "password": hashedInputPassword
        }>
        
        <cfset userData = usersCollection.findOne(searchFilter)>
        
        <cfif not isNull(userData)>
            <cfset session.isLoggedIn = true>
            <cfset session.user_id = userData["_id"].toString()>
            <cfset session.username = userData["username"]>
            <cflocation url="home.cfm" addToken="false">
        <cfelse>
            <cfset errorMessage = "Nom d'utilisateur ou mot de passe incorrect.">
        </cfif>

        <cfcatch type="any">
            <cfset errorMessage = "Erreur de connexion à la base de données : #cfcatch.message#">
        </cfcatch>
    </cftry>
</cfif>

<!DOCTYPE html>
<html lang="fr" class="bg-slate-950 text-slate-100">
<head>
    <meta charset="UTF-8">
    <title>Connexion - M-Gaming-Studio Server</title>
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="min-h-screen flex items-center justify-center font-sans antialiased bg-slate-950">

    <div class="w-full max-w-md bg-slate-900 border border-slate-800 rounded-xl p-8 shadow-2xl">
        <div class="text-center mb-8">
            <span class="text-4xl"></span>
            <h2 class="text-2xl font-bold tracking-tight mt-3 bg-gradient-to-r from-cyan-400 to-blue-500 bg-clip-text text-transparent">
                Connexion au M-Gaming-Studio Server
            </h2>
            <p class="text-slate-400 text-sm mt-1">Authentification requise</p>
        </div>

        <cfif structKeyExists(url, "success")>
            <div class="mb-6 bg-emerald-500/10 border border-emerald-500/20 text-emerald-400 text-sm p-3 rounded-lg text-center">
                <cfoutput>#url.success#</cfoutput>
            </div>
        </cfif>
        <cfif structKeyExists(variables, "errorMessage")>
            <div class="mb-6 bg-red-500/10 border border-red-500/20 text-red-400 text-sm p-3 rounded-lg text-center">
                <cfoutput>#variables.errorMessage#</cfoutput>
            </div>
        </cfif>

        <div class="absolute top-8 right-8 flex items-center gap-5 z-50 select-none">
            <div class="text-right hidden sm:block">     	
                <h1 class="text-3xl font-black tracking-tighter uppercase italic text-slate-200 leading-none">     	
                    M-Gaming- <span class="text-cyan-500">Studio</span>
                </h1>
                <p class="text-xs font-mono text-slate-400 uppercase tracking-widest mt-1.5">Créateur du serveur</p>
                <p class="text-[15px] font-mono text-slate-600 mt-1">version 1.0.0</p>
            </div>
            <div class="w-32 h-32 bg-slate-900/95 backdrop-blur-md border border-slate-800 rounded-[1.5rem] flex items-center justify-center shadow-2xl p-4.5 hover:border-cyan-500/60 transition-all duration-500 group">
                <img src="./assets/img/logo.png" alt="Logo" class="w-full h-full object-contain filter drop-shadow-[0_0_12px_rgba(34,211,238,0.3)] group-hover:scale-105 transition-transform duration-500">
            </div>
        </div>

        <form action="login.cfm" method="POST" class="space-y-5">
            <div>
                <label for="username" class="block text-sm font-medium text-slate-300 mb-1">Nom d'utilisateur</label>
                <input type="text" id="username" name="username" required class="w-full bg-slate-950 border border-slate-800 rounded-lg px-4 py-2.5 text-slate-100 placeholder-slate-600 focus:outline-none focus:border-cyan-500 transition-colors">
            </div>
            
            <div>
                <label for="password" class="block text-sm font-medium text-slate-300 mb-1">Mot de passe</label>
                <div class="relative flex items-center">
                    <input type="password" id="password" name="password" required placeholder="" class="w-full bg-slate-950 border border-slate-800 rounded-lg pl-4 pr-10 py-2.5 text-slate-100 placeholder-slate-600 focus:outline-none focus:border-cyan-500 transition-colors">
                    <button type="button" id="togglePassword" class="absolute right-3 text-slate-500 hover:text-cyan-400 transition-colors cursor-pointer focus:outline-none">
                        <i class="fa-solid fa-eye" id="eyeIcon"></i>
                    </button>
                </div>
            </div>

            <button type="submit" class="w-full bg-gradient-to-r from-cyan-500 to-blue-600 hover:from-cyan-400 hover:to-blue-500 text-slate-950 font-bold py-3 rounded-lg transition-all duration-200 shadow-lg shadow-cyan-500/10 mt-2">
                Se connecter
            </button>
        </form>

        <div class="mt-6 text-center text-sm">
            <a href="inscription.cfm" class="text-cyan-400 hover:underline">Pas encore de compte ? S'inscrire</a>
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
            // Basculer l'attribut type entre password et text
            const isPassword = passwordInput.getAttribute('type') === 'password';
            passwordInput.setAttribute('type', isPassword ? 'text' : 'password');
            
            // Modifier les icônes de Font Awesome
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
