//
//  GameScene.swift
//  RunGameThoughts
//
//  Created by Ione Axelrod on 4/19/17.
//  Copyright © 2017 Ione Axelrod. All rights reserved.
//

import SpriteKit
import GameplayKit

/* Game Scene Class ===========
 *
 *
 *
 */

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    /**************************Game Setup Functions**************************/
    
    var thePlayer = Player()
    var theMonster = Monster()
    var log = Logger.getLogger()
    
    let statusLabel = SKLabelNode(fontNamed: "ArialMT")
    var theResetButton = ResetButton()
    let theSlider = SliderBar()
    let thePlayPauseButton = PauseButton()
    let backgroundMusic = SKAudioNode(fileNamed: "Homework.mp3")
    
    /* Did Move
     *
     * Runs the game and sets up local variables on screen
     *
     */
    override func didMove(to view: SKView) {
        if GameBalanceConstants.debugMode {
            let skView = self.view!
            skView.showsFPS = true
            skView.showsNodeCount = true
            skView.showsPhysics = true
            
            enableStatusLabel()
        }
        
        
        log.setLogger(monster: theMonster, player: thePlayer)
        
        log.logMessage(message: "Screen Width: [\(self.size.width)]    Screen Height:[\(self.size.height)]")
        // Physics
        physicsWorld.contactDelegate = self
        
        // Background Color
        backgroundColor = SKColor.white
        
        // Background Music
        backgroundMusic.autoplayLooped = true
        addChild(backgroundMusic)
        
        
        // PanGesture
        let pan = UIPanGestureRecognizer(target: self, action: #selector(pan(gesture:)))
        view.addGestureRecognizer(pan)
        
        // Sprite Positions
        setSpritePositions()
        
        // Place Sprites into Scene
        addSpriteChildren()
        
        // Set Up Repeating Functions
        runRepeatingFunctions()
        
        // Debug
        addTestObstacles()
        // Check If Run
        log.logMessage(message: "Game Running")
    }
    
    func setSpritePositions() {
        let centerOfScreenX = self.size.width / 2
        // Player
        thePlayer.sprite.position = CGPoint(x: self.size.width / 2.5,
                                            y: self.size.height * PLAYER_START_HEIGHT_ADJUSTMENT)
        // Monster
        theMonster.sprite.position = CGPoint(x: -centerOfScreenX,
                                             y: self.size.height / 2)
        
        // SliderBar
        theSlider.sprite.position = CGPoint(x: centerOfScreenX,
                                            y: self.size.height * SLIDER_BAR_POSITION_ADJUSTMENT)
        theSlider.sprite.size = CGSize(width: self.size.width * SLIDER_BAR_POSITION_ADJUSTMENT,
                                       height: theSlider.sprite.size.height)
        theSlider.toggle.sprite.position = CGPoint(x: centerOfScreenX * BEGINNING_TOGGLE_ADJUSTMENT,
                                                   y: self.size.height * SLIDER_BAR_POSITION_ADJUSTMENT)
        
        // Reset Button
        theResetButton.sprite.position = CGPoint(x: self.size.width * RESET_BUTTON_PLACEMENT_WIDTH_ADJUSTMENT,
                                                 y: self.size.height * RESET_BUTTON_PLACEMENT_HEIGHT_ADJUSTMENT)
        // Pause Button
        thePlayPauseButton.sprite.position = CGPoint(x: self.size.width * (RESET_BUTTON_PLACEMENT_WIDTH_ADJUSTMENT + 0.05),
                                                     y: self.size.height * RESET_BUTTON_PLACEMENT_HEIGHT_ADJUSTMENT)
        
        // Background
        createGrounds()
        
    }
    
    func addSpriteChildren() {
        addChild(theMonster.sprite)
        addChild(thePlayer.sprite)
        addChild(theSlider.sprite)
        addChild(theSlider.toggle.sprite)
        addChild(theResetButton.sprite)
        addChild(thePlayPauseButton.sprite)
        log.logMessage(message: "Sprite Children Added")
        
    }
    
    func runRepeatingFunctions() {
        setPlayerRunAnimation()
        setMonsterRunAnimation()
        setMonsterActions()
        setObjectActions()
        setTimer()
    }
    
    /**************************Repeating Functions**************************/
    
    func setMonsterActions() {
        repeatActions(functionToRepeat: updateMonster,
                      waitInterval: GameTime.UPDATE_MONSTER_DELAY_TIME_INTERVAL)
    }
    
    func setObjectActions() {
        repeatActions(functionToRepeat: addObject,
                      waitInterval: GameTime.UPDATE_MONSTER_DELAY_TIME_INTERVAL)
    }
    
    func setTimer() {
        repeatActions(functionToRepeat: GameTime.updateTime,
                      waitInterval: GameTime.TIME_INTERVAL_CHECK_INCREMENT)
    }
    
    //repeating calls for doing animation
    func setPlayerRunAnimation() {
        repeatActions(functionToRepeat: { AnimationUtils.animatePlayerRun(playerSprite: self.thePlayer.sprite) }, waitInterval: 0.1)
    }
    
    func setMonsterRunAnimation() {
        repeatActions(functionToRepeat: { AnimationUtils.animateMonsterRun(monsterSprite: self.theMonster.sprite) }, waitInterval: 0.1)
    }
    
    
    //Repeat Action Function
    func repeatActions(functionToRepeat: @escaping () -> Void, waitInterval: TimeInterval) {
        run(SKAction.repeatForever(
                SKAction.sequence([
                                          SKAction.run(functionToRepeat),
                                          SKAction.wait(forDuration: waitInterval)
                                  ])
        ))
    }
    
    
    
    /**************************Debug Functions**************************/
    func addTestObstacles() {
        var count = 0
        for string in ImageNameConstants.items {
            let obstacle = Obstacle(spriteFileName: string)
            let speed = 2.0 + Double(count)
            let centerOfSprite = obstacle.sprite.size.width / 2
            
            obstacle.sprite.position = CGPoint(x: centerOfSprite + size.width + CGFloat(100 * count),
                                               y: size.height * PLAYER_START_HEIGHT_ADJUSTMENT)
            addChild(obstacle.sprite)
            
            let actionMove = SKAction.move(to: CGPoint(x: -(centerOfSprite),
                                                       y: size.height * PLAYER_START_HEIGHT_ADJUSTMENT),
                                           duration: TimeInterval(speed))
            let actionMoveDone = SKAction.removeFromParent()
            obstacle.sprite.run(SKAction.sequence([actionMove, actionMoveDone]))
            
            log.logMessage(message: "\(string) test model generated")
            count += 1
            
        }
    }
    
    func enableStatusLabel() {
        statusLabel.fontSize = STATUS_LABEL_FONT_SIZE
        statusLabel.fontColor = FONT_COLOR
        statusLabel.position = CGPoint(x: self.size.width * LABEL_LOCATION,
                                       y: self.size.height * LABEL_LOCATION)
        addChild(statusLabel)
    }
    
    /**************************Obstacle Functions**************************/
    
    /* Add Object adds the obstacles/objects to the game.
     *
     *
     *
     */
    func addObject() {
        // choose type of object
        let itemName = generateWhichObject()
        // object
        let obstacle = Obstacle(spriteFileName: itemName)
        
        let speed = random(min: RANDOM_MOVE_SPEED_MIN,
                           max: RANDOM_MOVE_SPEED_MAX)
        let centerOfSprite = obstacle.sprite.size.height / 2
        // where monster/objects will spawn along y axis
        var randomY = random(min: centerOfSprite,
                             max: self.size.height * MAX_SPRITE_HEIGHT_POSITION_ADJUSTMENT - centerOfSprite)
        
        if obstacle.sprite.name == ImageNameConstants.TRASH_CAN_SPRITE_NAME ||
                   obstacle.sprite.name == ImageNameConstants.OIL_SLICK_SPRITE_NAME {
            randomY = random(min: centerOfSprite,
                             max: self.size.height * 0.3 - centerOfSprite)
        }
        
        // object position (spawn off immediately screen on x axis, and random point on y)
        obstacle.sprite.position = CGPoint(x: self.size.width + obstacle.sprite.size.width / 2,
                                           y: randomY)
        
        // object spawns
        addChild(obstacle.sprite)
        
        if obstacle.sprite.name == ImageNameConstants.GHOST_SPRITE_NAME {
            log.logMessage(message: "Animate Ghost")
            repeatActions(functionToRepeat: { AnimationUtils.animateGhostFloat(ghostSprite: obstacle.sprite) }, waitInterval: 0.05)
        }
        if obstacle.sprite.name == ImageNameConstants.BAT_SPRITE_NAME {
            log.logMessage(message: "Animate Bat")
            repeatActions(functionToRepeat: { AnimationUtils.animateBatFlap(batSprite: obstacle.sprite) }, waitInterval: 0.05)
        }
        
        obstacle.glide(point: CGPoint(x: -centerOfSprite, y: randomY),
                       speed: TimeInterval(speed))
        // glide is the actual moving of the sprite
        
    }
    
    /* Generate Which Object
 *
 * randomly chooses a type of object to create that moves across screen
 *
 */
    func generateWhichObject() -> String {
        let randomIndex = Int(arc4random_uniform(UInt32(ImageNameConstants.items.count)))
        log.logMessage(message: "\(ImageNameConstants.items[randomIndex]) Randomly Selected")
        return ImageNameConstants.items[randomIndex]
        
    }
    
    /**************************Background Functions**************************/
    
    
    /* Just makes sure Background moves
     *
     *
     *
     */
    override func update(_ currentTime: TimeInterval) {
        moveGrounds()
    }
    
    func createGrounds() {
        let background = Background()
        var position = CGFloat(0)
        for sprite in background.sprites {
//            sprite.size = CGSize(width: (self.scene?.size.width)!,
//                                 height: (self.scene?.size.height)!)
            sprite.position = CGPoint(x: position * sprite.size.width,
                                      y: ZeroConstants.ZERO_CGFLOAT + sprite.size.height / 2)
            position += 1
            self.addChild(sprite)
        }
    }
    
    func moveGrounds() {
        self.enumerateChildNodes(withName: "background", using: ({
            (node, error) in
            node.position.x -= MOVE_FLOOR_BY
            
            if node.position.x < -(self.scene?.size.width)! {
                node.position.x += (self.scene?.size.width)! * NUMBER_OF_FLOORS
            }
        }))
    }
    
    
    /**************************Monster Score End Condition Functions**************************/
    
    /* Update Monster
     *
     * Moves the monster's score counter, glides the monster, and updates the score label/slider
     * Also checks if monster reaches player
     */
    func updateMonster() {
        theMonster.incrementMove()
        monsterMove()
        updateLabel()
        moveToggle()
        checkAndTriggerEndCondition()
        log.logMessage(message: "")
    }
    
    /* Monster Move
 *
 * Determines position of monster depending on monster's score
 *
 */
    func monsterMove() {
        let monsterXCoord
                = self.size.width / 2.5 * CGFloat(theMonster.monsterScore) * MONSTER_MOVEMENT_RATIO_ADJUSTMENT - theMonster.sprite.size.width / 2
        let monsterYCoord = theMonster.sprite.size.height / 2
        let monsterMovement = SKAction.move(to: CGPoint(x: monsterXCoord, y: monsterYCoord), duration: GameTime.TIME_MONSTER_IS_MOVING)
        theMonster.sprite.run(monsterMovement)
    }
    
    /* Update Label
 *
 * Updates player and monster scores on label
 *
 */
    func updateLabel() {
        statusLabel.text = "Monster Points: \(theMonster.monsterScore) \n Player Points: \(thePlayer.score)"
    }
    
    /* Check End Condition
     * 
     * Checks bools to see if player is eaten or player wins. if either, it transitions into win or lose screen
     *
     */
    func checkAndTriggerEndCondition() {
        if thePlayer.score >= GameBalanceConstants.WIN_SCORE_SCALE {
            gameOver(win: true)
        }
        
        if theMonster.monsterScore >= GameBalanceConstants.WIN_SCORE_SCALE {
            gameOver(win: false)
        }
    }
    
    /* Move Toggle
 *
 * moves toggle on slider bar dependent on monster score
 *
 */
    
    func moveToggle() {
        
        let xBarBeginning = self.size.width * BEGINNING_TOGGLE_ADJUSTMENT
        let togglePosition = theSlider.sprite.size.width * CGFloat(theMonster.monsterScore) / CGFloat(GameBalanceConstants.WIN_SCORE_SCALE)
        
        var moveToX = xBarBeginning + togglePosition
        let moveToY = self.size.height * SLIDER_BAR_POSITION_ADJUSTMENT
        
        if moveToX < xBarBeginning {
            moveToX = xBarBeginning
        }
        
        let toggleMove
                = SKAction.move(to: CGPoint(x: moveToX, y: moveToY),
                                duration: TimeInterval(GameTime.UPDATE_MONSTER_DELAY_TIME_INTERVAL))
        theSlider.toggle.sprite.run(toggleMove)
        
    }

/* Game Over
 *
 * Ends the Game and transitions into end screen
 *
 */
    func gameOver(win: Bool) {
        run(
                SKAction.run() {
                    self.view?.presentScene(GameOverScene(size: self.size, won: win))
                }
        )
    }
    
    
    /* Did Begin (Contact)
     *
     * Triggers when a Collision between 2 objects is detected.
     * Only has impl for a Player + Obstacle interaction (usually +- points).
     *
     */
    func didBegin(_ contact: SKPhysicsContact) {
        log.logMessage(message: "Contact Between Objects Initiated")
        
        var person: SKPhysicsBody
        var obstacle: SKPhysicsBody
        
        if(contact.bodyA.categoryBitMask == PhysicsUtils.PlayerCategory &&
                contact.bodyB.categoryBitMask == PhysicsUtils.ObstacleCategory) {
            person = contact.bodyA
            obstacle = contact.bodyB
            objectCollidedWithPlayer(object: (obstacle.node as? SKSpriteNode)!,
                                     player: (person.node as? SKSpriteNode)!)
            
        } else if(contact.bodyB.categoryBitMask == PhysicsUtils.PlayerCategory &&
                contact.bodyA.categoryBitMask == PhysicsUtils.ObstacleCategory) {
            person = contact.bodyB
            obstacle = contact.bodyA
            objectCollidedWithPlayer(object: (obstacle.node as? SKSpriteNode)!,
                                     player: (person.node as? SKSpriteNode)!)
        }
    }
    
    /* Object Collided With Player
     *
     * Removes the object from screen and adjusts player and monster scores
     *
     */
    func objectCollidedWithPlayer(object: SKSpriteNode, player: SKSpriteNode) {
        switch object.name! {
        case ImageNameConstants.BAT_SPRITE_NAME:
            thePlayer.decreaseScore(points: GameBalanceConstants.MEDIUM_HIT)
            theMonster.moveCloser(number: GameBalanceConstants.MINOR_HIT)
            //run(SKAction.playSoundFileNamed("batcry.mp3", waitForCompletion: false))
            playPlayerHurtSound()
            object.removeFromParent()
            log.logMessage(message: "\(ImageNameConstants.BAT_SPRITE_NAME) collided with Player")
            break
        case ImageNameConstants.GHOST_SPRITE_NAME:
            thePlayer.decreaseScore(points: GameBalanceConstants.MINOR_HIT)
            log.logMessage(message: "\(ImageNameConstants.GHOST_SPRITE_NAME) collided with Player")
            // run(SKAction.playSoundFileNamed("ghostmoan2.mp3", waitForCompletion: false))
            playPlayerHurtSound()
            object.removeFromParent()
            break
        case ImageNameConstants.TRASH_CAN_SPRITE_NAME:
            
            thePlayer.increaseScore(points: GameBalanceConstants.MEDIUM_HIT)
            theMonster.moveAway(number: GameBalanceConstants.MEDIUM_HIT)
            log.logMessage(message: "\(ImageNameConstants.TRASH_CAN_SPRITE_NAME) collided with Player")
            break
        case ImageNameConstants.OIL_SLICK_SPRITE_NAME:
            thePlayer.increaseScore(points: GameBalanceConstants.MEDIUM_HIT)
            theMonster.moveAway(number: GameBalanceConstants.MEDIUM_HIT)
            log.logMessage(message: "\(ImageNameConstants.OIL_SLICK_SPRITE_NAME) collided with Player")
        default:
            log.logMessage(message: "ERROR: Collision Not Supposed to Happen")
            break
        }
    }
    
    func playPlayerHurtSound() {
        
        let randomIndex = Int(arc4random_uniform(UInt32(ImageNameConstants.cries.count)))
        run(SKAction.playSoundFileNamed(ImageNameConstants.cries[randomIndex], waitForCompletion: false))
        
    }
    
    func playMonsterHurtSound() {
        run(SKAction.playSoundFileNamed("monsterroar.mp3", waitForCompletion: false))
    }
    
    /**************************TOUCH NODE FUNCTIONS**************************/
    
    /* Touches Began
     *
     * senses touches by user. runs a general touch down function and a check node function for hitting reset button
     *
     */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            touchDown(atPoint: t.location(in: self))
            let positionInScene = t.location(in: self)
            selectNodeForTouch(touchLocation: positionInScene)
        }
    }
    
    /* Touch Down
     *
     * senses touch, reports location user pressed
     *
     */
    func touchDown(atPoint pos: CGPoint) {
        let message = "User touched down at [\(Int(pos.x)), \(Int(pos.y))]"
        log.logMessage(message: message)
    }
    
    
    /* Select Node For Touch
     *
     * Determines what node you touched and runs code for that particular node
     * Currently only used for reset button
     */
    func selectNodeForTouch(touchLocation: CGPoint) {
        
        let touchedNode = self.atPoint(touchLocation)
        
        if touchedNode is SKSpriteNode {
            if touchedNode.name == ImageNameConstants.RESET_BUTTON_SPRITE_NAME {
                if(GameBalanceConstants.debugMode) {
                    run(
                            SKAction.run() {
                                self.view?.presentScene(GameOverScene(size: self.size, won: false))
                            }
                    )
                } else {
                    run(
                            SKAction.run() {
                                self.view?.presentScene(GameScene(size: self.size))
                            }
                    )
                }
                log.logMessage(message: "Reset Button Activated")
            }
            
            if touchedNode.name == ImageNameConstants.PAUSE_BUTTON_SPRITE_NAME ||
                       touchedNode.name == ImageNameConstants.PLAY_BUTTON_SPRITE_NAME {
                
                if (self.scene?.view?.isPaused)! {
                    self.scene?.view?.isPaused = false
                    thePlayPauseButton.pressButton()
                    log.logMessage(message: "Game Unpaused")
                    
                } else {
                    self.scene?.view?.isPaused = true
                    thePlayPauseButton.pressButton()
                    log.logMessage(message: "Game Paused")
                }
                
            }
            if touchedNode.name == ImageNameConstants.TRASH_CAN_SPRITE_NAME {
                
                if GameTime.isTouchActionValid() {
                    if checkPlayerDistance(touchedNode: touchedNode) && isCritical(touchedNode: touchedNode) {
                        criticalHit(node: touchedNode)
                        activateTrashCan(trashSprite: touchedNode)
                    } else if checkPlayerDistance(touchedNode: touchedNode) {
                        activateTrashCan(trashSprite: touchedNode)
                    }
                }
                log.logMessage(message: "Trash Can node distance from Player [\(touchedNode.position.distance(point: (thePlayer.sprite.physicsBody?.node?.position)!))]")
            }
            if touchedNode.name == ImageNameConstants.OIL_SLICK_SPRITE_NAME {
                
                if GameTime.isTouchActionValid() {
                    if checkPlayerDistance(touchedNode: touchedNode) && isCritical(touchedNode: touchedNode) {
                        criticalHit(node: touchedNode)
                        activateOilSlick(oilSprite: touchedNode)
                    } else if checkPlayerDistance(touchedNode: touchedNode) {
                        activateOilSlick(oilSprite: touchedNode)
                    }
                }
                log.logMessage(message: "Trash Can node distance from Player [\(touchedNode.position.distance(point: (thePlayer.sprite.physicsBody?.node?.position)!))]")
            }
        }
    }
    
    // Checks how far sprite is from touch and makes sure that the sprite is not behind the player
    
    func checkPlayerDistance(touchedNode: SKNode) -> Bool {
        if touchedNode.position.distance(point: (thePlayer.sprite.physicsBody?.node?.position)!) < self.size.width * GameBalanceConstants.NODE_IS_CLOSE_ENOUGH_TO_TOUCH_RATIO &&
                   touchedNode.position.x >= thePlayer.sprite.position.x {
            return true
        }
        return false
    }
    
    func isCritical(touchedNode: SKNode) -> Bool {
        if touchedNode.position.distance(point: (thePlayer.sprite.physicsBody?.node?.position)!) < self.size.width * GameBalanceConstants.NODE_IS_CLOSE_ENOUGH_TO_CRITICAL_HIT_RATIO {
            return true
        }
        return false
    }
    
    func criticalHit(node: SKNode) {
        thePlayer.increaseScore(points: GameBalanceConstants.CRITICAL_HIT)
        theMonster.moveAway(number: GameBalanceConstants.CRITICAL_HIT)
        node.zRotation = .pi
        log.logMessage(message: "Critical Hit Activated")
    }
    
    func playJumpSound() {
        if GameTime.isSoundPlayValid() {
            run(SKAction.playSoundFileNamed("jump.mp3", waitForCompletion: false))
        }
    }
    
    //Activates Trashcan Sprite and does his effects
    func activateTrashCan(trashSprite: SKNode) {
        //good effects of trashcan
        //trashSprite.zRotation = .pi / 2
        AnimationUtils.animateTipTrash(trashSprite: trashSprite as! SKSpriteNode)
        thePlayer.increaseScore(points: GameBalanceConstants.MEDIUM_HIT)
        theMonster.moveAway(number: GameBalanceConstants.MEDIUM_HIT)
        run(SKAction.playSoundFileNamed("glassbreak.mp3", waitForCompletion: false))
        playMonsterHurtSound()
        log.logMessage(message: "Player used Trash Can")
    }
    
    func activateOilSlick(oilSprite: SKNode) {
        thePlayer.increaseScore(points: GameBalanceConstants.MEDIUM_HIT)
        theMonster.moveAway(number: GameBalanceConstants.MEDIUM_HIT)
        repeatActions(functionToRepeat: {
            AnimationUtils.animateOilFire(oilSprite: oilSprite as! SKSpriteNode)
        },
                      waitInterval: 0.1)
        run(SKAction.playSoundFileNamed("sizzle.mp3", waitForCompletion: false))
        playMonsterHurtSound()
        log.logMessage(message: "Player used Oil Slick")
    }
    
    
    /**************************Player Swipe Functions**************************/
    
    
    /* Swipe Distance Function
     * Finds the Distance from beginning to end of swipe.
     * Gesture: Pan Gesture
     *
     */
    func pan(gesture: UIPanGestureRecognizer) {
        log.logMessage(message: "Player Position: [\(Int((thePlayer.sprite.position.y)))]")
        log.logMessage(message: "Where Player Needs to Be to Jump: [\(Int((self.size.height * PLAYER_START_HEIGHT_ADJUSTMENT)))]")
        
        if GameTime.isJumpActionValid() == false {
            return
        }
//        if thePlayer.sprite.position.y != self.size.height * PLAYER_START_HEIGHT_ADJUSTMENT {
//            return
//        }
        
        let yEnd = gesture.translation(in: gesture.view).y
        let yStart = gesture.location(in: gesture.view).y
        
        let maxJumpHeight = self.size.height * MAX_SPRITE_HEIGHT_POSITION_ADJUSTMENT
        let mediumJumpHeight = self.size.height * 0.6
        let smallJumpHeight = self.size.height * 0.4
        
        let xValue = self.size.width / 2.5
        
        var jump = SKAction()
        
        // jump = SKAction.move(to: CGPoint(x: self.size.width/2, y: maxJumpHeight), duration: 1.0)
        
        if distanceMoved(d1: yEnd, d2: yStart) > 200 {
            jump = SKAction.move(to: CGPoint(x: xValue, y: maxJumpHeight),
                                 duration: 0.4)
        } else if distanceMoved(d1: yEnd, d2: yStart) > 100 {
            jump = SKAction.move(to: CGPoint(x: xValue, y: mediumJumpHeight),
                                 duration: 0.4)
        } else {
            jump = SKAction.move(to: CGPoint(x: xValue, y: smallJumpHeight),
                                 duration: 0.4)
        }
        let fall
                = SKAction.move(to: CGPoint(x: xValue, y: self.size.height * PLAYER_START_HEIGHT_ADJUSTMENT),
                                duration: 0.5)
        
        playJumpSound()
        thePlayer.sprite.run(SKAction.sequence([
                                                       jump,
                                                       fall]
        ))
        log.logMessage(message: "Pan Distance Score = [\(distanceMoved(d1: yEnd, d2: yStart))]")
        
    }
    
    /* Distance Moved
     * Measures how far something has moved. Only can determine distance if purely vertical or horizontal
     * d1: first distance
     * d2: second distance
     */
    
    func distanceMoved(d1: CGFloat, d2: CGFloat) -> CGFloat {
        return abs(d1 - d2) * 0.5
    }
    
}
