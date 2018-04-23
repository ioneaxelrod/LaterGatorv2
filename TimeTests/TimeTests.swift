//
//  TimeTests.swift
//  TimeTests
//
//  Created by Ione Axelrod on 6/5/17.
//  Copyright © 2017 Ione Axelrod. All rights reserved.
//

import XCTest
@testable import RunGameThoughts

class TimeTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testIsSoundPlayValid() {
        GameTime.timeSinceLastSoundPlay = 10
        XCTAssert(GameTime.isSoundPlayValid())
    }

    func testIsJumpActionValid() {
        GameTime.timeSinceLastJump = 10
        XCTAssert(GameTime.isJumpActionValid())

    }

    func testIsTouchActionValid() {
        GameTime.timeSinceLastPress = 10
        XCTAssert(GameTime.isTouchActionValid())
    }

    func testUpdateTime() {
        GameTime.timeSinceLastPress = 1.0
        GameTime.timeSinceLastJump = 1.0
        GameTime.timeSinceLastSoundPlay = 1.0
        GameTime.updateTime()

        XCTAssertEqual(GameTime.timeSinceLastPress, 1.1)
        XCTAssertEqual(GameTime.timeSinceLastJump, 1.1)
        XCTAssertEqual(GameTime.timeSinceLastSoundPlay, 1.1)

    }

//    static func updateTime() {
//        timeSinceLastPress += TIME_INTERVAL_CHECK_INCREMENT
//        timeSinceLastSoundPlay += TIME_INTERVAL_CHECK_INCREMENT
//        timeSinceLastJump += TIME_INTERVAL_CHECK_INCREMENT
//    }

}
