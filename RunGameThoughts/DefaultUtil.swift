//
//  UTIL.swift
//  RunGameThoughts
//
//  Created by Ione Axelrod on 4/24/17.
//  Copyright © 2017 Ione Axelrod. All rights reserved.
//

import Foundation
import SpriteKit

/*Helper Functions
 *
 *
 *
 */
func random() -> CGFloat {
    return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
}

func random(min: CGFloat, max: CGFloat) -> CGFloat {
    return random() * (max - min) + min
}

extension CGPoint {
    func distance(point: CGPoint) -> CGFloat {
        let dx = self.x - point.x
        let dy = self.y - point.y
        return sqrt(dx * dx + dy * dy);
    }
}

/**********/

/* Constants
 *
 *
 *
 */


//Label Defaults
let LABEL_LOCATION: CGFloat = 0.8
let STATUS_LABEL_FONT_SIZE: CGFloat = 12
let GAME_END_LABEL_SIZE = 40
let FONT_COLOR = UIColor.black

//Toggle Adjustments
let BEGINNING_TOGGLE_ADJUSTMENT: CGFloat = 0.05
let TOGGLE_POSITION_ADJUSTMENT = 5

//Height and Width Adjustments
let RESET_BUTTON_PLACEMENT_WIDTH_ADJUSTMENT: CGFloat = 0.9
let RESET_BUTTON_PLACEMENT_HEIGHT_ADJUSTMENT: CGFloat = 0.1
let PLAYER_START_HEIGHT_ADJUSTMENT: CGFloat = 0.2
let GROUND_HEIGHT: CGFloat = 100
let SLIDER_BAR_POSITION_ADJUSTMENT: CGFloat = 0.9
let MAX_SPRITE_HEIGHT_POSITION_ADJUSTMENT: CGFloat = 0.85

//Object Min and Max Speed
let OBJECT_SPEED_MAX: CGFloat = 4.0
let OBJECT_SPEED_MIN: CGFloat = 2.0

//Grounds Info
let MOVE_FLOOR_BY: CGFloat = 4.0
let NUMBER_OF_FLOORS: CGFloat = 3.0

//Sprite Size Adjustments
let SKULL_SIZE_ADJUSTMENT: CGFloat = 0.25
let RESET_BUTTON_SIZE_ADJUSTMENT: CGFloat = 0.1

//Movement Adjustment
let MONSTER_MOVEMENT_RATIO_ADJUSTMENT: CGFloat = 0.01

//Positioning
let POSITION_FOR_BACKGROUND_ITEMS: CGFloat = -1.0

//Random Movement Speed
let RANDOM_MOVE_SPEED_MIN: CGFloat = 2.0
let RANDOM_MOVE_SPEED_MAX: CGFloat = 4.0











