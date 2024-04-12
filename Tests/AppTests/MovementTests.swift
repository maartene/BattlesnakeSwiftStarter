//
//  MovementTests.swift
//
//
//  Created by Maarten Engels on 10/04/2024.
//

import Foundation
import XCTest
@testable import App

final class MovementTests: XCTestCase {
    static let rulesetSettings = BattlesnakeGame.RulesetSettings(foodSpawnChance: 0, minimumFood: 0, hazardDamagePerTurn: 0, royale: 
    BattlesnakeGame.RulesetSettings.Royale(shrinkEveryNTurns: 0), squad: BattlesnakeGame.RulesetSettings.Squad(allowBodyCollisions: true, sharedElimination: true, sharedHealth: true, sharedLength: true))

    let movingRight = BattlesnakeGameState(
        game: BattlesnakeGame(id: "", ruleset: BattlesnakeGame.Ruleset(name: "", version: "", settings: rulesetSettings), map: "", timeout: 500, source: "league"),
        turn: 0,
        board: BattlesnakeBoard(height: 11, width: 11, food: [], hazards: [], snakes: [BattlesnakeObject(body: [Coord(5,7), Coord(4,7)])]),
        you: BattlesnakeObject(body: [Coord(5,7), Coord(4,7)]))
    
    let movingLeft = BattlesnakeGameState(
        game: BattlesnakeGame(id: "", ruleset: BattlesnakeGame.Ruleset(name: "", version: "", settings: rulesetSettings), map: "", timeout: 500, source: "league"),
        turn: 0,
        board: BattlesnakeBoard(height: 11, width: 11, food: [], hazards: [], snakes: [BattlesnakeObject(body: [Coord(5,7), Coord(6,7)])]),
        you: BattlesnakeObject(body: [Coord(5,7), Coord(6,7)]))
    
    let movingUp = BattlesnakeGameState(
        game: BattlesnakeGame(id: "", ruleset: BattlesnakeGame.Ruleset(name: "", version: "", settings: rulesetSettings), map: "", timeout: 500, source: "league"),
        turn: 0,
        board: BattlesnakeBoard(height: 11, width: 11, food: [], hazards: [], snakes: [BattlesnakeObject(body: [Coord(5,8), Coord(5,7)])]),
        you: BattlesnakeObject(body: [Coord(5,8), Coord(5,7)]))
    
    let movingDown = BattlesnakeGameState(
        game: BattlesnakeGame(id: "", ruleset: BattlesnakeGame.Ruleset(name: "", version: "", settings: rulesetSettings), map: "", timeout: 500, source: "league"),
        turn: 0,
        board: BattlesnakeBoard(height: 11, width: 11, food: [], hazards: [], snakes: [BattlesnakeObject(body: [Coord(5,6), Coord(5,7)])]),
        you: BattlesnakeObject(body: [Coord(5,6), Coord(5,7)]))
    
    func test_move_doesNotGoBackwards() {
        for _ in 0 ..< 100 {
            XCTAssertNotEqual(move(movingRight).move, .left)
            XCTAssertNotEqual(move(movingLeft).move, .right)
            XCTAssertNotEqual(move(movingUp).move, .down)
            XCTAssertNotEqual(move(movingDown).move, .up)
        }
    }
    
    // TODO: Step 1 - Prevent your Battlesnake from moving out of bounds
    // boardWidth = gameState.board.width;
    // boardHeight = gameState.board.height;

    // TODO: Step 2 - Prevent your Battlesnake from colliding with itself
    // myBody = gameState.you.body;

    // TODO: Step 3 - Prevent your Battlesnake from colliding with other Battlesnakes
    // opponents = gameState.board.snakes;
    
    // TODO: Step 4 - Move towards food instead of random, to regain health and survive longer
    // food = gameState.board.food;
    
}
