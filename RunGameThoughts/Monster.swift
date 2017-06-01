//
//  Monster.swift
//  RunGameThoughts
//
//  Created by Ione Axelrod on 4/19/17.
//  Copyright © 2017 Ione Axelrod. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class Monster {
    
    let sprite = SKSpriteNode(imageNamed: ImageNameConstants.MONSTER_SPRITE_NAME)
    var monsterScore: Int = ZeroConstants.ZERO_INT
    
    init() {
        self.sprite.name = ImageNameConstants.MONSTER_SPRITE_NAME
        self.sprite.physicsBody = SKPhysicsBody(rectangleOf: sprite.size)
        self.sprite.physicsBody?.isDynamic = false
        self.sprite.zPosition = 4
        //collision-related properties
        PhysicsUtils.setMonsterCollision(sprite: self.sprite)
    }
    
    func moveCloser(number: Int) {
        self.monsterScore += number
    }
    
    func moveAway(number: Int) {
        self.monsterScore -= number
        damageMonster()
    }
    
    func incrementMove() {
        self.monsterScore += 5
    }
    
    func checkMonsterScore() -> Int {
        return self.monsterScore
    }
    
    func damageMonster() {
        let pulsedRed = SKAction.sequence([
                                                  SKAction.colorize(with: .red, colorBlendFactor: 1.0, duration: 0.20),
                                                  SKAction.wait(forDuration: 0.1),
                                                  SKAction.colorize(withColorBlendFactor: 0.0, duration: 0.20)])
        self.sprite.run(pulsedRed)
    }
}

/*
 
 30 second elevator pitch of how the model will be represented
 
 -lore
 1.
 2.
 3.
 
 - functional -mvp
 1. The goal of the game is to avoid being hit by the monster
 2. To make sure the monster doesnt hit you, you need to perform certain actions.
 3. these actions will be represented by interactions with certain objects. User needs to interact with screen at correct timings to lower monster hit success score.
 
 
 - technical
 1. the monster will hit you when he hits 100 points. the player can mitigate by using objects. to use the objects, they have to measure collisions and taps. if you collide without tapping, you might just lose points.
 2. objects will be instantiated offscreen, and move toward the player
 3. they will appear on different parts of the yaxis. the player must also be able to traverse the yaxis in order to reach certain objects
 
 
 
 - technical (refined)
 Core game:
 1. An int ranging from 0 (init) to 100 (hit), governs monster hit success.
 2. Scale monster hit success wrt time, at 5 points per second.
 2.5 Write test to instantiate monster, and verify that his score increases over time.
 
 UI interaction:
 3. Correct timings occur when user taps within 500ms of a collision occuring. < this is a module for the game. write a function that polls the user for interaction and returns an integer of quality based on how fast they responded.
 3.5 Connect the UI quality integer * Object quality integer with +/- monster hitscore.
 
 Spawning:
 4. create a method that spawns obstacles and objects
 4.5 The obstacles and objects move across the screen at x speed
 4.6 write test to instantiate some objects, and verify that they take y seconds to move across the screen.
 
 Collisions:
 5. Based on 4.5, determine using current game engine how to detect a collision
 5.5 Once a collision is detected, invoke #3
 
 UI:
 Real ui shit
 1.
 2.
 3.
 
 */

