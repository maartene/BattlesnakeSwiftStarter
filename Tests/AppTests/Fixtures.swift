let exampleGameStateJSON =
"""
{
  "game": {
    "id": "totally-unique-game-id",
    "ruleset": {
      "name": "standard",
      "version": "v1.1.15",
      "settings": {
        "foodSpawnChance": 15,
        "minimumFood": 1,
        "hazardDamagePerTurn": 14
      }
    },
    "map": "standard",
    "source": "league",
    "timeout": 500
  },
  "turn": 14,
  "board": {
    "height": 11,
    "width": 11,
    "food": [
      {"x": 5, "y": 5},
      {"x": 9, "y": 0},
      {"x": 2, "y": 6}
    ],
    "hazards": [
      {"x": 3, "y": 2}
    ],
    "snakes": [
      {
        "id": "snake-508e96ac-94ad-11ea-bb37",
        "name": "My Snake",
        "health": 54,
        "body": [
          {"x": 0, "y": 0},
          {"x": 1, "y": 0},
          {"x": 2, "y": 0}
        ],
        "latency": "111",
        "head": {"x": 0, "y": 0},
        "length": 3,
        "shout": "why are we shouting??",
        "customizations":{
          "color":"#FF0000",
          "head":"pixel",
          "tail":"pixel"
        }
      },
      {
        "id": "snake-b67f4906-94ae-11ea-bb37",
        "name": "Another Snake",
        "health": 16,
        "body": [
          {"x": 5, "y": 4},
          {"x": 5, "y": 3},
          {"x": 6, "y": 3},
          {"x": 6, "y": 2}
        ],
        "latency": "222",
        "head": {"x": 5, "y": 4},
        "length": 4,
        "shout": "I'm not really sure...",
        "customizations":{
          "color":"#26CF04",
          "head":"silly",
          "tail":"curled"
        }
      }
    ]
  },
  "you": {
    "id": "snake-508e96ac-94ad-11ea-bb37",
    "name": "My Snake",
    "health": 54,
    "body": [
      {"x": 0, "y": 0},
      {"x": 1, "y": 0},
      {"x": 2, "y": 0}
    ],
    "latency": "111",
    "head": {"x": 0, "y": 0},
    "length": 3,
    "shout": "why are we shouting??",
    "customizations": {
      "color":"#FF0000",
      "head":"pixel",
      "tail":"pixel"
    }
  }
}
"""

let exampleGameJSON = 
"""
{
  "id": "totally-unique-game-id",
  "ruleset": {
    "name": "standard",
    "version": "v1.2.3"
  },
  "map": "standard",
  "timeout": 500,
  "source": "league"
}
"""

let exampleBattlesnakeObjectJSON =
"""
{
  "id": "totally-unique-snake-id",
  "name": "Solid Snake",
  "health": 54,
  "body": [
    {"x": 0, "y": 0},
    {"x": 1, "y": 0},
    {"x": 2, "y": 0}
  ],
  "latency": "123",
  "head": {"x": 0, "y": 0},
  "length": 3,
  "shout": "Snake? Snake!? SNAAKKE!!!!",
  "squad": "1",
  "customizations":{
    "color":"#26CF04",
    "head":"smile",
    "tail":"bolt"
  }
}
"""

let exampleBattlesnakeBoardJSON = 
"""
{
  "height": 11,
  "width": 11,
  "food": [
    {"x": 5, "y": 5},
    {"x": 9, "y": 0},
    {"x": 2, "y": 6}
  ],
  "hazards": [
    {"x": 0, "y": 0},
    {"x": 0, "y": 1},
    {"x": 0, "y": 2}
  ],
  "snakes": [
    {
  "id": "totally-unique-snake-id",
  "name": "Solid Snake",
  "health": 54,
  "body": [
    {"x": 0, "y": 0},
    {"x": 1, "y": 0},
    {"x": 2, "y": 0}
  ],
  "latency": "123",
  "head": {"x": 0, "y": 0},
  "length": 3,
  "shout": "Snake? Snake!? SNAAKKE!!!!",
  "squad": "1",
  "customizations":{
    "color":"#26CF04",
    "head":"smile",
    "tail":"bolt"
  }
},
{
  "id": "totally-unique-snake-id 2",
  "name": "Liquid Snake",
  "health": 54,
  "body": [
    {"x": 0, "y": 0},
    {"x": 1, "y": 0},
    {"x": 2, "y": 0}
  ],
  "latency": "123",
  "head": {"x": 0, "y": 0},
  "length": 3,
  "shout": "Snake? Snake!? SNAAKKE!!!!",
  "squad": "1",
  "customizations":{
    "color":"#26CF04",
    "head":"smile",
    "tail":"bolt"
  }
}
  ]
}
"""