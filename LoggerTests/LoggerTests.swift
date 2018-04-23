//
//  LoggerTests.swift
//  LoggerTests
//
//  Created by Ione Axelrod on 6/6/17.
//  Copyright © 2017 Ione Axelrod. All rights reserved.
//

import XCTest
@testable import RunGameThoughts

class LoggerTests: XCTestCase {

    override func setUp() {
        super.setUp()

        let log = Logger.getLogger()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testBaseLineLogger() {

    }

//    func baseLineLogger() -> String {
//        if self.monster != nil || self.player != nil {
//            return "[M: \(self.monster!.score)] [P: \(self.player!.score)]"
//        }
//        return ""
//    }

}
