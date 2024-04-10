//
//  File.swift
//  
//
//  Created by Maarten Engels on 10/04/2024.
//

import Foundation
import Vapor

// MARK: BattlesnakeInfo
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

extension BattlesnakeInfo: Equatable { }

extension BattlesnakeInfo: Content { }
