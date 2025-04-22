import Foundation
#if canImport(AppKit)
import AppKit
#endif

// Définir la taille de la grille
var gridWidth = 10
var gridHeight = 10

// Position initiale du personnage
var playerX = 4
var playerY = 4

// Position de l'artefact
var artifactX = 7
var artifactY = 7

// Position des obstacles
var obstacles: [(x: Int, y: Int)] = [(2, 2), (3, 5), (6, 6), (5, 8)]
var flamesTransformedToBombs = false

var ghosts: [(x: Int, y: Int)] = [] // Position des fantômes (niveau 4)

// Position des poisons (niveau 5)
var poisons: [(x: Int, y: Int)] = []
let poisonEmoji = "☠️"
let poisonColor = "\u{001B}[31m"  // Rouge

// Position du Gardien
let guardianX = 5
let guardianY = 5

// Position de la porte
var doorX = 9
var doorY = 8

// Potions
let potionEmoji = "🧴"
let potionColor = "\u{001B}[38;5;213m"  // Rose pastel

// Positions des potions
var potions: [(x: Int, y: Int)] = []
var isInHole = false //variable pour suivre l'état du trou

// Position initiale de l'ennemi
var enemyX = Int.random(in: 0..<gridWidth)
var enemyY = Int.random(in: 0..<gridHeight)

// Personnages décoratifs
var decorativeCharacters: [(emoji: String, x: Int, y: Int, sound: String)] = [
    ("🐱", Int.random(in: 0..<gridWidth), Int.random(in: 0..<gridHeight), "Miaou !"),
    ("🐶", Int.random(in: 0..<gridWidth), Int.random(in: 0..<gridHeight), "Wouaf Wouaf !"),
    ("🐭", Int.random(in: 0..<gridWidth), Int.random(in: 0..<gridHeight), "Couic !"),
    ("🐦", Int.random(in: 0..<gridWidth), Int.random(in: 0..<gridHeight), "Cui Cui !")
]

func getAnimalName(emoji: String) -> String {
    switch emoji {
    case "🐱": return "le chat"
    case "🐶": return "le chien"
    case "🐭": return "la souris"
    case "🐦": return "l'oiseau"
    default: return "l'animal"
    }
}

// Variables du jeu
var lives = 3
var score = 0
var level = 1
var timeElapsed = 0
var inventory: [String] = []  // Inventaire du joueur

// Définir les personnages disponibles
let characters = [
    ("🫅", "Le Prince", "Noble et courageux, avec une aura royale"),
    ("🧛", "Le Vampire", "Puissant mais vulnérable à la lumière"),
    ("🧝", "L'Elfe", "Rapide et agile, maître des forêts"),
    ("🥷", "Le Ninja", "Furtif et mortel, maître des ombres")
]

// Liste des salles
let rooms = [
    "\u{001B}[1;33m🏫 Salle 1 - Informatique\u{001B}[0;0m",     // Salle informatique
    "\u{001B}[1;34m🏥 Salle 2 - Hôpital\u{001B}[0;0m",         // Salle hôpital
    "\u{001B}[1;35m📚 Salle 3 - Bibliothèque\u{001B}[0;0m",    // Salle bibliothèque
    "\u{001B}[1;36m🎨 Salle 4 - Salle des arts\u{001B}[0;0m",  // Salle des arts
    "\u{001B}[1;32m🍴 Salle 5 - Cuisine\u{001B}[0;0m",        // Salle cuisine
    "\u{001B}[1;31m🤸 Salle 6 - Gymnase\u{001B}[0;0m",    // Salle gymnase
    "\u{001B}[1;37m🔬 Salle 7 - Laboratoire\u{001B}[0;0m",    // Salle laboratoire
    "\u{001B}[1;33m🌳 Salle 8 - Jardin\u{001B}[0;0m"         // Salle jardin
]



// Demander le nom du joueur
let darkBlue = "\u{001B}[0;34m"


//Afficher la date et l'heure
func getCurrentDateTime() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .medium
    dateFormatter.timeStyle = .medium
    dateFormatter.locale = Locale(identifier: "fr_FR") // Pour un affichage en français
    return dateFormatter.string(from: Date())
}

// Fonction pour centrer un texte dans le terminal avec les codes ANSI retirés pour le calcul
func centerText(_ text: String, width: Int = 80) -> String {
    let strippedText = text.replacingOccurrences(of: "\u{001B}\\[[0-9;]*m", with: "", options: .regularExpression)
    let spaces = max((width - strippedText.count) / 2, 0)
    return String(repeating: " ", count: spaces) + text
}

// Fonction pour encadrer un texte (ligne par ligne)
func framedText(_ lines: [String], width: Int = 80) -> String {
    let border = "+" + String(repeating: "-", count: width - 2) + "+"
    var framedLines = [border]
    for line in lines {
        let centered = centerText(line, width: width - 2)
        framedLines.append("|" + centered + "|")
    }
    framedLines.append(border)
    return framedLines.joined(separator: "\n")
}

// Codes ANSI
let red = "\u{001B}[0;31m"
let reset = "\u{001B}[0;0m"
let bold = "\u{001B}[1m"
let green = "\u{001B}[32m"

// Contenu
let title = "\(red)\(bold)Bienvenue sur L'Artéfact Perdu !\(reset)"
let authorLine1 = "\(red)PROJET RÉALISÉ PAR \(bold)ANTON NELCON STEVE\(reset)"
let authorLine2 = "\(red)ÉTUDIANT EN \(bold)L3 ISEI\(reset)"
let authorLine3 = "\(red)À L'\(bold)UNIVERSITÉ PARIS 8\(reset)"

// Création du cadre
let framed = framedText([title, "", authorLine1, authorLine2, authorLine3])
print(framed)

print()
print("Salut ! Comment t'appelles-tu ?")


