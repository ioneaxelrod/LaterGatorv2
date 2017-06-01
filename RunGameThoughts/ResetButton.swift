//
//  resetButton.swift
//  RunGameThoughts
//
//  Created by Ione Axelrod on 4/21/17.
//  Copyright © 2017 Ione Axelrod. All rights reserved.
//

import Foundation
import SpriteKit

class ResetButton {
    
    var sprite = SKSpriteNode(imageNamed: ImageNameConstants.RESET_BUTTON_SPRITE_NAME)
    
    init() {
        self.sprite.name = ImageNameConstants.RESET_BUTTON_SPRITE_NAME
        self.sprite.size = CGSize(width: self.sprite.size.width * 0.1,
                                  height: self.sprite.size.height * 0.1)
    }
}
