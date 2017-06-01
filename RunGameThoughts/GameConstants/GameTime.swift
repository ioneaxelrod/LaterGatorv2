//
// Created by Ione Axelrod on 5/17/17.
// Copyright (c) 2017 Ione Axelrod. All rights reserved.
//

import Foundation

class GameTime {
    //private static let timer = TimeUtils()
    
    private init() {
    }
    
    static let TIME_BEFORE_USER_CAN_PUSH_AGAIN: TimeInterval = 0.5
    static let UPDATE_MONSTER_DELAY_TIME_INTERVAL: TimeInterval = 1.0
    static let FLIP_TRANSITION_SCREEN_TIME: TimeInterval = 0.1
    static let TIME_INTERVAL_CHECK_INCREMENT: TimeInterval = 0.1
    static let TIME_MONSTER_IS_MOVING: TimeInterval = 1.0
    static let TIME_BEFORE_SOUND_PLAYS_AGAIN: TimeInterval = 1.0
    static let TIME_BEFORE_PLAYER_CAN_JUMP_AGAIN: TimeInterval = 1.0
    
    static var timeSinceLastPress: TimeInterval = 0
    static var timeSinceLastSoundPlay: TimeInterval = 0
    static var timeSinceLastJump: TimeInterval = 0
    
    static func isTouchActionValid() -> Bool {
        if timeSinceLastPress > TIME_BEFORE_USER_CAN_PUSH_AGAIN {
            timeSinceLastPress = 0
            return true
        }
        return false
    }
    
    static func isSoundPlayValid() -> Bool {
        if timeSinceLastSoundPlay > TIME_BEFORE_SOUND_PLAYS_AGAIN {
            timeSinceLastSoundPlay = 0
            return true
        }
        return false
    }
    
    static func isJumpActionValid() -> Bool {
        if timeSinceLastJump > TIME_BEFORE_PLAYER_CAN_JUMP_AGAIN {
            timeSinceLastJump = 0
            return true
        }
        return false
    }
    
    static func updateTime() {
        timeSinceLastPress += TIME_INTERVAL_CHECK_INCREMENT
        timeSinceLastSoundPlay += TIME_INTERVAL_CHECK_INCREMENT
        timeSinceLastJump += TIME_INTERVAL_CHECK_INCREMENT
    }
    
}
