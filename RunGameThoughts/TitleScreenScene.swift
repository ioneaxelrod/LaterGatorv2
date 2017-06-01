//
//  TitleScreenScene.swift
//  RunGameThoughts
//
//  Created by Ione Axelrod on 5/23/17.
//  Copyright © 2017 Ione Axelrod. All rights reserved.
//

import Foundation
import SpriteKit


class TitleScreenScene: SKScene {
    let thePlayer = Player()
    let theMonster = Monster()
    var log = Logger.getLogger()
    let backgroundMusic = SKAudioNode(fileNamed: "shining.mp3")
    let nameLabel = SKLabelNode(fontNamed: "Courier")
    
    override init(size: CGSize) {
        super.init(size: size)
    }
    
    override func didMove(to view: SKView) {
        let titleScreen = SKSpriteNode(imageNamed: "newbackgroundscalar1")
        titleScreen.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        titleScreen.zPosition = -2
        
        let titleWords = SKSpriteNode(imageNamed: "floatingTitle")
        titleWords.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        titleWords.zPosition = 6
        
        nameLabel.position = CGPoint(x: self.size.width/2, y: self.size.height * 0.05)
        nameLabel.text = "By Axelrod"
        nameLabel.fontSize = 30
        nameLabel.fontColor = SKColor.black
    
    
        backgroundMusic.autoplayLooped = true
        addChild(backgroundMusic)
        
        thePlayer.sprite.position = CGPoint(x: -self.size.width/2.5,
                                            y: self.size.height * PLAYER_START_HEIGHT_ADJUSTMENT)
        theMonster.sprite.position = CGPoint(x: -self.size.width/2.5,
                                             y: self.size.height / 2)
        
        addChild(titleScreen)
        addChild(titleWords)
        addChild(thePlayer.sprite)
        addChild(theMonster.sprite)
        addChild(nameLabel)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapScreen))
        view.addGestureRecognizer(tap)
        
        run(SKAction.repeatForever(
            SKAction.sequence([
                SKAction.run(movePlayerAndMonster),
                SKAction.run(animatePlayerAndMonster),
                SKAction.wait(forDuration: 5.0)
                ])
        ))

    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    func movePlayerAndMonster() {
        let playerMove = SKAction.moveTo(x: self.size.width + thePlayer.sprite.size.width, duration: 3.0)
        let monsterMove = SKAction.moveTo(x: self.size.width + theMonster.sprite.size.width, duration: 3.0)
        
        self.thePlayer.sprite.run(playerMove)
        self.theMonster.sprite.run(SKAction.sequence([
            SKAction.wait(forDuration: 1.0),
            monsterMove
            ]))
        thePlayer.sprite.position = CGPoint(x: -self.size.width/2.5,
                                            y: self.size.height * PLAYER_START_HEIGHT_ADJUSTMENT)
        theMonster.sprite.position = CGPoint(x: -self.size.width/2.5,
                                             y: self.size.height / 2)
    }
    
    func animatePlayerAndMonster() {
        run(SKAction.repeatForever(
            SKAction.sequence([
                SKAction.run({AnimationUtils.animatePlayerRun(playerSprite: self.thePlayer.sprite)}),
                SKAction.run({AnimationUtils.animateMonsterRun(monsterSprite: self.theMonster.sprite)}),
                SKAction.wait(forDuration: 0.1)
                ])
        ))
    }
    
    func tapScreen() {
        log.logMessage(message: "Tapped Screen")
        run(
            SKAction.run() {
                self.view?.presentScene(GameScene(size: self.size))
            }
        )

    }


}


