@testable import App
import XCTVapor

final class AppTests: XCTestCase {
    func test_get_root_returns_default_BattlesnakeInfo() async throws {
        let app = Application(.testing)
        defer { app.shutdown() }
        try await configure(app)

        try app.test(.GET, "", afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
            
            let result = try res.content.decode(BattlesnakeInfo.self)
            XCTAssertEqual(result, BattlesnakeInfo.default)
        })
    }
    
    func test_post_start_returns_200OK() async throws {
        let app = Application(.testing)
        defer { app.shutdown() }
        try await configure(app)

        try app.test(.POST, "start", afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
        })
    }
    
    func test_post_stop_returns_200OK() async throws {
        let app = Application(.testing)
        defer { app.shutdown() }
        try await configure(app)

        try app.test(.POST, "end", afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
        })
    }
    
    func test_post_move_returnsValidMove() async throws {
        let app = Application(.testing)
        defer { app.shutdown() }
        try await configure(app)

        try app.test(.POST, "move", beforeRequest: { req in
            try req.content.encode(BattlesnakeGameState(you: BattlesnakeObject(body: [Coord(0,0), Coord(0,0)])))
        }, afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
            
            let expected: [BattlesnakeMove.Move] = [
                .up, .down, .left, .right
            ]
            
            let result = try res.content.decode(BattlesnakeMove.self)
            XCTAssertTrue(expected.contains(result.move))
        })
    }    
    
    func test_post_move_isAbleToDecode_exampleRequest() async throws {
        let app = Application(.testing)
        defer { app.shutdown() }
        try await configure(app)
        
        // Convert JSON to gamestate
        let decoder = JSONDecoder()
        let data = exampleRequestJSON.data(using: .utf8)!
        let gamestate = try decoder.decode(BattlesnakeGameState.self, from: data)
        
        
        try app.test(.POST, "move", beforeRequest: { req in
            try req.content.encode(gamestate)
        }, afterResponse: { res in
                XCTAssertEqual(res.status, .ok)
        })
    }
    
    func test_post_move_doesNotGoBackwards() async throws {
        let app = Application(.testing)
        defer { app.shutdown() }
        try await configure(app)
        
        let testcases: [(gamestate: BattlesnakeGameState, notAllowed: BattlesnakeMove.Move)] = [
            (BattlesnakeGameState(you: BattlesnakeObject(body: [Coord(5,7), Coord(4,7)])), .left),
            (BattlesnakeGameState(you: BattlesnakeObject(body: [Coord(5,7), Coord(6,7)])), .right),
            (BattlesnakeGameState(you: BattlesnakeObject(body: [Coord(5,8), Coord(5,7)])), .down),
            (BattlesnakeGameState(you: BattlesnakeObject(body: [Coord(5,6), Coord(5,7)])), .up)
        ]

        for testcase in testcases {
            for _ in 0 ..< 10 {
                try app.test(.POST, "move",
                    beforeRequest: { req in
                    try req.content.encode(testcase.gamestate)
                    },
                    afterResponse: { res in
                        XCTAssertEqual(res.status, .ok)
                                                
                        let result = try res.content.decode(BattlesnakeMove.self)
                    XCTAssertNotEqual(result.move, testcase.notAllowed)
                    })
            }
        }
    }
}


// MARK: Fixtures

let exampleRequestJSON =
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
