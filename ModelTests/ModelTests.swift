//
//  ModelTests.swift
//  ModelTests
//
//  Created by Ione Axelrod on 5/31/17.
//  Copyright © 2017 Ione Axelrod. All rights reserved.
//

import XCTest
@testable import RunGameThoughts

class ModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCheckMonsterScore() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let monster = Monster()
        monster.monsterScore = 10
        XCTAssertEqual(monster.checkMonsterScore(), 10)
        
    }
    
    func testIncrementMove() {
        let monster = Monster()
        monster.monsterScore = 15
        monster.incrementMove()
        XCTAssertEqual(monster.checkMonsterScore(), 20)
    }
    
    func testMoveAway() {
        let monster = Monster()
        monster.monsterScore = 15
        monster.moveAway(number: 5)
        XCTAssertEqual(monster.checkMonsterScore(), 10)
    }
    
    func testMoveCloser() {
        let monster = Monster()
        monster.monsterScore = 15
        monster.moveCloser(number: 5)
        XCTAssertEqual(monster.checkMonsterScore(), 20)
    }

    
}
