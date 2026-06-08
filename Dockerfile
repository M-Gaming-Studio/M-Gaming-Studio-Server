# 1. On utilise l'image officielle de Lucee
FROM lucee/lucee:latest

# 2. On copie tout votre code actuel dans le dossier web du serveur
COPY . /var/www

# 3. On indique à Lucee d'installer l'extension MongoDB au démarrage
ENV LUCEE_EXTENSIONS="C7CE82FE-3286-4554-A6A4F2A7697AEFA4"