if let playerName = readLine() {
    print("Bienvenue, \(darkBlue)\(playerName)\(reset) !")

    //Affichage de l'histoire et des instructions
    printStory(playerName: playerName, characterName: "vous")
    printInstructions()

    print("\n\(green)══════════════════════════════════════════════\(reset)")
    print("\(green)          L'AVENTURE COMMENCE !          \(reset)")
    print("\(green)══════════════════════════════════════════════\(reset)\n")

    // Sélection du personnage
    let selectedCharacter = selectCharacter()
    let playerEmoji = selectedCharacter.emoji
    let characterName = selectedCharacter.name

    print("\n\(bold("Vous avez choisi: \(playerEmoji) \(characterName)"))\(reset)")
    print("\(selectedCharacter.description)\n")


func selectCharacter() -> (emoji: String, name: String, description: String) {
    print("\n\(bold("Choisis ton personnage:"))\(reset)")
    for (index, character) in characters.enumerated() {
        print("\(index + 1). \(character.0) \(character.1) - \(character.2)")
    }

    while true {
        print("\nEntrez le numéro de votre choix (1-4):")
        if let input = readLine(),
           let choice = Int(input),
           choice >= 1 && choice <= 4 {
            return characters[choice-1]
        }
       print("\(bold("Choix invalide."))\(reset) Veuillez entrer un nombre entre 1 et 4.")
    }
}

//Fonction pour l'histoire
func printStory(playerName: String, characterName: String) {
    let titleColor = "\u{001B}[1;35m"
    let textColor = "\u{001B}[0;36m"
    let playerColor = "\u{001B}[1;34m"
    let dangerColor = "\u{001B}[1;31m"
    let artifactColor = "\u{001B}[1;32m"
    let npcColor = "\u{001B}[1;33m"
    let reset = "\u{001B}[0m"

    print("""
    \(titleColor)╔══════════════════════════════════════════════════════════════════════════════════╗
    ║                                📖 HISTOIRE DE L’AVENTURE                                ║
    ╠══════════════════════════════════════════════════════════════════════════════════╣\(reset)
    \(textColor)║ Dans un village reculé, un aventurier nommé \(playerColor)\(playerName)\(textColor) (\(characterName)) se prépare.      ║
    ║ Il part à la recherche d'un \(artifactColor)artefact ancien 💎\(textColor), caché dans un lieu oublié.       ║
    ║ Ce lieu est un \(dangerColor)labyrinthe maudit 🔥\(textColor), protégé par des pièges et créatures.       ║
    ║                                                                                  ║
    ║ 👁 Un mystérieux \(npcColor)Gardien 🧙\(textColor) défend ce dédale. Seuls les esprits vifs passeront. ║
    ║                                                                                  ║
    ║ \(dangerColor)⚠️ Attention ! Une créature implacable 👹 rôde dans les ténèbres...             \(textColor)║
    ║                                                                                  ║
    ║ \(playerColor)\(playerName)\(textColor), ta mission sera de :                                                   ║
    ║   \(dangerColor)☠️ Éviter les pièges mortels                                                  \(textColor)║
    ║   👹 Fuir l'ennemi sans te faire repérer                                        ║
    ║   � Résoudre les énigmes du \(npcColor)Gardien\(textColor)                                             ║
    ║   💎 Trouver l'\(artifactColor)artefact magique\(textColor) pour t'en sortir vivant                         ║
    ║                                                                                                              ║
    ║ ⏳ Le temps est compté. Chaque décision peut changer ton destin.                 ║
    ║ Bonne chance, \(playerColor)\(playerName)\(textColor) !                                                        ║
    \(titleColor)╚══════════════════════════════════════════════════════════════════════════════════╝\(reset)
    """)
}

    // Demander dans quelle salle le joueur veut aller
func chooseRoom() -> String {
    print("Dans quelle salle veux-tu aller ? Voici les options :")
    for (index, room) in rooms.enumerated() {
        print("\(index + 1). \(room)")
    }
    print("Choisis un numéro (1 à 8) :")

        if let input = readLine(), let roomNumber = Int(input), roomNumber >= 1, roomNumber <= 8 {
            return rooms[roomNumber - 1]
        } else {
            print("Choix invalide. Essayez de nouveau.")
            return chooseRoom() // Redemander si le choix est invalide
        }
    }
// Fonction pour déplacer l'ennemi en temps réel
func moveEnemy() {
    DispatchQueue.global(qos: .background).async {
        while true {
            sleep(2) // L'ennemi se déplace toutes les 2 secondes

            // Déplacer l'ennemi aléatoirement
            let direction = Int.random(in: 0..<4)
            switch direction {
            case 0: // Haut
                if enemyY > 0 { enemyY -= 1 }
            case 1: // Bas
                if enemyY < gridHeight - 1 { enemyY += 1 }
            case 2: // Gauche
                if enemyX > 0 { enemyX -= 1 }
            case 3: // Droite
                if enemyX < gridWidth - 1 { enemyX += 1 }
            default:
                break
            }

            // Vérifier si l'ennemi touche le joueur
            let purple = "\u{001B}[35m"  // Code ANSI violet
            let reset = "\u{001B}[0m"    // Réinitialisation
            let red = "\u{001B}[31m"  // Code ANSI pour rouge
            if enemyX == playerX && enemyY == playerY {
                lives -= 1
                print("\(purple)L'ennemi vous a attrapé ! Il vous reste \(lives) vies.\(reset)")
                if lives == 0 {
                    print("\(red)Game over ! Vous avez perdu toutes vos vies.\(reset)")
                    exit(0)
                }
            }
        }
    }
}

// Démarrer le déplacement de l'ennemi
moveEnemy()

func generateGhosts() {
    ghosts.removeAll()
    let numberOfGhosts = 12  // 12 fantômes pour le niveau 4

    for _ in 0..<numberOfGhosts {
        var x, y: Int
        repeat {
            x = Int.random(in: 0..<gridWidth)
            y = Int.random(in: 0..<gridHeight)
        } while (x == playerX && y == playerY) ||
               (x == artifactX && y == artifactY) ||
               (x == guardianX && y == guardianY) ||
               (x == doorX && y == doorY) ||
               (x == enemyX && y == enemyY) ||
               isObstacle(x: x, y: y) ||
               ghosts.contains(where: { $0.x == x && $0.y == y })

        ghosts.append((x: x, y: y))
    }
}

func moveGhosts() {
    DispatchQueue.global(qos: .background).async {
        while true {
            sleep(3) // Les fantômes se déplacent toutes les 3 secondes

            for i in 0..<ghosts.count {
                // Choisir une direction aléatoire
                let direction = Int.random(in: 0..<4)
                var newX = ghosts[i].x
                var newY = ghosts[i].y

                switch direction {
                case 0: // Haut
                    if newY > 0 { newY -= 1 }
                case 1: // Bas
                    if newY < gridHeight - 1 { newY += 1 }
                case 2: // Gauche
                    if newX > 0 { newX -= 1 }
                case 3: // Droite
                    if newX < gridWidth - 1 { newX += 1 }
                default:
                    break
                }

                // Vérifier que la nouvelle position est libre
                if !isObstacle(x: newX, y: newY) &&
                   !(newX == playerX && newY == playerY) &&
                   !(newX == artifactX && newY == artifactY) &&
                   !(newX == guardianX && newY == guardianY) &&
                   !(newX == doorX && newY == doorY) &&
                   !(newX == enemyX && newY == enemyY) {

                    ghosts[i].x = newX
                    ghosts[i].y = newY
                }
            }
        }
    }
}

//Poison
func generatePoisons() {
    poisons.removeAll()
    let numberOfPoisons = 5  // Nombre de poisons pour le niveau 5

    for _ in 0..<numberOfPoisons {
        var x, y: Int
        repeat {
            x = Int.random(in: 0..<gridWidth)
            y = Int.random(in: 0..<gridHeight)
        } while (x == playerX && y == playerY) ||
               (x == artifactX && y == artifactY) ||
               (x == guardianX && y == guardianY) ||
               (x == doorX && y == doorY) ||
               (x == enemyX && y == enemyY) ||
               isObstacle(x: x, y: y) ||
               poisons.contains(where: { $0.x == x && $0.y == y }) ||
               potions.contains(where: { $0.x == x && $0.y == y })

        poisons.append((x: x, y: y))
    }
}
// Fonction pour déplacer les personnages décoratifs
func moveDecorativeCharacters() {
    DispatchQueue.global(qos: .background).async {
        while true {
            sleep(2) // Se déplacent toutes les 2 secondes

            for i in 0..<decorativeCharacters.count {
                // Choisir une direction aléatoire
                let direction = Int.random(in: 0..<4)
                var newX = decorativeCharacters[i].x
                var newY = decorativeCharacters[i].y

                switch direction {
                case 0: // Haut
                    if newY > 0 { newY -= 1 }
                case 1: // Bas
                    if newY < gridHeight - 1 { newY += 1 }
                case 2: // Gauche
                    if newX > 0 { newX -= 1 }
                case 3: // Droite
                    if newX < gridWidth - 1 { newX += 1 }
                default:
                    break
                }

                // Vérifier que la nouvelle position est libre
                if !isObstacle(x: newX, y: newY) &&
                   !(newX == playerX && newY == playerY) &&
                   !(newX == artifactX && newY == artifactY) &&
                   !(newX == guardianX && newY == guardianY) &&
                   !(newX == doorX && newY == doorY) &&
                   !(newX == enemyX && newY == enemyY) {

                    decorativeCharacters[i].x = newX
                    decorativeCharacters[i].y = newY
                }
            }
        }
    }
}

// Démarrer le déplacement des personnages décoratifs
moveDecorativeCharacters()

//Rencontrer avec les animaux
func checkAnimalEncounter(playerName: String) {
    for (index, animal) in decorativeCharacters.enumerated() {
        if playerX == animal.x && playerY == animal.y {
            print("\u{0007}") // Bip système
            print("\u{001B}[33m\(animal.sound)\u{001B}[0m") // Afficher le son

            print("\nVoulez-vous caresser l'animal ? (O/N)")
            if let response = readLine()?.lowercased() {
                if response == "o" {
                    print("\u{001B}[32m\(playerName) caresse \(getAnimalName(emoji: animal.emoji)) !\u{001B}[0m")
                    print("\(animal.emoji) \u{001B}[33m♥\u{001B}[0m")
                    print("\u{001B}[32m✨ Vous avez carressez l'animal \u{001B}[0m")

                } else {
                    print("\u{001B}[34m\(playerName) continue son chemin...\u{001B}[0m")
                }
            }

            // Déplacer l'animal après l'interaction
            DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
                var newX, newY: Int
                repeat {
                    newX = Int.random(in: 0..<gridWidth)
                    newY = Int.random(in: 0..<gridHeight)
                } while (newX == playerX && newY == playerY) ||
                       isObstacle(x: newX, y: newY) ||
                       (newX == artifactX && newY == artifactY) ||
                       (newX == guardianX && newY == guardianY) ||
                       (newX == doorX && newY == doorY) ||
                       (newX == enemyX && newY == enemyY)

                decorativeCharacters[index].x = newX
                decorativeCharacters[index].y = newY
            }

            break // Ne traiter qu'une rencontre à la fois
        }
    }
}


