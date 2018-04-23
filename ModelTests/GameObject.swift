//
// Created by Ione Axelrod on 5/31/17.
// Copyright (c) 2017 Ione Axelrod. All rights reserved.
//

import Foundation
import SpriteKit

class GameObject {
    
    var sprite: SKSpriteNode
    
    init() {
        self.sprite = SKSpriteNode(imageNamed: "player")
    }
}

class GameScoreObject: GameObject {
    
    var score = 0
    
    func increaseScore(points: Int) {
        self.score += points
    }
    
    func decreaseScore(points: Int) {
        self.score -= points
    }
}


class GameObstacle: GameObject {
    
    var speed:TimeInterval
    
    override init() {
        self.speed = 4.0
        super.init()
    
        self.sprite.physicsBody?.isDynamic = false
        self.sprite.physicsBody?.affectedByGravity = false
    
        //collision-related properties
        PhysicsUtils.setObstacleCollision(sprite: self.sprite)
    }
    
    func glide(point: CGPoint) {
        let actionMove = SKAction.move(to: point, duration: speed)
        let actionMoveDone = SKAction.removeFromParent()
        self.sprite.run(SKAction.sequence([actionMove, actionMoveDone]))
    }
}
