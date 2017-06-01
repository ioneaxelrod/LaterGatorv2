//
//  PlayPauseButton.swift
//  RunGameThoughts
//
//  Created by Ione Axelrod on 5/18/17.
//  Copyright © 2017 Ione Axelrod. All rights reserved.
//

import Foundation
import SpriteKit

class PauseButton {
    let sprite = SKSpriteNode(imageNamed: ImageNameConstants.PAUSE_BUTTON_SPRITE_NAME)
    
    init() {
        sprite.name = ImageNameConstants.PAUSE_BUTTON_SPRITE_NAME
        sprite.size = CGSize(width: sprite.size.width * 0.2,
                             height: sprite.size.height * 0.2)
    }
    
}
