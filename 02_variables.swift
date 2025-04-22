//-----------------------------------//
//--------Classes---------------//
//-----------------------------------//

{
  "grid": {
    "width": 10,
    "height": 10
  },
  "player": {
    "x": 4,
    "y": 4
  },
  "artifact": {
    "x": 7,
    "y": 7
  },
  "obstacles": [
    { "x": 2, "y": 2 },
    { "x": 3, "y": 5 },
    { "x": 6, "y": 6 },
    { "x": 5, "y": 8 }
  ],
  "flamesTransformedToBombs": false,
  "ghosts": [],
  "guardian": {
    "x": 5,
    "y": 5
  },
  "door": {
    "x": 9,
    "y": 8
  },
  "potions": [],
  "potion": {
    "emoji": "🧴",
    "color": "\\u001B[38;5;213m"
  },
  "isInHole": false,
  "enemy": {
    "x": "random(0-9)",
    "y": "random(0-9)"
  },
  "decorativeCharacters": [
    {
      "emoji": "🐱",
      "x": "random(0-9)",
      "y": "random(0-9)",
      "sound": "Miaou !"
    },
    {
      "emoji": "🐶",
      "x": "random(0-9)",
      "y": "random(0-9)",
      "sound": "Wouaf Wouaf !"
    },
    {
      "emoji": "🐭",
      "x": "random(0-9)",
      "y": "random(0-9)",
      "sound": "Couic !"
    },
    {
      "emoji": "🐦",
      "x": "random(0-9)",
      "y": "random(0-9)",
      "sound": "Cui Cui !"
    }
  ],
  "game": {
    "lives": 3,
    "score": 0,
    "level": 1,
    "timeElapsed": 0,
    "inventory": []
  },
  "characters": [
    {
      "emoji": "🫅",
      "name": "Le Prince",
      "description": "Noble et courageux, avec une aura royale"
    },
    {
      "emoji": "🧛",
      "name": "Le Vampire",
      "description": "Puissant mais vulnérable à la lumière"
    },
    {
      "emoji": "🧝",
      "name": "L'Elfe",
      "description": "Rapide et agile, maître des forêts"
    },
    {
      "emoji": "🥷",
      "name": "Le Ninja",
      "description": "Furtif et mortel, maître des ombres"
    }
  ],
  "rooms": [
    "🏫 Salle 1 - Informatique",
    "🏥 Salle 2 - Hôpital",
    "📚 Salle 3 - Bibliothèque",
    "🎨 Salle 4 - Salle des arts",
    "🍴 Salle 5 - Cuisine",
    "🤸 Salle 6 - Gymnase",
    "🔬 Salle 7 - Laboratoire",
    "🌳 Salle 8 - Jardin"
  ]
}
