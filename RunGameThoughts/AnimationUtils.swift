//
// Created by Ione Axelrod on 5/16/17.
// Copyright (c) 2017 Ione Axelrod. All rights reserved.
//

import Foundation
import SpriteKit

class AnimationUtils {
    private init() {
    }
    
    //individual execution of an animation
    public static func animatePlayerRun(playerSprite: SKSpriteNode) {
        let playerAtlas = SKTextureAtlas(named: ImageNameConstants.PLAYER_ATLAS_NAME)
        animate(sprite: playerSprite,
                textureStrings: ImageNameConstants.PLAYER_TEXTURES,
                timePerFrame: 0.05,
                atlas: playerAtlas)
    }
    
    public static func animateMonsterRun(monsterSprite: SKSpriteNode) {
        let monsterAtlas = SKTextureAtlas(named: ImageNameConstants.MONSTER_ATLAS_NAME)
        animate(sprite: monsterSprite,
                textureStrings: ImageNameConstants.MONSTER_TEXTURES,
                timePerFrame: 0.05,
                atlas: monsterAtlas)
    }
    
    public static func animateTipTrash(trashSprite: SKSpriteNode) {
        let trashAtlas = SKTextureAtlas(named: ImageNameConstants.TRASH_CAN_ATLAS_NAME)
        animate(sprite: trashSprite,
                textureStrings: ImageNameConstants.TRASH_CAN_TEXTURES,
                timePerFrame: 0.02,
                atlas: trashAtlas)
        let changeSprite = SKAction.setTexture(trashAtlas.textureNamed(ImageNameConstants.TRASH_CAN_TEXTURE4_NAME))
        trashSprite.run(changeSprite)
    }
    
    public static func animateOilFire(oilSprite: SKSpriteNode) {
        let oilAtlas = SKTextureAtlas(named: ImageNameConstants.OIL_SLICK_ATLAS_NAME)
        animate(sprite: oilSprite, textureStrings: ImageNameConstants.OIL_SLICK_TEXTURES, timePerFrame: 0.02, atlas: oilAtlas)
    }
    
    public static func animateGhostFloat(ghostSprite: SKSpriteNode) {
        let ghostAtlas = SKTextureAtlas(named: ImageNameConstants.GHOST_ATLAS_NAME)
        animate(sprite: ghostSprite, textureStrings: ImageNameConstants.GHOST_TEXTURES, timePerFrame: 0.02, atlas: ghostAtlas)
    }
    
    public static func animateBatFlap(batSprite: SKSpriteNode) {
        let batAtlas = SKTextureAtlas(named: ImageNameConstants.BAT_ATLAS_NAME)
        animate(sprite: batSprite, textureStrings: ImageNameConstants.BAT_TEXTURES, timePerFrame: 0.02, atlas: batAtlas)
    }
    
    public static func animateSpiderSkitter(spiderSprite: SKSpriteNode) {
        let spiderAtlas = SKTextureAtlas(named: ImageNameConstants.SPIDER_ATLAS_NAME)
        animate(sprite: spiderSprite, textureStrings: ImageNameConstants.SPIDER_TEXTURES, timePerFrame: 0.02, atlas: spiderAtlas)
    }
    
    public static func animateBloodMouth(bloodSprite: SKSpriteNode) {
        let bloodAtlas = SKTextureAtlas(named: ImageNameConstants.BLOOD_ATLAS_NAME)
        animate(sprite: bloodSprite, textureStrings: ImageNameConstants.BLOOD_TEXTURES, timePerFrame: 0.02, atlas: bloodAtlas)
    }
    
    //helper function to do animation from a set of texture strings
    private static func animate(sprite: SKSpriteNode,
            textureStrings: [String],
            timePerFrame: TimeInterval,
            atlas: SKTextureAtlas) {
        var skTextures = [SKTexture]()
        for textureString in textureStrings {
            skTextures.append(atlas.textureNamed(textureString))
        }
        
        let animation = SKAction.animate(with: skTextures, timePerFrame: timePerFrame)
        sprite.run(animation)
    }
}


