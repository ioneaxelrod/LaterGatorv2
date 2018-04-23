//
//  PlayerTests.swift
//  PlayerTests
//
//  Created by Ione Axelrod on 6/2/17.
//  Copyright © 2017 Ione Axelrod. All rights reserved.
//

import XCTest
@testable import RunGameThoughts


class PlayerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testIncreaseScore() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let player = Player()
        player.score = 40
        player.increaseScore(points: 5)
        XCTAssertEqual(player.score, 45)
    }
    
    func testDecreaseScore() {
        // This is an example of a performance test case.
            // Put the code you want to measure the time of here.
    }
    
}


/*
    func increaseScore(points: Int) {
        self.score += points
    }
    
    func decreaseScore(points: Int) {
        self.score -= points
        damagePlayer()
    }
*/