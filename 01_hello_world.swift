import Foundation
// Controle+Shift+b = execute le terminale

/*
===========================================================
                    L'ARTÉFACT PERDU
===========================================================

Un jeu d'aventure en labyrinthe où vous incarnez un aventurier
cherchant un artefact ancien dans un donjon mystérieux.

-----------------------------------------------------------
                       HISTOIRE
-----------------------------------------------------------
Vous êtes un aventurier dans un village isolé. Votre quête est
de retrouver un artefact ancien caché dans un labyrinthe dangereux,
protégé par :
- Un Gardien qui pose des énigmes
- Un ennemi qui vous poursuit
- Des obstacles qui réduisent vos vies

-----------------------------------------------------------
                     MÉCANIQUES DU JEU
-----------------------------------------------------------
CONTROLES:
- W : Monter (↑)
- A : Aller à gauche (←)
- S : Descendre (↓)
- D : Aller à droite (→)
- Q : Quitter le jeu

ÉLÉMENTS:
- 🫅 : Votre personnage
- 💎 : Artefact (objectif)
- 🧙 : Gardien (pose une énigme)
- 👹 : Ennemi (vous poursuit)
- 🔥 : Obstacle (perte de vie)
- 🚪 : Porte (niveau suivant)
- . : Case vide
- 🧴 : Potions (gain de vie)

OBJECTIFS:
1. Trouver l'artefact (💎) pour passer au niveau suivant
2. Éviter l'ennemi (👹) qui bouge toutes les 2 secondes al&atoirement
3. Répondre aux énigmes du Gardien (🧙)
4. Atteindre la porte (🚪) pour avancer
5.Eviter les obstacles (🔥)

SYSTÈME:
- ❤️Vies: 3 au départ (perdues si obstacle/ennemi)
- ⭐Score: +10 par artefact trouvé
-⏱️ Temps: Chronomètre en cours
- 🎒Inventaire: Objets obtenus du Gardien

-----------------------------------------------------------
                     PERSONNAGES DISPONIBLES
-----------------------------------------------------------
 1.  ("🫅", "Le Prince", "Noble et courageux, avec une aura royale"),
2. ("🧛", "Le Vampire", "Puissant mais vulnérable à la lumière"),
3. ("🧝", "L'Elfe", "Rapide et agile, maître des forêts"),
4.("🥷", "Le Ninja", "Furtif et mortel, maître des ombres")


-----------------------------------------------------------
                      SALLES DISPONIBLES
-----------------------------------------------------------
1. Salle 1 - Informatique avec ordi
2. Salle 2 - Hôpital avec lit
3. Salle 3 - Bibliothèque avec cahier
4. Salle 4 - Salle des arts avec peinture
5. Salle 5 - Cuisine avec casserole
6. Salle 6 - Gymnase avec hatlete
7. Salle 7 - Laboratoire avec tube
8. Salle 8 - Jardin avec sapin
+ 3  Salles différentes = (10*10) et (20*10)
-----------------------------------------------------------
                      INTERACTIONS
-----------------------------------------------------------
GARDIEN:
Pose l'énigme: "Quel est le résultat de 2 + 2 ?"
Bonne réponse ("4") -> Obtention d'un objet (ex: carte)

PORTES:
permet d'accéder à une nouvelle salle en appuyant sur 'O' devant la porte

POTIONS:
permet d'avoir une vie supplémentaires

FIN DU JEU:
- Gagné: Terminer les 3 niveaux en trouver l'artéfact
- Perdu: Plus de vies

-----------------------------------------------------------
                      ENIGMES DU GARDIEN
-----------------------------------------------------------
Question: 2+2 REPONSE:4
Question: porte : REPONSE : Clé
Question: QUI suis-je : REPONSE: le Guardien

-----------------------------------------------------------
                      INVENTAIRE A DEBLOQUER
-----------------------------------------------------------
-Carte
-Loupe
-épée

--------------------------------------------------------------
                        ALEAS
-------------------------------------------------------------
- Entre 10 et 20 secondes : Tomber dans un troue et chosir un objet pour s'en sortir
- Entre 30 et 40 secondes : Un monstre apparait et doit se cacher pour s'en sortir
- Entre 50 et 60 secondes : Le sol commence a s'effrondrer

--------------------------------------------------------------
                        Erreur
-------------------------------------------------------------
- 4 personnages :si il selectionne un chiffre supérieur à 4 => erreur; résseayer
- 8 salles  :si il selectionne un chiffre supérieur à 8 => erreur; résseayer
- Enigmes  :si il selectionne un chiffre supérieur à 3 => erreur; résseayer


--------------------------------------------------------------------
                    Progression du Jeu
----------------------------------------------------------------------

- niveau 1 : basique 
- niveau 2 : grille s'agrandit (15*15)
- niveau 3 : bombe remplacé par le feu
- niveau 4 :apparition de fantomes
- niveau 5 : poison mortel
---------------------
+++ Système pour que le joueur peut rejouer une partie si il le souhaite
+++++SONS
===========================================================
*/

