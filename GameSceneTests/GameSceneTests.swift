//
//  GameSceneTests.swift
//  GameSceneTests
//
//  Created by Ione Axelrod on 6/6/17.
//  Copyright © 2017 Ione Axelrod. All rights reserved.
//

import XCTest
import SpriteKit
@testable import RunGameThoughts

class GameSceneTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDidMove() {
        let frame = CGSize(width: 1334, height: 750)
        let testScene = GameScene(size: frame)
        testScene.didMove(to: SKView())

        
        
        
        
        
    }
    
//    override func didMove(to view: SKView) {
//        if GameBalanceConstants.debugMode {
//            let skView = self.view!
//            skView.showsFPS = true
//            skView.showsNodeCount = true
//            skView.showsPhysics = true
//            enableStatusLabel()
//        }
//
//        log.setLogger(monster: theMonster, player: thePlayer)
//        log.logMessage(message: "Screen Width: [\(self.size.width)]    Screen Height:[\(self.size.height)]")
//
//        log.logMessage(message: "\(thePlayer.sprite.physicsBody!.categoryBitMask)")
//
//
//        // Physics
//        physicsWorld.contactDelegate = self
//
//        // Background Color
//        backgroundColor = SKColor.white
//
//        // Background Music
//        backgroundMusic.autoplayLooped = true
//        addChild(backgroundMusic)
//
//        // Gesture
//        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(swipedUp))
//        swipeUp.direction = .up
//        view.addGestureRecognizer(swipeUp)
//
//        // Sprite Positions
//        setSpritePositions()
//
//        // Place Sprites into Scene
//        addSpriteChildren()
//
//        // Set Up Repeating Functions
//        runRepeatingFunctions()
//
//        // Debug
//        //addTestObstacles()
//        // Check If Run
//        log.logMessage(message: "Game Running")
//    }
//
//    func testMonsterMove() {
//        let testScene = GameScene()
//        testScene.theMonster.score = 100
//
//        XCTAssertEqual(testScene.theMonster.sprite.position, CGPoint(x: 0,
//                                                                     y: 0))
//        testScene.monsterMove()
//
//        let monsterXCoord = testScene.size.width / 2.5 * CGFloat(testScene.theMonster.score) * MONSTER_MOVEMENT_RATIO_ADJUSTMENT - testScene.theMonster.sprite.size.width / 2
//        XCTAssertEqual(testScene.theMonster.sprite.position, CGPoint(x: monsterXCoord,
//                                                                     y: testScene.theMonster.sprite.size.height/2))
//
//
//
//    }
//
//    func monsterMove() {
//        let monsterXCoord = self.size.width / 2.5 * CGFloat(theMonster.score) * MONSTER_MOVEMENT_RATIO_ADJUSTMENT - theMonster.sprite.size.width / 2
//        let monsterYCoord = theMonster.sprite.size.height / 2
//        let monsterMovement = SKAction.move(to: CGPoint(x: monsterXCoord, y: monsterYCoord), duration: GameTime.TIME_MONSTER_IS_MOVING)
//        theMonster.sprite.run(monsterMovement)
//    }

    
}
