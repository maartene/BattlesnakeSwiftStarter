@testable import App
import XCTVapor

final class AppTests: XCTestCase {
    // MARK: API tests
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
            try req.content.encode(BattlesnakeGameState(
                game: BattlesnakeGame(id: "", ruleset: BattlesnakeGame.Ruleset(name: "", version: ""), map: "", timeout: 500, source: "league"),
                turn: 0,
                board: BattlesnakeBoard(height: 11, width: 11, food: [], hazards: [], snakes: [BattlesnakeObject(body: [Coord(0,0), Coord(0,0)])]),
                you: BattlesnakeObject(body: [Coord(0,0), Coord(0,0)])))
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
        let data = exampleGameStateJSON.data(using: .utf8)!
        let gamestate = try decoder.decode(BattlesnakeGameState.self, from: data)
        
        
        try app.test(.POST, "move", beforeRequest: { req in
            try req.content.encode(gamestate)
        }, afterResponse: { res in
                XCTAssertEqual(res.status, .ok)
        })
    }
    
    // MARK: Decode requests
    let decoder = JSONDecoder()
    func test_decode_game() throws {        
        let data = exampleGameJSON.data(using: .utf8)!
        let game = try decoder.decode(BattlesnakeGame.self, from: data)

        XCTAssertEqual(game.id, "totally-unique-game-id")
        XCTAssertEqual(game.ruleset, BattlesnakeGame.Ruleset(name: "standard", version: "v1.2.3"))
        XCTAssertEqual(game.map, "standard")
        XCTAssertEqual(game.timeout, 500)
        XCTAssertEqual(game.source, "league")
    }

    func test_decode_battlesnakeObject() throws {
        let data = exampleBattlesnakeObjectJSON.data(using: .utf8)!
        let snake = try decoder.decode(BattlesnakeObject.self, from: data)

        XCTAssertEqual(snake.id, "totally-unique-snake-id")
        XCTAssertEqual(snake.name, "Solid Snake")
        XCTAssertEqual(snake.health, 54)
        XCTAssertEqual(snake.body, [Coord(0,0), Coord(1,0), Coord(2,0)])
        XCTAssertEqual(snake.latency, "123")
        XCTAssertEqual(snake.head, Coord(0,0))
        XCTAssertEqual(snake.length, 3)
        XCTAssertEqual(snake.shout, "Snake? Snake!? SNAAKKE!!!!")
        XCTAssertEqual(snake.squad, "1")
        XCTAssertEqual(snake.customizations, BattlesnakeObject.Customizations(color: "#26CF04", head: "smile", tail: "bolt"))
    }
    
    func test_decode_board() throws {
        let data = exampleBattlesnakeBoardJSON.data(using: .utf8)!
        let board = try decoder.decode(BattlesnakeBoard.self, from: data)

        XCTAssertEqual(board.height, 11)
        XCTAssertEqual(board.width, 11)
        XCTAssertEqual(board.food, [Coord(5,5), Coord(9,0), Coord(2,6)])
        XCTAssertEqual(board.hazards, [Coord(0,0), Coord(0,1), Coord(0,2)])
        XCTAssertEqual(board.snakes.count, 2)
    }
    
    func test_decode_gamestate() throws {
        let data = exampleGameStateJSON.data(using: .utf8)!
        let gamestate = try decoder.decode(BattlesnakeGameState.self, from: data)
        
        XCTAssertEqual(gamestate.game, BattlesnakeGame(
            id: "totally-unique-game-id",
            ruleset: BattlesnakeGame.Ruleset(name: "standard", version: "v1.1.15"),
            map: "standard",
            timeout: 500,
            source: "league")
        )
        XCTAssertEqual(gamestate.turn, 14)
        XCTAssertEqual(gamestate.board, BattlesnakeBoard(
            height: 11,
            width: 11,
            food: [Coord(5, 5), Coord(9, 0), Coord(2, 6)],
            hazards: [Coord(3, 2)],
            snakes: [
                BattlesnakeObject(
                    id: "snake-508e96ac-94ad-11ea-bb37",
                    name: "My Snake",
                    health: 54,
                    body: [Coord(0, 0), Coord(1, 0), Coord(2, 0)],
                    latency: "111",
                    shout: "why are we shouting??",
                    customizations: BattlesnakeObject.Customizations(color: "#FF0000", head: "pixel", tail: "pixel")
                ),
                BattlesnakeObject(
                    id: "snake-b67f4906-94ae-11ea-bb37",
                    name: "Another Snake",
                    health: 16,
                    body: [Coord(5, 4), Coord(5, 3), Coord(6, 3), Coord(6, 2)],
                    latency: "222",
                    shout: "I'm not really sure...",
                    customizations: BattlesnakeObject.Customizations(color: "#26CF04", head: "silly", tail: "curled")
                )
            ])
        )
        XCTAssertEqual(gamestate.you, BattlesnakeObject(
            id: "snake-508e96ac-94ad-11ea-bb37",
            name: "My Snake",
            health: 54,
            body: [Coord(0, 0), Coord(1, 0), Coord(2, 0)],
            latency: "111",
            shout: "why are we shouting??",
            customizations: BattlesnakeObject.Customizations(color: "#FF0000", head: "pixel", tail: "pixel")
        ))
        
    }
}