//Affiche les instructions du Jeu
func printInstructions() {
    // Définition des couleurs avec des noms plus descriptifs
    let titleStyle = "\u{001B}[1;35m"      // Violet gras pour les titres
    let textStyle = "\u{001B}[0;36m"       // Cyan pour le texte normal
    let ruleStyle = "\u{001B}[0;33m"       // Jaune pour les séparateurs
    let resetStyle = "\u{001B}[0m"         // Réinitialisation

    // Styles pour les éléments interactifs
    let playerStyle = "\u{001B}[1;34m"     // Joueur en bleu
    let artifactStyle = "\u{001B}[1;32m"   // Artefact en vert
    let dangerStyle = "\u{001B}[1;31m"     // Dangers en rouge
    let npcStyle = "\u{001B}[1;33m"        // PNJ en jaune

    let thickHorizontalLine = "╔══════════════════════════════════════════════╗"
    let thickHorizontalLineEnd = "╚══════════════════════════════════════════════╝"

    print("""
    \(titleStyle)\(thickHorizontalLine)
    ║          📜  INSTRUCTIONS  📜                ║
    \(thickHorizontalLineEnd)

    \(textStyle)\(playerStyle)\(playerName)\(textStyle), en tant que \(playerStyle) 🫅  \(textStyle)aventurier, ton objectif est de retrouver l'artefact magique \(artifactStyle)💎 \(textStyle)dissimulé dans ce labyrinthe.

    \(ruleStyle)►  MOUVEMENTS  ◄
    \(textStyle)W \(ruleStyle)(↑) Haut        \(textStyle)A \(ruleStyle)(←) Gauche
    \(textStyle)S \(ruleStyle)(↓) Bas         \(textStyle)D \(ruleStyle)(→) Droite

    \(ruleStyle)►  ÉLÉMENTS DU JEU  ◄
    \(playerStyle)🫅 \(textStyle)= Vous         \(npcStyle)🧙 \(textStyle)= Gardien
    \(artifactStyle)💎 \(textStyle)= Artefact    \(dangerStyle)👹 \(textStyle)= Ennemi
    \(dangerStyle)🔥 \(textStyle)= Piège       \(dangerStyle)🧴 \(textStyle)= Potion

    \(ruleStyle)►  RÈGLES DU JEU  ◄
    \(textStyle)- Trouvez \(artifactStyle)💎 \(textStyle)pour remporter la victoire
    - Évitez \(dangerStyle)🔥 \(textStyle)et \(dangerStyle)👹 \(textStyle)(ils réduisent votre santé)
    - Résolvez les énigmes du \(npcStyle)🧙 \(textStyle)pour obtenir des objets
    - Collectez des \(dangerStyle)🧴 \(textStyle)pour restaurer votre santé
    - Utilisez \(ruleStyle)Q \(textStyle)pour quitter le jeu à tout moment

    \(textStyle)Bonne chance, noble aventurier ! Que l'aventure commence !\(resetStyle)
    """)
    print()
}




    // Demander dans quelle salle le joueur veut aller
    let selectedRoom = chooseRoom()
    print("Vous avez choisi d'aller dans \(selectedRoom).")
    generatePotions()

    // Démarrer le timer en arrière-plan
    func startTimer() {
        DispatchQueue.global(qos: .background).async {
            while true {
                sleep(1) // Attendre une seconde
                timeElapsed += 1
            }
        }
    }

    // Timer en arrière-plan
    startTimer()

