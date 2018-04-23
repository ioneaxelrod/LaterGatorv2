//
//  PhysicsBodies.swift
//  RunGameThoughts
//
//  Created by Ione Axelrod on 5/14/17.
//  Copyright © 2017 Ione Axelrod. All rights reserved.
//

import Foundation
import SpriteKit

class PhysicsUtils {

    // TODO: Make these a enum
    static let PlayerCategory: UInt32 = 0b0001 //1
    static let MonsterCategory: UInt32 = 0b0010 // 2
    static let ObstacleCategory: UInt32 = 0b0100 // 4
    static let BoundaryCategory: UInt32 = 0b1000 // 8

    static func setCollisionProperties(sprite: SKSpriteNode, category: UInt32, contactTest: UInt32, collision: UInt32 = 0) {
        Logger.getLogger().logMessage(message: "Collision Properties for: \(sprite.name ?? ""). Category: \(category). Contact: \(contactTest). Collision:  \(collision)")

        sprite.physicsBody?.categoryBitMask = category
        sprite.physicsBody?.contactTestBitMask = contactTest // sends notification of contact, calls didbegin
        sprite.physicsBody?.collisionBitMask = collision // allows interaction of objects against each other
        sprite.physicsBody?.usesPreciseCollisionDetection = true
    }

    static func setPlayerCollision(sprite: SKSpriteNode) {
        setCollisionProperties(sprite: sprite, category: PlayerCategory, contactTest: ObstacleCategory)
    }

    static func setMonsterCollision(sprite: SKSpriteNode) {
        setCollisionProperties(sprite: sprite, category: MonsterCategory, contactTest: ObstacleCategory)
    }

    static func setObstacleCollision(sprite: SKSpriteNode) {
        setCollisionProperties(sprite: sprite, category: ObstacleCategory, contactTest: PlayerCategory | MonsterCategory)
    }
}
