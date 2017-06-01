//
//  Object.swift
//  RunGameThoughts
//
//  Created by Ione Axelrod on 4/20/17.
//  Copyright © 2017 Ione Axelrod. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class Obstacle {
    var sprite = SKSpriteNode()
    
    init(spriteFileName: String) {
        switch spriteFileName {
        case ImageNameConstants.BAT_SPRITE_NAME:
            self.sprite = SKSpriteNode(imageNamed: ImageNameConstants.BAT_SPRITE_NAME)
            self.sprite.name = ImageNameConstants.BAT_SPRITE_NAME
            self.sprite.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.sprite.size.width * 0.8,
                                                                        height: self.sprite.size.height * 0.8))
            self.sprite.zPosition = 3
            break
        case ImageNameConstants.GHOST_SPRITE_NAME:
            self.sprite = SKSpriteNode(imageNamed: ImageNameConstants.GHOST_SPRITE_NAME)
            self.sprite.name = ImageNameConstants.GHOST_SPRITE_NAME
            self.sprite.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.sprite.size.width * 0.8,
                                                                        height: self.sprite.size.height * 0.8))
            self.sprite.zPosition = 3
            break
        case ImageNameConstants.TRASH_CAN_SPRITE_NAME:
            self.sprite = SKSpriteNode(imageNamed: "trash-can1")
            self.sprite.name = ImageNameConstants.TRASH_CAN_SPRITE_NAME
            self.sprite.zPosition = 2
            self.sprite.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.sprite.size.width * 0.6,
                                                                        height: self.sprite.size.height * 0.9))
            break
        case ImageNameConstants.OIL_SLICK_SPRITE_NAME:
            self.sprite = SKSpriteNode(imageNamed: ImageNameConstants.OIL_SLICK_SPRITE_NAME)
            self.sprite.name = ImageNameConstants.OIL_SLICK_SPRITE_NAME
            self.sprite.physicsBody = SKPhysicsBody(rectangleOf: self.sprite.size)
            self.sprite.zPosition = 1
            break
        case ImageNameConstants.SPIDER_SPRITE_NAME:
            self.sprite = SKSpriteNode(imageNamed: ImageNameConstants.SPIDER_SPRITE_NAME)
            self.sprite.name = ImageNameConstants.SPIDER_SPRITE_NAME
            self.sprite.physicsBody = SKPhysicsBody(rectangleOf: self.sprite.size)
            
            self.sprite.zPosition = 3
            break
        default:
            self.sprite = SKSpriteNode(imageNamed: ImageNameConstants.PLAYER_SPRITE_NAME)
            self.sprite.name = ImageNameConstants.PLAYER_SPRITE_NAME
        }
        
        self.sprite.physicsBody?.isDynamic = true
        self.sprite.physicsBody?.affectedByGravity = false
        
        //collision-related properties
        PhysicsUtils.setObstacleCollision(sprite: self.sprite)
    }
    
    func glide(point: CGPoint, speed: TimeInterval) {
        let actionMove = SKAction.move(to: point, duration: speed)
        let actionMoveDone = SKAction.removeFromParent()
        self.sprite.run(SKAction.sequence([actionMove, actionMoveDone]))
    }
    
    func glide(name: String, point: CGPoint) {
        var speed: TimeInterval
        
        switch name {
        case ImageNameConstants.BAT_SPRITE_NAME:
            speed = TimeInterval(random(min: 2.0, max: 3.5))
            break
        case ImageNameConstants.GHOST_SPRITE_NAME:
            speed = TimeInterval(random(min: 2.0, max: 3.5))
            break
        case ImageNameConstants.SPIDER_SPRITE_NAME:
            speed = TimeInterval(random(min: 2.0, max: 3.5))
            break
        case ImageNameConstants.TRASH_CAN_SPRITE_NAME:
            speed = 4.0
            break
        case ImageNameConstants.OIL_SLICK_SPRITE_NAME:
            speed = 4.0
            break
        default:
            speed = 4.0
            break
        }
        let actionMove = SKAction.move(to: point, duration: speed)
        let actionMoveDone = SKAction.removeFromParent()
        self.sprite.run(SKAction.sequence([actionMove, actionMoveDone]))
    }
    
}