func generatePotions() {
    potions.removeAll()
    let numberOfPotions = 3  // Nombre de potions par niveau

    for _ in 0..<numberOfPotions {
        var x, y: Int
        repeat {
            x = Int.random(in: 1..<(gridWidth-1))
            y = Int.random(in: 1..<(gridHeight-1))
        } while isObstacle(x: x, y: y) ||
               (x == playerX && y == playerY) ||
               (x == artifactX && y == artifactY) ||
               potions.contains(where: { $0.x == x && $0.y == y })

        potions.append((x, y))
    }
}

func checkPotionCollision() {
    if let index = potions.firstIndex(where: { $0.x == playerX && $0.y == playerY }) {
        lives += 1
        potions.remove(at: index)
        playSound(type: "potion")
        print("\n\(potionColor)✦ Potion récupérée ! (+1 vie) Vous avez actuellement \(lives) vies.✦\(reset)")
    }
}

func transformGridForLevel2() {
    // Changer la taille de la grille pour le niveau 2
    gridWidth = 15
    gridHeight = 15

    // Positionner le joueur au centre
    playerX = gridWidth / 2
    playerY = gridHeight / 2

    // Repositionner l'artefact
    repeat {
        artifactX = Int.random(in: 2..<(gridWidth-2))
        artifactY = Int.random(in: 2..<(gridHeight-2))
    } while (artifactX == playerX && artifactY == playerY)

    // Ajouter plus d'obstacles pour le niveau 2
    obstacles = []
    for _ in 0..<10 {
        var x, y: Int
        repeat {
            x = Int.random(in: 0..<gridWidth)
            y = Int.random(in: 0..<gridHeight)
        } while (x == playerX && y == playerY) ||
               (x == artifactX && y == artifactY) ||
               obstacles.contains(where: { $0.x == x && $0.y == y })

        obstacles.append((x: x, y: y))
    }

    // Repositionner l'ennemi
    repeat {
        enemyX = Int.random(in: 0..<gridWidth)
        enemyY = Int.random(in: 0..<gridHeight)
    } while (enemyX == playerX && enemyY == playerY) ||
           (enemyX == artifactX && enemyY == artifactY)

    // Régénérer les potions
    generatePotions()

    print("\u{001B}[32mLa grille s'agrandit pour le niveau 2 ! Plus d'obstacles apparaissent...\u{001B}[0m")
}

