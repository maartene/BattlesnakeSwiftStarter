//
//  Battlesnake.swift
//  
//
//  Created by Maarten Engels on 10/04/2024.
//

import Foundation
import Vapor

// MARK: Data structures

/// `BattlesnakeInfo` is a data structure that holds information about a Battlesnake.
/// See: https://docs.battlesnake.com/api/webhooks
///
/// It contains the following properties:
/// - `apiversion`: A string representing the API version used by the Battlesnake.
/// - `author`: A string representing the author of this Battlesnake server.
/// - `color`: A string representing the color of the Battlesnake in hexadecimal color code.
/// - `head`: A string representing the type of head the Battlesnake has.
/// - `tail`: A string representing the type of tail the Battlesnake has.
/// - `version`: A string representing the version of the Battlesnake this battlesnake server.
///
/// There is also a static `default` property that provides a default `BattlesnakeInfo` instance.
///
/// Example usage:
/// ```
/// let mySnakeInfo = BattlesnakeInfo(
///     apiversion: "1",
///     author: "MyName",
///     color: "#123456",
///     head: "fang",
///     tail: "bolt",
///     version: "1.0.0"
/// )
/// ```
struct BattlesnakeInfo {
    let apiversion: String
    let author: String
    let color: String
    let head: String
    let tail: String
    let version: String
    
    /// A default `BattlesnakeInfo` instance.
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

/// `Coord` is a data structure that holds the x and y coordinates of a point on the game board.
struct Coord {
    let x: Int
    let y: Int
    
    /// Initializes a new `Coord` instance with the given x and y coordinates.
    /// - Parameters:
    ///  x: The x coordinate of the point.
    ///  y: The y coordinate of the point.
    init(_ x: Int, _ y: Int) {
        self.x = x
        self.y = y
    }
}

/// Represents a move that a battlesnake can make on the game board.
///
/// The `BattlesnakeMove` struct encapsulates the information about a move that a battlesnake can make on the game board. It includes the direction of the move, which can be one of four possible values: `.up`, `.down`, `.left`, or `.right`.
///
/// Example usage:
/// ```
/// let move = BattlesnakeMove(move: .up)
/// ```
struct BattlesnakeMove {

    /// Represents the direction of the move.
    enum Move: String {
        case up
        case down
        case left
        case right
    }
    
    let move: Move
}

/// `BattlesnakeObject` is a data structure that represents a Battlesnake in the game.
/// See: https://docs.battlesnake.com/api/objects/battlesnake
///
/// It contains the following properties:
/// - `id`: A string representing the unique identifier for this Battlesnake in the context of the current Game.Example: "totally-unique-snake-id"
/// - `name`: A string representing the name given to this Battlesnake by its author. Example: "Sneky McSnek Face"
/// - `health`: An integer representing the current health value of this Battlesnake, between 0 and 100 inclusively. Example: 54
/// - `body`: An array of `Coord` representing the coordinates of each segment of the Battlesnake's body. It is ordered from head to tail.
/// - `latency`: A string representing the previous response time of this Battlesnake, in milliseconds. If the Battlesnake timed out and failed to respond, the game timeout will be returned (game.timeout)Example: "500"
/// - `shout`: A string representing a message shouted by this Battlesnake on the previous turn. Example: "why are we shouting??"
/// - `squad`: An optional string representing the squad that the Battlesnake belongs to. Used to identify squad members in Squad Mode games. Example: "1"
/// - `customizations`: A `Customizations` struct representing the collection of customizations that control how this Battlesnake is displayed.
///
/// It also has computed properties:
/// - `head`: A `Coord` representing the head of the Battlesnake. It is the first element of the `body` array.
/// - `length`: The length of the snake (same as the number of items in the `body` array).
///
/// The `Customizations` nested struct represents the visual customizations of the Battlesnake. It includes:
/// - `color`: A string representing the color of the Battlesnake in hexadecimal color code.
/// - `head`: A string representing the type of head the Battlesnake has.
/// - `tail`: A string representing the type of tail the Battlesnake has.
///
/// Example usage:
/// ```
/// let mySnake = BattlesnakeObject(
///     id: "snake1",
///     name: "MySnake",
///     health: 100,
///     body: [Coord(x: 0, y: 0), Coord(x: 1, y: 0)],
///     latency: "123ms"
/// )
/// ```
struct BattlesnakeObject {
    /// Represents the visual customizations of the Battlesnake. It includes:
    /// - `color`: A string representing the color of the Battlesnake in hexadecimal color code.
    /// - `head`: A string representing the type of head the Battlesnake has.
    /// - `tail`: A string representing the type of tail the Battlesnake has.
    /// 
    /// The `Customizations` struct has a static `default` property that provides a default `Customizations` instance.
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

/// `BattlesnakeGameState` is a data structure that represents the state of the game at a given turn.
/// See: https://docs.battlesnake.com/api/webhooks
/// 
/// It contains the following properties:
/// - `game`: A `BattlesnakeGame` value that contains information about the game being played.
/// - `turn`: An Int representing the current turn of the game.
/// - `board`: A `BattlesnakeBoard` value that represents the game board.
/// - `you`: A `BattlesnakeObject` value that represents the Battlesnake controlled by the player.
struct BattlesnakeGameState {
    let game: BattlesnakeGame
    let turn: Int
    let board: BattlesnakeBoard
    let you: BattlesnakeObject
}

/// `BattlesnakeGame` is a data structure that represents the game being played.
/// See: https://docs.battlesnake.com/api/objects/game
///
/// It contains the following properties:
/// - `id`: A string representing a unique identifier for this game. Example: "totally-unique-game-id".
/// - `ruleset`: A Ruleset value that contains information about the ruleset being used to run this game. Example: Ruleset("name": "standard", "version": "v1.2.3").
/// - `map`: A string identifying the name of the map being played on. Example: "standard"
/// - `timeout`: An Int representing how much time your snake has (in ms) to respond to requests for this Game. Example: 500
/// - `source`: A string representing the source of this game. One of: "tournament", "league" (for League Arenas), "arena" (for all other Arenas), "challenge", "custom" (for all other games sources). Example: "arena". The values for this field may change in the near future.
struct BattlesnakeGame {

