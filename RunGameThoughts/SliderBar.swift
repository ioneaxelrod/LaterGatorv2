//
//  SliderBarAndToggle.swift
//  RunGameThoughts
//
//  Created by Ione Axelrod on 5/2/17.
//  Copyright © 2017 Ione Axelrod. All rights reserved.
//

import Foundation
import SpriteKit

class SliderBar {
    
    var sprite = SKSpriteNode(imageNamed: ImageNameConstants.SLIDER_BAR_SPRITE_NAME)
    var toggle = Toggle()
    
    init() {
        self.sprite.zPosition = POSITION_FOR_BACKGROUND_ITEMS
    }
    
    class Toggle {
        var sprite = SKSpriteNode(imageNamed: ImageNameConstants.SKULL_SPRITE_NAME)
        init() {
            self.sprite.size = CGSize(
                    width: self.sprite.size.width * SKULL_SIZE_ADJUSTMENT,
                    height: self.sprite.size.height * SKULL_SIZE_ADJUSTMENT)
        }
    }
    
}


    
    
    
    

    