//Fonctions grille
func printGrid() {
    // Couleurs
    let Joueur = "\u{001B}[0;34m" // Bleu pour joueur
    let green = "\u{001B}[0;32m" // Vert
    let Gardien = "\u{001B}[0;33m" // Jaune gardien
    let brown = "\u{001B}[38;5;94m" // Marron
    let enemyColor = "\u{001B}[0;35m" // Violet ennemi
    let fire = "\u{001B}[0;31m" // Rouge feu
    _ = "\u{001B}[0;35m" // Violet (non utilisé)
    let blue = "\u{001B}[0;36m" // Bleu clair
    let white = "\u{001B}[0;37m" // Blanc
    let cyan = "\u{001B}[0;36m" // Cyan
    let yellow = "\u{001B}[0;33m" // Jaune
    let orange = "\u{001B}[0;33m" // Orange
    let pink = "\u{001B}[0;35m" // Rose
    let potionColor = "\u{001B}[38;5;213m" // Rose pastel pour potions
    let reset = "\u{001B}[0;0m" // Reset
    let boldUnderline = "\u{001B}[1;4m" // Gras+souligné

    // Éléments décoratifs selon la salle
    let tree = "🌲"
    let books = "📚"
    let computer = "💻"
    let hospitalBed = "🛏️"
    let testTube = "🧪"
    let dumbbell = "🏋️"
    let cookingPan = "🍳"
    let paintPalette = "🎨"
    let potionEmoji = "🧴"

    // Coins
    let corners = [
        (0, 0),
        (gridWidth - 1, 0),
        (0, gridHeight - 1),
        (gridWidth - 1, gridHeight - 1)
    ]

    // Dessin grille
    for y in 0..<gridHeight {
        for x in 0..<gridWidth {
            // Éléments spéciaux coins
            if corners.contains(where: { $0.0 == x && $0.1 == y }) {
                if selectedRoom.contains("Jardin") {
                    print("\(green)\(tree)\(reset)", terminator: " ")
                } else if selectedRoom.contains("Bibliothèque") {
                    print("\(brown)\(books)\(reset)", terminator: " ")
                } else if selectedRoom.contains("Informatique") {
                    print("\(blue)\(computer)\(reset)", terminator: " ")
                } else if selectedRoom.contains("Hôpital") {
                    print("\(white)\(hospitalBed)\(reset)", terminator: " ")
                } else if selectedRoom.contains("Laboratoire") {
                    print("\(cyan)\(testTube)\(reset)", terminator: " ")
                } else if selectedRoom.contains("Gymnase") {
                    print("\(yellow)\(dumbbell)\(reset)", terminator: " ")
                } else if selectedRoom.contains("Cuisine") {
                    print("\(orange)\(cookingPan)\(reset)", terminator: " ")
                } else if selectedRoom.contains("Salle des arts") {
                    print("\(pink)\(paintPalette)\(reset)", terminator: " ")
                } else {
                    print(".", terminator: " ")
                }
            }

            // Éléments jeu (par ordre de priorité)
            else if x == playerX && y == playerY {
                if isInHole {
                    print("🕳️", terminator: " ")
                } else {
                    print("\(Joueur)\(playerEmoji)\(reset)", terminator: " ")
                }
            }
            else if x == artifactX && y == artifactY {
                print("\(green)💎\(reset)", terminator: " ")
            }
            else if x == guardianX && y == guardianY {
                print("\(Gardien)🧙\(reset)", terminator: " ")
            }
            else if x == doorX && y == doorY {
                print("\(brown)🚪\(reset)", terminator: " ")
            }
            else if x == enemyX && y == enemyY {
                print("\(enemyColor)👹\(reset)", terminator: " ")
            }
            else if ghosts.contains(where: { $0.x == x && $0.y == y }) {
                print("\u{001B}[0;37m👻\u{001B}[0m", terminator: " ")
            }
            else if obstacles.contains(where: { $0.x == x && $0.y == y }) {
                if level >= 3 && flamesTransformedToBombs {
                    print("\(fire)💣\(reset)", terminator: " ")
                } else {
                    print("\(fire)🔥\(reset)", terminator: " ")
                }
            }
            else if potions.contains(where: { $0.x == x && $0.y == y }) {
                print("\(potionColor)\(potionEmoji)\(reset)", terminator: " ")
            }
            else if let decorativeChar = decorativeCharacters.first(where: { $0.x == x && $0.y == y }) {
                print("\(decorativeChar.emoji)", terminator: " ")
            }
            else if poisons.contains(where: { $0.x == x && $0.y == y }) {
                 print("\(poisonColor)\(poisonEmoji)\(reset)", terminator: " ")
            }
            else {
                print(".", terminator: " ")
            }
        }
        print()
    }

// Légende
print("\n\(boldUnderline)Légende:\(reset)")
print("\(Joueur)\(playerEmoji)\(reset): Joueur    \(green)💎\(reset): Artefact    \(Gardien)🧙\(reset): Gardien    \(brown)🚪\(reset): Porte")
print("\(potionColor)🧴\(reset): Potion    🐱🐶🐭🐦: Animaux    \(fire)\(level >= 3 ? "💣" : "🔥")\(reset): \(level >= 3 ? "Bombe" : "Obstacle")    \(enemyColor)👹👻\(reset): Ennemi\(level == 5 ? "    \(poisonColor)☠️\(reset): Poison" : "")")

// Légendes spécifiques aux salles
if selectedRoom.contains("Jardin") { print("\(green)\(tree)\(reset): Arbre") }
if selectedRoom.contains("Bibliothèque") { print("\(brown)\(books)\(reset): Livres") }
if selectedRoom.contains("Informatique") { print("\(blue)\(computer)\(reset): Ordinateur") }
if selectedRoom.contains("Hôpital") { print("\(white)\(hospitalBed)\(reset): Lit") }
if selectedRoom.contains("Laboratoire") { print("\(cyan)\(testTube)\(reset): Éprouvette") }
if selectedRoom.contains("Gymnase") { print("\(yellow)\(dumbbell)\(reset): Haltère") }
if selectedRoom.contains("Cuisine") { print("\(orange)\(cookingPan)\(reset): Casserole") }
if selectedRoom.contains("Salle des arts") { print("\(pink)\(paintPalette)\(reset): Palette") }
    print()
}

    // Fonction pour obtenir l'entrée de l'utilisateur
    func getInput() -> String? {
        let input = readLine()
        return input?.lowercased()
    }

    // Fonction pour vérifier si une case est un obstacle
    func isObstacle(x: Int, y: Int) -> Bool {
        return obstacles.contains(where: { $0.x == x && $0.y == y })
    }

    // Fonction pour réinitialiser le niveau