    /// Information about the ruleset being used to run this game.
    /// See: https://docs.battlesnake.com/api/objects/ruleset
    /// 
    /// It contains the following properties:
    /// - `name`: A string representing the name of the ruleset. Example: "standard".
    /// - `version`: A string representing the release version of the Rules module used in this game. Example: "version": "v1.2.3".
    struct Ruleset {
        let name: String
        let version: String
        let settings: RulesetSettings
    }

    /// Settings for the ruleset being used to run this game.
    /// See: https://docs.battlesnake.com/api/objects/ruleset-settings
    /// 
    /// It contains the following properties:
    /// - `foodSpawnChance`: An Int representing the chance that a new food item will spawn on the board each turn. Example: 15.
    /// - `minimumFood`: An Int representing the minimum number of food items that will be present on the board at any given time. Example: 1.
    /// - `hazardDamagePerTurn`: An Int representing the amount of damage that hazards will deal to a Battlesnake each turn. Example: 14.
    /// - `royale`: An optional `Royale` value that contains settings specific to Royale games.
    /// - `squad`: An optional `Squad` value that contains settings specific to Squad games.
    /// In principe all properties are always sent, however as some of the example JSON do not include royale and squad, these are optional here.
    struct RulesetSettings {
        /// Settings specific to Royale games.
        /// 
        /// It contains the following properties:
        /// - `shrinkEveryNTurns`: An Int representing - in Royale mode - the number of turns between generating new hazards (shrinking the safe board space).
        struct Royale {
            let shrinkEveryNTurns: Int
        }

        /// Settings specific to Squad games.
        /// 
        /// It contains the following properties:
        /// - `allowBodyCollisions`: A Bool representing - in Squad mode - allow members of the same squad to move over each other without dying.
        /// - `sharedElimination`: A Bool representing - in Squad mode - all squad members are eliminated when one is eliminated.
        /// - `sharedHealth`: A Bool representing - in Squad mode - all squad members share health.
        /// - `sharedLength`: A Bool representing - in Squad mode - all squad members share length.
        struct Squad {
            let allowBodyCollisions: Bool
            let sharedElimination: Bool
            let sharedHealth: Bool
            let sharedLength: Bool
        }

        let foodSpawnChance: Int
        let minimumFood: Int
        let hazardDamagePerTurn: Int
        let royale: Royale?
        let squad: Squad?
    }

    let id: String
    let ruleset: Ruleset
    let map: String
    let timeout: Int
    let source: String
}

/// `BattlesnakeBoard` is a data structure that represents the game board.
/// See: https://docs.battlesnake.com/api/objects/board
/// 
/// It contains the following properties:
/// - `height`: An integer representing the height of the game board. Example: 11
/// - `width`: An integer representing the width of the game board. Example: 11
/// - `food`: An array of `Coord` representing the coordinates of each food item on the board.
/// - `hazards`: An array of `Coord` representing the coordinates of each hazard on the board.
/// - `snakes`: An array of `BattlesnakeObject` representing the remaining snakes on the board.
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

extension BattlesnakeGame.RulesetSettings.Royale: Content { }
extension BattlesnakeGame.RulesetSettings.Royale: Equatable { }

extension BattlesnakeGame.RulesetSettings.Squad: Content { }
extension BattlesnakeGame.RulesetSettings.Squad: Equatable { }

extension BattlesnakeGame.RulesetSettings: Content { }
extension BattlesnakeGame.RulesetSettings: Equatable { }

extension BattlesnakeGame.Ruleset: Content { }
extension BattlesnakeGame.Ruleset: Equatable { }

extension BattlesnakeGame: Content { }
extension BattlesnakeGame: Equatable { }

extension BattlesnakeBoard: Content { }
extension BattlesnakeBoard: Equatable { }

//extension BattlesnakeGame.