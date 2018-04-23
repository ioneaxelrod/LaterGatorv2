//
//  PhysicsTests.swift
//  PhysicsTests
//
//  Created by Ione Axelrod on 6/5/17.
//  Copyright © 2017 Ione Axelrod. All rights reserved.
//

import XCTest
import SpriteKit
@testable import RunGameThoughts

class PhysicsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSetPlayerCollision() {
        let testSprite = SKSpriteNode(imageNamed: "pixiegirl1")
        testSprite.physicsBody = SKPhysicsBody(rectangleOf: testSprite.size)
        PhysicsUtils.setPlayerCollision(sprite: testSprite)
        
        XCTAssertEqual(testSprite.physicsBody?.categoryBitMask, 1)
        XCTAssertEqual(testSprite.physicsBody?.contactTestBitMask, 4)
        XCTAssertEqual(testSprite.physicsBody?.collisionBitMask, 0)
    
    }
    
    func testSetCollisionProperties() {
        let testSprite = SKSpriteNode(imageNamed: "pixiegirl1")
        testSprite.physicsBody = SKPhysicsBody(rectangleOf: testSprite.size)
        PhysicsUtils.setCollisionProperties(sprite: testSprite,
                               category: 1,
                               contactTest: 1,
                               collision: 1)
        
        XCTAssertEqual(testSprite.physicsBody?.categoryBitMask, 1)
        XCTAssertEqual(testSprite.physicsBody?.contactTestBitMask, 1)
        XCTAssertEqual(testSprite.physicsBody?.collisionBitMask, 1)

    }
    
    func testSetMonsterCollision() {
        let testSprite = SKSpriteNode(imageNamed: "pixiegirl1")
        testSprite.physicsBody = SKPhysicsBody(rectangleOf: testSprite.size)
        PhysicsUtils.setMonsterCollision(sprite: testSprite)
    
        XCTAssertEqual(testSprite.physicsBody?.categoryBitMask, 2)
        XCTAssertEqual(testSprite.physicsBody?.contactTestBitMask, 4)
        XCTAssertEqual(testSprite.physicsBody?.collisionBitMask, 0)
        
    }
    
    func testSetObstacleCollision() {
        let testSprite = SKSpriteNode(imageNamed: "pixiegirl1")
        testSprite.physicsBody = SKPhysicsBody(rectangleOf: testSprite.size)
        PhysicsUtils.setObstacleCollision(sprite: testSprite)
    
        XCTAssertEqual(testSprite.physicsBody?.categoryBitMask, 4)
        XCTAssertEqual(testSprite.physicsBody?.contactTestBitMask, 3)
        XCTAssertEqual(testSprite.physicsBody?.collisionBitMask, 0)
    }
    
    
    
    
}