func resetLevel() {
    // Réinitialisation du joueur
    playerX = gridWidth / 2
    playerY = gridHeight / 2
    isInHole = false

    // Position aléatoire de l'artefact (en évitant les bords)
    repeat {
        artifactX = Int.random(in: 2..<(gridWidth-2))
        artifactY = Int.random(in: 2..<(gridHeight-2))
    } while (artifactX == playerX && artifactY == playerY) ||
           isObstacle(x: artifactX, y: artifactY)

    // Position aléatoire de l'ennemi
    repeat {
        enemyX = Int.random(in: 0..<gridWidth)
        enemyY = Int.random(in: 0..<gridHeight)
    } while (enemyX == playerX && enemyY == playerY) ||
           (enemyX == artifactX && enemyY == artifactY) ||
           isObstacle(x: enemyX, y: enemyY)

    // Obstacles fixes + aléatoires
    obstacles = [
        (2, 2), (3, 5), (6, 6), (5, 8),  // Obstacles fixes
        (Int.random(in: 1..<gridWidth), Int.random(in: 1..<gridHeight)),
        (Int.random(in: 1..<gridWidth), Int.random(in: 1..<gridHeight))
    ]

    // Transformation des flammes en bombes au niveau 3
    if level == 3 && !flamesTransformedToBombs {
        obstacles = []
        // Ajouter 4 bombes supplémentaires
        for _ in 0..<8 { // 4 obstacles initiaux + 4 supplémentaires
            var x, y: Int
            repeat {
                x = Int.random(in: 1..<(gridWidth-1))
                y = Int.random(in: 1..<(gridHeight-1))
            } while (x == playerX && y == playerY) ||
                   (x == artifactX && y == artifactY) ||
                   obstacles.contains(where: { $0.x == x && $0.y == y })

            obstacles.append((x, y))
        }
        flamesTransformedToBombs = true
        print("\u{001B}[31mLes flammes se sont transformées en bombes ! Faites attention !\u{001B}[0m")
    } else if level != 3 {
        // Obstacles normaux pour les autres niveaux
        obstacles = [
            (2, 2), (3, 5), (6, 6), (5, 8),  // Obstacles fixes
            (Int.random(in: 1..<gridWidth), Int.random(in: 1..<gridHeight)),
            (Int.random(in: 1..<gridWidth), Int.random(in: 1..<gridHeight))
        ]
    }

     if level >= 4 {
        generateGhosts()
    } else {
        ghosts = []
    }

    if level == 5 {
        generatePoisons()
        print("\u{001B}[31m⚠️ Attention ! Des poisons mortels apparaissent sur la grille ! ☠️\u{001B}[0m")
    } else {
        poisons = []
    }


    // Génération des potions en évitant les collisions
    generatePotions()  //
}

//Demande si le joueur veut rejouer
func askToPlayAgain() {
    let green = "\u{001B}[0;32m"
    let red = "\u{001B}[0;31m"
    let reset = "\u{001B}[0m"

    print("\n\(red)══════════════════════════════════════════════\(reset)")
    print("\(red)                FIN DE LA PARTIE!                \(reset)")
    print("\(red)══════════════════════════════════════════════\(reset)\n")


    while true {
        print("\n\(green)Voulez-vous rejouer ? (Appuyez sur O pour Oui ou N pour Non)\(reset)")

        if let response = readLine()?.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) {
            switch response {
            case "o":
                // Réinitialisation du jeu
                lives = 3
                score = 0
                level = 1
                timeElapsed = 0
                inventory = []
                piege1Actif = false
                piege2Actif = false
                piege3Actif = false

                resetLevel()
                generatePotions()

                print("\n\(green)══════════════════════════════════════════════\(reset)")
                print("\(green)          NOUVELLE PARTIE COMMENCE !          \(reset)")
                print("\(green)══════════════════════════════════════════════\(reset)\n")
                return

            case "n":
                print("\n\(green)Merci d'avoir joué ! À bientôt !\(reset)")
                exit(0)

            default:
                print("\(red)Commande incorrecte. Veuillez appuyer sur O (Oui) ou N (Non).\(reset)")
            }
        }
    }
}

// Fonction pour gérer l'interaction avec Le Gardien
func interactWithGuardian() {
let yellow = "\u{001B}[0;33m"  // Code ANSI jaune
let reset = "\u{001B}[0m"      // Réinitialisation
let brown = "\u{001B}[38;2;139;69;19m" // RGB pour #8B4513 (SaddleBrown)
let red = "\u{001B}[0;31m"           // Rouge (ANSI)
let green = "\u{001B}[0;32m"            // Vert (ANSI)

    print("Vous rencontrez \(yellow)Le Gardien\(reset) !")
    // Première rencontre : Le Gardien donne la carte
    if !inventory.contains("Carte") {
        print("\(yellow)Le Gardien\(reset) vous regarde et dit : 'Pour passer, résous cette énigme : Quel est le résultat de 2 + 2 ?'")

        if let answer = readLine(), answer == "4" {
            print("\(green)Bonne réponse !\(reset) \(yellow)Le Gardien\(reset) vous sourit et vous remet un objet.")
            print("\(yellow)Le Gardien\(reset) vous a donné une carte pour trouver l'artefact.")
            inventory.append("Carte") // Ajouter la carte dans l'inventaire
            print("\(brown)Votre inventaire : \(inventory.joined(separator: ", "))\(reset)")
        } else {
            print("\(red)Mauvaise réponse...\(reset) \(yellow)Le Gardien\(reset) vous regarde tristement.")
        }
    } else if !inventory.contains("Loupe") {  // Deuxième rencontre : Le Gardien donne la loupe
        print("\(yellow)Le Gardien\(reset) vous regarde et dit : 'Ah, vous avez déjà la carte. Résolvez une autre énigme pour obtenir un autre objet.'")
        print("Voici l'énigme : Objet qui permet d'ouvrir des portes ?")

        if let loupeAnswer = readLine(), loupeAnswer == "clé" {
            print("\(green)Bonne réponse !\(reset) \(yellow)Le Gardien\(reset) vous sourit et vous donne une loupe.")
            inventory.append("Loupe") // Ajouter la loupe dans l'inventaire
            print("\(brown)Votre inventaire : \(inventory.joined(separator: ", "))\(reset)")
        } else {
            print("\(red)Mauvaise réponse...\(reset) \(yellow)Le Gardien\(reset) vous regarde tristement.")
        }
    } else {  // Troisième rencontre : Le Gardien donne un autre objet
        print("\(yellow)Le Gardien\(reset) vous regarde et dit : 'Vous avez la carte et la loupe. Résolvez une autre énigme pour obtenir un autre objet.'")
        print("Voici l'énigme :Qui sui-je?")

        if let thirdAnswer = readLine(), thirdAnswer == "le Gardien" {
            print("\(green)Bonne réponse ! \(reset) \(yellow)Le Gardien\(reset) vous sourit et vous donne une épée.")
            inventory.append("épée") // Ajouter une épée dans l'inventaire
            print("\(brown)Votre inventaire : \(inventory.joined(separator: ", "))\(reset)")
        } else {
            print("\(red)Mauvaise réponse...\(reset)\(yellow)Le Gardien\(reset) vous regarde tristement.")
        }
    }
}
// Variables pour suivre si les pièges ont déjà été activés
var piege1Actif = false
var piege2Actif = false
var piege3Actif = false

