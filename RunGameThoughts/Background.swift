//
//  Background.swift
//  RunGameThoughts
//
//  Created by Ione Axelrod on 5/16/17.
//  Copyright © 2017 Ione Axelrod. All rights reserved.
//

import Foundation
import SpriteKit

class Background {
    let sprites: [SKSpriteNode] = [SKSpriteNode(imageNamed: "newbackgroundscalar1"),
                                   SKSpriteNode(imageNamed: "newbackgroundscalar1"),
                                   SKSpriteNode(imageNamed: "newbackgroundscalar1")]
    
    init() {
        for sprite in sprites {
            sprite.name = "background"
            sprite.zPosition = -2
        }
    }
}
