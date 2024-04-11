//
//  File.swift
//  
//
//  Created by Maarten Engels on 10/04/2024.
//

import Foundation
import Vapor

// MARK: Data structures
struct BattlesnakeInfo {
    let apiversion: String
    let author: String
    let color: String
    let head: String
    let tail: String
    let version: String
    
    static var `default`: BattlesnakeInfo {
        BattlesnakeInfo(
            apiversion: "1",
            author: "SwiftUser",
            color: "#888888",
            head: "default",
            tail: "default",
            version: "0.0.1-beta"
        )
    }
}

struct Coord {
    let x: Int
    let y: Int
    
    init(_ x: Int, _ y: Int) {
        self.x = x
        self.y = y
    }
}

struct BattlesnakeMove {
    enum Move: String {
        case up
        case down
        case left
        case right
    }
    
    let move: Move
}

struct BattlesnakeObject {
    struct Customizations {
        let color: String
        let head: String
        let tail: String

        static var `default`: Customizations {
            Customizations(
                color: "#888888",
                head: "default",
                tail: "default"
            )
        }
    }

    let id: String
    let name: String
    let health: Int
    let body: [Coord]
    let latency: String
    
    var head: Coord {
        body[0]
    }

    var length: Int {
        body.count
    }

    let shout: String
    let squad: String?
    let customizations: Customizations

    init(id: String = UUID().uuidString, name: String = "Nameless Snake", health: Int = 1, body: [Coord], latency: String = "", shout: String = "", squad: String? = nil, customizations: Customizations = .default) {
        self.id = id
        self.name = name
        self.health = health
        self.body = body
        self.latency = latency
        self.shout = shout
        self.squad = squad
        self.customizations = customizations
    }
}

struct BattlesnakeGameState {
    let game: BattlesnakeGame
    let turn: Int
    let board: BattlesnakeBoard
    let you: BattlesnakeObject
}

struct BattlesnakeGame {
    struct Ruleset {
        let name: String
        let version: String
    }

    let id: String
    let ruleset: Ruleset
    let map: String
    let timeout: Int
    let source: String
}

struct BattlesnakeBoard {
    let height: Int
    let width: Int
    let food: [Coord]
    let hazards: [Coord]
    let snakes: [BattlesnakeObject]
}

// MARK: Protocol conformances
extension BattlesnakeInfo: Equatable { }
extension BattlesnakeInfo: Content { }

extension Coord: Content { }
extension Coord: Equatable { }

extension BattlesnakeMove: Content { }

extension BattlesnakeMove.Move: Content { }
extension BattlesnakeMove.Move: Equatable { }

extension BattlesnakeObject.Customizations: Content { }
extension BattlesnakeObject.Customizations: Equatable { }

extension BattlesnakeObject: Content { }
extension BattlesnakeObject: Equatable { }

extension BattlesnakeGameState: Content { }

extension BattlesnakeGame.Ruleset: Content { }
extension BattlesnakeGame.Ruleset: Equatable { }

extension BattlesnakeGame: Content { }
extension BattlesnakeGame: Equatable { }

extension BattlesnakeBoard: Content { }
extension BattlesnakeBoard: Equatable { }
