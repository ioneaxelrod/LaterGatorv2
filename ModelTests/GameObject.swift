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

class GameObstacle: GameObject {
    
    var speed:TimeInterval
    
    override init() {
        self.speed = 4.0
        super.init()
    
        self.sprite.physicsBody?.isDynamic = true
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
    }
}

class OilSlick: GameObstacle {
    
    override init() {
        super.init()
        self.sprite = SKSpriteNode(imageNamed: ImageNameConstants.OIL_SLICK_SPRITE_NAME)
        self.sprite.name = ImageNameConstants.OIL_SLICK_SPRITE_NAME
        self.sprite.zPosition = 2
        self.sprite.physicsBody = SKPhysicsBody(rectangleOf: self.sprite.size)
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
    }
}

class Spider: GameObstacle {

}