// Fonction piège
func piège(playerName: String) {
    let green = "\u{001B}[0;32m"  // Code ANSI pour vert
    let red = "\u{001B}[0;31m"     // Rouge
    let reset = "\u{001B}[0m"      // Réinitialisation
    _ = "🕳️" // Emoji pour le trou

    // Premier piège : entre 10 et 20 secondes
    if timeElapsed >= 10 && timeElapsed <= 20 && !piege1Actif {
        isInHole = true // Le joueur est maintenant dans le trou
        print("\(darkBlue)\(playerName)\(reset) AAAAHH AIIE, \(darkBlue)\(playerName)\(reset)  a fait une chute dans un énorme trou. Il regarde autour de lui et il voit au sol :")
        printGrid()
        print("1. une branche")
        print("2. une corde")
        print("3. des ciseaux")
        var validResponse = false

        while !validResponse {
            print("Quel objet doit-il prendre ? (entrez 1, 2 ou 3)")
            if let response = readLine() {
                switch response {
                case "1", "3":
                    print("\(red)Mauvais choix\(reset), essaye encore.")
                case "2":
                    print("\(green)Bon choix !\(reset) Vous avez réussi à grimper avec la corde. Le jeu reprend.")
                    validResponse = true
                    isInHole = false
                default:
                    print("\(red)Choix invalide !\(reset) Réessayez.")
                }
            }
        }
        piege1Actif = true
    }

    // Deuxième piège : entre 30 et 40 secondes
    if timeElapsed >= 30 && timeElapsed <= 40 && !piege2Actif {
        print("Oh non ! \(darkBlue)\(playerName)\(reset) se retrouve face à un monstre qui le poursuit.")
        print("Que doit-il faire ?")
        print("1. Tenter de l’effrayer avec un bâton")
        print("2. Se cacher derrière un rocher")
        print("3. Courir très vite en criant")

        var validResponse = false

        while !validResponse {
            print("Entrez votre choix (1, 2 ou 3) :")
            if let response = readLine() {
                switch response {
                case "1", "3":
                    print("Le monstre vous suit toujours. Réessaie !")
                case "2":
                    print("\(green)Bonne idée !\(reset) Le monstre perd votre trace. Vous êtes sauf pour le moment.")
                    validResponse = true
                default:
                    print("\(red)Choix invalide !\(reset) Réessayez.")
                }
            }
        }
        piege2Actif = true
    }

    // Troisième piège : entre 50 et 60 secondes
    if timeElapsed >= 50 && timeElapsed <= 60 && !piege3Actif {
        print("\(darkBlue)\(playerName)\(reset) entre dans une pièce sombre... soudain, le sol commence à s'effondrer sous ses pieds !")
        print("Il doit réagir vite :")
        print("1. Sauter en avant sans réfléchir")
        print("2. Chercher une dalle plus stable")
        print("3. S’allonger au sol pour répartir son poids")

        var validResponse = false

        while !validResponse {
            print("Entrez votre choix (1, 2 ou 3) :")
            if let response = readLine() {
                switch response {
                case "1", "3":
                    print("\(red)Mauvais choix\(reset), le sol s’effondre ! Essaie encore.")
                case "2":
                    print("\(green)Bonne intuition !\(reset) Vous trouvez une dalle stable et continuez votre chemin.")
                    validResponse = true
                default:
                    print("\(red)Choix invalide\(reset) Réessayez.")
                }
            }
        }
        piege3Actif = true
    }
}

func NewRoom() {
    // Changer la taille de la grille
    gridWidth = 20  // Nouvelle largeur
    gridHeight = 10 // Nouvelle hauteur

    // Position du joueur au centre
    playerX = gridWidth / 2
    playerY = gridHeight / 2

    // Position aléatoire de l'artefact
    repeat {
        artifactX = Int.random(in: 3..<(gridWidth-3))
        artifactY = Int.random(in: 2..<(gridHeight-2))
    } while (artifactX == playerX && artifactY == playerY)

    // Position aléatoire de l'ennemi
    repeat {
        enemyX = Int.random(in: 0..<gridWidth)
        enemyY = Int.random(in: 0..<gridHeight)
    } while (enemyX == playerX && enemyY == playerY) ||
           (enemyX == artifactX && enemyY == artifactY)

    // Générer de nouveaux obstacles
    obstacles.removeAll()
    let numberOfObstacles = 10 // Plus d'obstacles dans la grande salle

    for _ in 0..<numberOfObstacles {
        var newX, newY: Int
        repeat {
            newX = Int.random(in: 0..<gridWidth)
            newY = Int.random(in: 0..<gridHeight)
        } while (newX == playerX && newY == playerY) ||
               (newX == artifactX && newY == artifactY) ||
               (newX == doorX && newY == doorY) ||
               obstacles.contains(where: { $0.x == newX && $0.y == newY })

        obstacles.append((x: newX, y: newY))
    }

    // Position de la porte dans un coin aléatoire
    let doorPositions = [
        (0, 0),
        (gridWidth-5, 4),
        (0, gridHeight-1),
        (gridWidth-1, gridHeight-1)
    ]
    let chosenDoorPos = doorPositions[1]
    doorX = chosenDoorPos.0
    doorY = chosenDoorPos.1

    print("\u{001B}[0;32m[Nouvelle salle \(gridWidth)x\(gridHeight)]")
    print("Porte positionnée en (\(doorX), \(doorY))\u{001B}[0;0m")
}

