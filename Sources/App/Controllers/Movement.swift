//
//  Movement.swift
//
//
//  Created by Maarten Engels on 10/04/2024.
//

import Foundation
import Vapor

// MARK: Move function

/// The actual function that calculates the next move of the snake.
/// Hopefully, based on the actual game state. 
/// - Parameter gamestate: all the information about the current game state.
/// - Returns: a `BattlesnakeMove` object with the move the snake should make.
func move(_ gamestate: BattlesnakeGameState) -> BattlesnakeMove {
    var safeMoves: [BattlesnakeMove.Move] = [.up, .down, .left, .right]
    
    // We've included code to prevent your Battlesnake from moving backwards
    let myHead = gamestate.you.body[0]
    let myNeck = gamestate.you.body[1]


    if (myNeck.x < myHead.x) {        // Neck is left of head, don't move left
      safeMoves.removeAll(where: { $0 == .left })

    } else if (myNeck.x > myHead.x) { // Neck is right of head, don't move right
      safeMoves.removeAll(where: { $0 == .right })

    } else if (myNeck.y < myHead.y) { // Neck is below head, don't move down
      safeMoves.removeAll(where: { $0 == .down })

    } else if (myNeck.y > myHead.y) { // Neck is above head, don't move up
      safeMoves.removeAll(where: { $0 == .up })
    }
    
    return BattlesnakeMove(move: safeMoves.randomElement()!)
}
