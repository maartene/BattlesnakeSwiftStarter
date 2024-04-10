//
//  MoveTests.swift
//
//
//  Created by Maarten Engels on 10/04/2024.
//

import Foundation
import XCTest
@testable import App

final class MoveTests: XCTestCase {
    func test_move_doesNotGoBackwards() {
        let movingRight = BattlesnakeGameState(
            you: BattlesnakeObject(body: [Coord(5,7), Coord(4,7)]))
        let movingLeft = BattlesnakeGameState(
            you: BattlesnakeObject(body: [Coord(5,7), Coord(6,7)]))
        let movingUp = BattlesnakeGameState(
            you: BattlesnakeObject(body: [Coord(5,8), Coord(5,7)]))
        let movingDown = BattlesnakeGameState(
            you: BattlesnakeObject(body: [Coord(5,6), Coord(5,7)]))
        
        for _ in 0 ..< 100 {
            XCTAssertNotEqual(move(movingRight).move, .left)
            XCTAssertNotEqual(move(movingLeft).move, .right)
            XCTAssertNotEqual(move(movingUp).move, .down)
            XCTAssertNotEqual(move(movingDown).move, .up)
        }
    }
    
}
