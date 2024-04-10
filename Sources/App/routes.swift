import Vapor

func routes(_ app: Application) throws {
    app.get { req async in
        BattlesnakeInfo.default
    }

    app.post("start") { req async in
        ""
    }
    
    app.post("end") { req async in
        ""
    }
    
    app.post("move") { req async throws in
        let gamestate = try req.content.decode(BattlesnakeGameState.self)
        return move(gamestate)
    }
}
