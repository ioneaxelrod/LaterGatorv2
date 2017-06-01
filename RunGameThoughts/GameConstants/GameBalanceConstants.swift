//
// Sets values that control how fair/unfair the game is.
//
// Created by Ione Axelrod on 5/16/17.
// Copyright (c) 2017 Ione Axelrod. All rights reserved.
//

import Foundation
import SpriteKit

class GameBalanceConstants {
    private init() {
    }
    
    static var debugMode = true
    
    
    // Arbitrary point SCALE used to indicate victory for either Player and Monster.
    // Both player and monster start at 0 points.
    // (100 is just good for doing math)
    static let WIN_SCORE_SCALE: Int = 100
    
    // Percentage of the screen that the monster moves per second.
    static let MONSTER_INCREMENT_AMOUNT: Int = 5
    
    // Different types of hits reward different points
    static let MINOR_HIT: Int = 3
    static let MEDIUM_HIT: Int = 5
    static let CRITICAL_HIT: Int = 10
    
    // Ratio to Screen Width to make sure nodePlayerWantsToTouch is close enough to the Player physicsBody to touch
    static let NODE_IS_CLOSE_ENOUGH_TO_TOUCH_RATIO: CGFloat = 0.2
    static let NODE_IS_CLOSE_ENOUGH_TO_CRITICAL_HIT_RATIO: CGFloat = 0.1
    
    public static func switchDebugMode(view: SKView?) {
        let skView = view!
        
        if self.debugMode {
            skView.showsFPS = true
            skView.showsNodeCount = true
            skView.showsPhysics = true
            
        } else {
            skView.showsFPS = false
            skView.showsNodeCount = false
            skView.showsPhysics = false
            
        }
    }
}
