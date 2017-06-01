//
//  GameOverScene.swift
//  RunGameThoughts
//
//  Created by Ione Axelrod on 4/21/17.
//  Copyright © 2017 Ione Axelrod. All rights reserved.
//

import Foundation
import SpriteKit

class GameOverScene: SKScene {
    
    var points:Int
    let log = Logger.getLogger()
    let backgroundMusic = SKAudioNode(fileNamed: "forever.mp3")
    
    
    init(size: CGSize, points: Int) {
        
        self.points = points
        super.init(size: size)
    }
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.black
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapScreen))
        view.addGestureRecognizer(gesture)
    
        backgroundMusic.autoplayLooped = true
        addChild(backgroundMusic)
        
        let gameOver = SKSpriteNode(imageNamed: ImageNameConstants.GAME_OVER_WORDS)
    
        gameOver.position = CGPoint(x: self.size.width / 2, y: self.size.height - gameOver.size.height / 1.5)
        gameOver.zPosition = 1
    
        let monsterChew = SKSpriteNode(imageNamed: ImageNameConstants.BLOOD_SPRITE_NAME)
        monsterChew.position = CGPoint(x: 0, y: monsterChew.size.height / 2)
        monsterChew.zPosition = 2
        addChild(monsterChew)
    
        run(SKAction.repeatForever(
                SKAction.sequence([
                                          SKAction.run({ AnimationUtils.animateBloodMouth(bloodSprite: monsterChew) }),
                                          SKAction.wait(forDuration: 0.1)
                                  ])
        ))
    
        let message = "Points: \(points)"

// label settings
        let label = SKLabelNode(fontNamed: "Courier")
        label.text = message
        label.fontSize = 30
        label.fontColor = SKColor.red
        label.position = CGPoint(x: size.width / 2, y: size.height * 0.1)

// create label
        addChild(label)
        addChild(gameOver)
    }
    
    func tapScreen() {
        log.logMessage(message: "Tapped Screen Screen")
        run(
                SKAction.run() {
                    self.view?.presentScene(TitleScreenScene(size: self.size))
                }
        )
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