//---------------------------------------------//
/////-------//BOUBLE PRINCIPALE DU JEU///////////
//--------------------------------------------//
func bold(_ text: String) -> String {
    return "\u{001B}[1m\(text)\u{001B}[0m"
    }
    while true {

    // Afficher la date et l'heure en haut à droite
        let dateTimeString = "\u{001B}[38;5;244m\(getCurrentDateTime())\u{001B}[0m"
        print(String(repeating: " ", count: 80 - dateTimeString.count) + dateTimeString)

        print("\(bold("⭐Niveau:")) \(level) -\(bold("Vies:")) \(lives)❤️ -\(bold("Score:")) \(score) -\(bold("⏱️Temps écoulé:")) \(timeElapsed) secondes - \(bold("🎒 Inventaire:")) \(inventory.joined(separator: ", "))")
        printGrid() // Afficher la grille
        piège(playerName: playerName) //Appelle la fonction piege

       print("Utilisez les touches \(bold("W↑")), \(bold("←A")), \(bold("S↓")), \(bold("D→")) pour déplacer le personnage, \(bold("H")) pour les instructions ou \(bold("Q")) pour quitter.")
        if let input = getInput() {
            if isInHole {
        print("Vous êtes coincé dans le trou ! Répondez à l'énigme pour sortir.")
    }else {
            switch input {
            case "w":
                if playerY > 0 {
                    playerY -= 1
                }
            case "a":
                if playerX > 0 {
                    playerX -= 1
                }
            case "s":
                if playerY < gridHeight - 1 {
                    playerY += 1
                }
            case "d":
                if playerX < gridWidth - 1 {
                    playerX += 1
                }
            case "h":
                printInstructions()
            case "q":
                print("Quitter le jeu...")
                print("Temps écoulé avant de quitter : \(timeElapsed) secondes")
                exit(0)
            default:
                print("Commande invalide. Utilisez W, A, S, D pour déplacer ou Q pour quitter.")
            }
            if level == 4 {
                moveGhosts()
            }
            checkAnimalEncounter(playerName: playerName)
            checkPotionCollision()

            // Vérifier si le joueur touche un obstacle
            let red = "\u{001B}[31m"  // Code ANSI pour rouge
            let reset = "\u{001B}[0m"  // Réinitialisation
            if isObstacle(x: playerX, y: playerY) {
                lives -= 1
                playSound(type: "damage")
                print("\(red)Vous avez touché un obstacle. Il vous reste \(lives) vies.\(reset)")

                if lives == 0 {
                    print("\(red)Game over ! Vous avez perdu toutes vos vies.\(reset)")
                    print("Temps écoulé : \(timeElapsed) secondes")
                    print("\n\(red)══════════════════════════════════════════════\(reset)")
                    print("\(red)                GAME OVER !                \(reset)")
                    print("\(red)══════════════════════════════════════════════\(reset)")
                    askToPlayAgain()
                }
            }

            // Vérifier si le joueur touche un poison (niveau 5 seulement)
            if level == 5 && poisons.contains(where: { $0.x == playerX && $0.y == playerY }) {
                lives = 0 // Perdre toutes les vies immédiatement
                print("\u{001B}[1;31m\n☠️☠️☠️ VOUS AVEZ TOUCHÉ DU POISON ! GAME OVER IMMÉDIAT ! ☠️☠️☠️\u{001B}[0m")
                print("\u{001B}[33mTemps écoulé: \(timeElapsed) secondes\u{001B}[0m")
                print("\u{001B}[32mNiveau atteint: \(level)\u{001B}[0m")
                askToPlayAgain()
            }

            // Vérifier si le joueur atteint l'artefact
            let green = "\u{001B}[0;32m" // Vert (ANSI)
            let purple = "\u{001B}[0;35m" // Violet/Magenta (ANSI standard)

            if playerX == artifactX && playerY == artifactY {
                score += 10
                playSound(type: "artifact") //Son
                print("\(green)Félicitations ! Vous avez trouvé l'artefact 💎 !\(reset)")
                level += 1

            // Niveau 2
            if level >= 2 {
                transformGridForLevel2()

            } else if level > 5 {
                print("\(green)Bravo, vous avez terminé tous les niveaux !\(reset)")
                print("\(purple) ⏳Temps écoulé total : \(timeElapsed) secondes ⏳\(reset)")

                askToPlayAgain()
            } else {
                resetLevel()
            }

            //Niveau 4
            if level >= 4 && ghosts.contains(where: { $0.x == playerX && $0.y == playerY }) {
                lives -= 1
                playSound(type: "damage")
                print("\(red)Un fantôme vous a touché ! Il vous reste \(lives) vies.\(reset)")
            }

            if level > 5 {  //Nombre de niveau 5
                    print("\(green)Bravo, vous avez terminé tous les niveaux !\(reset)")
                    print("\(purple) ⏳Temps écoulé total : \(timeElapsed) secondes⏳\(reset)")
                    askToPlayAgain()
                }
                resetLevel()
            }

            // Vérifier si le joueur rencontre Le Gardien
            if playerX == guardianX && playerY == guardianY {
                interactWithGuardian()
            }

            // Vérifier si le joueur atteint la porte
            if playerX == doorX && playerY == doorY {
                let brown = "\u{001B}[38;5;94m"
                let reset = "\u{001B}[0m"

                print("\(brown)Vous avez trouvé la porte ! Appuyez sur 'O' pour l'ouvrir.\(reset)")
                if let input = getInput(), input == "o" {
                    print("\(brown)Bravo !La porte s'ouvre... Un nouveau niveau commence !\(reset)")
                    NewRoom()
                }
            }
        }
    }
}
}

//Son
func playSound(type: String) {
    switch type {
    case "artifact":
        print("\u{0007}") // Bip système
        print("\u{001B}[32m✨ Artefact trouvé !\u{001B}[0m") // Texte vert
    case "damage":
        print("\u{0007}") // Bip système
        print("\u{001B}[31m💥 Ouch ! -1 vie\u{001B}[0m") // Texte rouge
    case "potion":
        print("\u{0007}") // Bip système
        print("\u{001B}[35m🧴 Potion récupérée !\u{001B}[0m") // Texte magenta
    default:
        print("\u{0007}") // Bip système par défaut
    }
}
