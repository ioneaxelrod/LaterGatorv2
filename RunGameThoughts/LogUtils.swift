//
//  Logger.swift
//  RunGameThoughts
//
//  Created by Ione Axelrod on 5/12/17.
//  Copyright © 2017 Ione Axelrod. All rights reserved.
//

import Foundation

class Logger {
    
    var monster: Monster?
    var player: Player?
    
    private static let singletonLogger = Logger()
    //there can only be one
    
    private init() {
        logMessage(message: "Game Logger Activated")
    }
    
    static func getLogger() -> Logger {
        return Logger.singletonLogger
    }
    
    func baseLineLogger() -> String {
        if self.monster != nil || self.player != nil {
            return "[M: \(self.monster!.monsterScore)] [P: \(self.player!.score)]"
        }
        return ""
    }
    
    func logMessage(message: String) {
        let logMessage = baseLineLogger() + "    " + message
        print(logMessage)
    }
    
    func setLogger(monster: Monster,
            player: Player) {
        self.monster = monster
        self.player = player
    }
    
}
