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

class Player: GameScoreObject {
    
    override init() {
        super.init()
        self.sprite = SKSpriteNode(imageNamed: ImageNameConstants.PLAYER_SPRITE_NAME)
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
    
    override func decreaseScore(points: Int) {
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

class Monster: GameScoreObject {
    
    override init() {
        super.init()
        self.sprite = SKSpriteNode(imageNamed: ImageNameConstants.MONSTER_SPRITE_NAME)
        self.sprite.name = ImageNameConstants.MONSTER_SPRITE_NAME
        self.sprite.physicsBody = SKPhysicsBody(rectangleOf: sprite.size)
        self.sprite.physicsBody?.isDynamic = false
        self.sprite.zPosition = 4
        //collision-related properties
        PhysicsUtils.setMonsterCollision(sprite: self.sprite)
    }
    
    func incrementMove() {
        self.score += 5
    }
    
    func checkMonsterScore() -> Int {
        return self.score
    }
    
    override func decreaseScore(points: Int) {
        self.score -= points
        damageMonster()
    }
    
    func damageMonster() {
        let pulsedRed = SKAction.sequence([
                                                  SKAction.colorize(with: .red, colorBlendFactor: 1.0, duration: 0.20),
                                                  SKAction.wait(forDuration: 0.1),
                                                  SKAction.colorize(withColorBlendFactor: 0.0, duration: 0.20)])
        self.sprite.run(pulsedRed)
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

class TrashCan: GameObstacle {
    override init() {
        super.init()
        self.sprite = SKSpriteNode(imageNamed: ImageNameConstants.TRASH_CAN_SPRITE_NAME)
        self.sprite.name = ImageNameConstants.TRASH_CAN_SPRITE_NAME
        self.sprite.zPosition = 2
        self.sprite.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.sprite.size.width * 0.6,
                                                                    height: self.sprite.size.height * 0.9))
        PhysicsUtils.setObstacleCollision(sprite: self.sprite)
    
        self.sprite.physicsBody?.isDynamic = false
        self.sprite.physicsBody?.affectedByGravity = false
    
    
    }
}

class OilSlick: GameObstacle {
    
    override init() {
        super.init()
        self.sprite = SKSpriteNode(imageNamed: ImageNameConstants.OIL_SLICK_SPRITE_NAME)
        self.sprite.name = ImageNameConstants.OIL_SLICK_SPRITE_NAME
        self.sprite.zPosition = 2
        self.sprite.physicsBody = SKPhysicsBody(rectangleOf: self.sprite.size)
    
        PhysicsUtils.setObstacleCollision(sprite: self.sprite)
    
        self.sprite.physicsBody?.isDynamic = false
        self.sprite.physicsBody?.affectedByGravity = false
    
    
    }
}

class Bat: GameObstacle {
    
    override init() {
        super.init()
        self.sprite = SKSpriteNode(imageNamed: ImageNameConstants.BAT_SPRITE_NAME)
        self.sprite.name = ImageNameConstants.BAT_SPRITE_NAME
        self.sprite.zPosition = 2
        self.sprite.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.sprite.size.width * 0.8,
                                                                     height: self.sprite.size.height * 0.8))
        self.speed = TimeInterval(random(min: 2.0, max: 3.5))
    
        PhysicsUtils.setObstacleCollision(sprite: self.sprite)
    
        self.sprite.physicsBody?.isDynamic = false
        self.sprite.physicsBody?.affectedByGravity = false
    
    
    
    }
}

class Ghost: GameObstacle {
    
    override init() {
        super.init()
        self.sprite = SKSpriteNode(imageNamed: ImageNameConstants.GHOST_SPRITE_NAME)
        self.sprite.name = ImageNameConstants.GHOST_SPRITE_NAME
        self.sprite.zPosition = 3
        self.sprite.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.sprite.size.width * 0.8,
                                                                    height: self.sprite.size.height * 0.8))
        self.speed = TimeInterval(random(min: 2.0, max: 3.5))
    
        PhysicsUtils.setObstacleCollision(sprite: self.sprite)
    
        self.sprite.physicsBody?.isDynamic = false
        self.sprite.physicsBody?.affectedByGravity = false
    
    
    
    }
}

class Spider: GameObstacle {
    
    override init() {
        super.init()
        self.sprite = SKSpriteNode(imageNamed: ImageNameConstants.SPIDER_SPRITE_NAME)
        self.sprite.name = ImageNameConstants.SPIDER_SPRITE_NAME
        self.sprite.zPosition = 3
        self.sprite.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.sprite.size.width * 0.8,
                                                                    height: self.sprite.size.height * 0.8))
        self.speed = TimeInterval(random(min: 2.0, max: 3.5))
    
        PhysicsUtils.setObstacleCollision(sprite: self.sprite)
    
        self.sprite.physicsBody?.isDynamic = false
        self.sprite.physicsBody?.affectedByGravity = false
    
    
    
    }

}