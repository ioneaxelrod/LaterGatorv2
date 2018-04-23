
//  Object.swift
//  RunGameThoughts
//
//  Created by Ione Axelrod on 4/20/17.
//  Copyright © 2017 Ione Axelrod. All rights reserved.


import Foundation
import SpriteKit
import GameplayKit



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