//
//  Player.swift
//  RunGameThoughts
//
//  Created by Ione Axelrod on 4/20/17.
//  Copyright © 2017 Ione Axelrod. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class Player {
    
    //runtime state
    var score: Int = 0
    //player definition
    var sprite = SKSpriteNode(imageNamed: ImageNameConstants.PLAYER_SPRITE_NAME)
    
    init() {

//        self.sprite.size = CGSize(width: sprite.size.width * 0.5,
//                                  height: sprite.size.height * 0.5)
        let hitBoxSize = CGSize(width: sprite.size.width * 0.55,
                                height: sprite.size.height * 0.8)
        
        self.sprite.name = ImageNameConstants.PLAYER_SPRITE_NAME
        
        
        self.sprite.physicsBody = SKPhysicsBody(rectangleOf: hitBoxSize,
                                                center: CGPoint(x: sprite.size.width * 0.1, y: 0.5))
        self.sprite.physicsBody?.isDynamic = true
        self.sprite.physicsBody?.affectedByGravity = false
        self.sprite.zPosition = 4
        
        //collision-related properties
        PhysicsUtils.setPlayerCollision(sprite: self.sprite)
        
    }
    
    func increaseScore(points: Int) {
        self.score += points
    }
    
    func decreaseScore(points: Int) {
        self.score -= points
        damagePlayer()
    }
    
    func damagePlayer() {
        let pulsedRed = SKAction.sequence([
                                                  SKAction.colorize(with: .red, colorBlendFactor: 1.0, duration: 0.20),
                                                  SKAction.wait(forDuration: 0.1),
                                                  SKAction.colorize(withColorBlendFactor: 0.0, duration: 0.20)])
        self.sprite.run(pulsedRed)
    }
    
}

