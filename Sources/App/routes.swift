import Vapor

func routes(_ app: Application) throws {
    app.get { req async in
        BattlesnakeInfo.default
    }

    /// Stub for responder to start event.
    app.post("start") { req async in
        ""
    }
    
    /// Stub for responder to start event.
    app.post("end") { req async in
        ""
    }
    
    /// Decode gamestate and use that to calculate the snakes move.
    app.post("move") { req async throws in
        let gamestate = try req.content.decode(BattlesnakeGameState.self)
        return move(gamestate)
    }
}
