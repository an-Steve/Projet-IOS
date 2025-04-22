# Projet-IOS

👨‍💻 Auteur

Projet réalisé dans le cadre de la Licenc 3 Informatique des Systèmes embarqués et Intéractif.
Développement par ANTON NELCON Steve.

🗺️ L'ARTÉFACT PERDU

    Un jeu d'aventure textuel en Swift, où l'on explore des labyrinthes mystérieux à la recherche d’un artefact ancien. 🧭

  🚀 Lancement : Développé en Swift avec Foundation

  📂 Organisation du code

    Fichier principal :ProjetIOS.swift (pour exécuter :  swift Examples/ProjetIOS.swift)
    Fichier : hello_world.swift : fichier explication du jeu
    Fichier  variable_swift : classes
    Fichier Json : également inclus

🎮 Présentation

L'Artéfact Perdu est un jeu d'aventure dans lequel vous incarnez un aventurier explorant des salles truffées de pièges, d’ennemis et d’énigmes. Votre mission : retrouver un artefact caché et survivre aux nombreux dangers du donjon.
📖 Histoire

Vous êtes un aventurier issu d’un village reculé. On vous a confié une mission : retrouver un artéfact légendaire, perdu dans un labyrinthe mystérieux. Mais attention, votre route est semée d’embûches :

    👹 Un ennemi vous pourchasse

    🔥 Des obstacles vous font perdre des vies

    🧙 Un gardien vous interroge avec des énigmes redoutables

🕹️ Contrôles

    W	 :Aller en haut (↑)
    A	 : Aller à gauche (←)
    S	 : Aller en bas (↓)
    D	 : Aller à droite (→)
    Q	 : Quitter le jeu
    O	 : Ouvrir une porte devant soi
    H:  Commande pour aide

🧩 Mécaniques de jeu

    ❤️ Vies : 3 au début (perdues en cas d’obstacle ou ennemi)

    💎 Objectif : trouver l'artéfact pour passer au niveau suivant

    ⭐ Score : +10 points par artefact

    🎒 Inventaire : objets gagnés auprès du gardien (carte, loupe, épée)

    ⏱️ Temps : événements aléatoires en fonction du chrono

🧙‍♂️ Le Gardien

Il pose des énigmes que vous devez résoudre pour obtenir des objets :

Quesstions :

    ❓ Quel est le résultat de 2 + 2 ? → 4

    ❓ Porte → Clé

    ❓ Qui suis-je ? → Le Gardien

🧍 Personnages jouables

    🫅 Le Prince – Noble et courageux

    🧛 Le Vampire – Puissant mais vulnérable à la lumière

    🧝 L’Elfe – Rapide et agile

    🥷 Le Ninja – Furtif et mortel

🏛️ Salles disponibles

Chaque salle possède un thème unique :

    Informatique 🖥️

    Hôpital 🏥

    Bibliothèque 📚

    Salle des arts 🎨

    Cuisine 🍳

    Gymnase 🏋️

    Laboratoire 🔬

    Jardin 🌳

     + 3 grilles supplémentaires de tailles différentes (10x10, 20x10)

💥 Événements aléatoires

    ⏱️ 10-20s : Vous tombez dans un trou — choisir un objet pour en sortir

    ⏱️ 30-40s : Un monstre apparaît — il faut se cacher

    ⏱️ 50-60s : Le sol s'effondre — réagissez vite !

🔄 Progression

    Niveau 1 : grille simple

    Niveau 2 : grille 15x15

    Niveau 3 : feu au lieu des bombes

    Niveau 4 : apparition de fantômes 👻

    Niveau 5 : poison mortel ☠️

    Rejouabilité disponible à la fin du jeu

🎵 Bonus

    Effets sonores intégrés

    Possibilité de rejouer après une partie

⚠️ Gestion des erreurs

    ❌ Mauvais choix de personnage (1 à 4)

    ❌ Mauvais choix de salle (1 à 8)

    ❌ Mauvais numéro d'énigme (1 à 3)
    → Dans tous les cas, un message d’erreur s’affiche et une nouvelle tentative est proposée.
