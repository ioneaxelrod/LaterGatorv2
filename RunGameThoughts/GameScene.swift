
        //  Created by Ione Axelrod on 4/19/17.
        //  Copyright © 2018 Ione Axelrod. All rights reserved.

        import SpriteKit
        import GameplayKit

        class GameScene: SKScene, SKPhysicsContactDelegate {

            // MARK: Game Setup Functions
            var thePlayer = Player()
            var theMonster = Monster()
            var log = Logger.getLogger()

            let labelNode = SKLabelNode(fontNamed: "courier")
            var theResetButton = ResetButton()
            let theDebugButton = SKSpriteNode(imageNamed: ImageNameConstants.PLAY_BUTTON_SPRITE_NAME)
            let theSlider = SliderBar()
            let thePauseButton = PauseButton()
            let backgroundMusic = SKAudioNode(fileNamed: "Homework.mp3")

            //Runs the game and sets up local variables on screen
            override func didMove(to view: SKView) {
                if GameBalanceConstants.debugMode {
                    let skView = self.view!
                    skView.showsFPS = true
                    skView.showsNodeCount = true
                    skView.showsPhysics = true
                    enableStatusLabel()
                }

                log.setLogger(monster: theMonster, player: thePlayer)
                log.log("Screen Width: [\(self.size.width)]    Screen Height:[\(self.size.height)]")
                log.log("\(thePlayer.sprite.physicsBody!.categoryBitMask)")

                physicsWorld.contactDelegate = self
                backgroundColor = SKColor.white
                backgroundMusic.autoplayLooped = true
                addChild(backgroundMusic)

                let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(swipedUp))
                swipeUp.direction = .up
                view.addGestureRecognizer(swipeUp)

                setSpritePositions()
                addSpriteChildren()

                runRepeatingFunctions()

                log.log("Game Running")
            }

            func setSpritePositions() {
                let centerOfScreenX = self.size.width / 2
            
                thePlayer.sprite.position = CGPoint(x: self.size.width / 2.5, y: self.size.height * PLAYER_START_HEIGHT_ADJUSTMENT)
                theMonster.sprite.position = CGPoint(x: -centerOfScreenX, y: self.size.height / 2)

                theSlider.sprite.position = CGPoint(x: centerOfScreenX, y: self.size.height * SLIDER_BAR_POSITION_ADJUSTMENT)
                theSlider.sprite.size = CGSize(width: self.size.width * SLIDER_BAR_POSITION_ADJUSTMENT,
                                               height: theSlider.sprite.size.height)
                theSlider.toggle.sprite.position = CGPoint(x: centerOfScreenX * BEGINNING_TOGGLE_ADJUSTMENT, y: self.size.height * SLIDER_BAR_POSITION_ADJUSTMENT)

                theResetButton.sprite.position = CGPoint(x: self.size.width * RESET_BUTTON_PLACEMENT_WIDTH_ADJUSTMENT, y: self.size.height * RESET_BUTTON_PLACEMENT_HEIGHT_ADJUSTMENT)

                thePauseButton.sprite.position = CGPoint(x: self.size.width * (RESET_BUTTON_PLACEMENT_WIDTH_ADJUSTMENT + 0.05), y: self.size.height * RESET_BUTTON_PLACEMENT_HEIGHT_ADJUSTMENT)

                theDebugButton.position = CGPoint(x: self.size.width * (RESET_BUTTON_PLACEMENT_WIDTH_ADJUSTMENT - 0.05), y: self.size.height * RESET_BUTTON_PLACEMENT_HEIGHT_ADJUSTMENT)
                theDebugButton.name = ImageNameConstants.PLAY_BUTTON_SPRITE_NAME
                theDebugButton.size = CGSize(width: theDebugButton.size.width * 0.2, height: theDebugButton.size.height * 0.2)

                // Background
                createGrounds()

            }

            func addSpriteChildren() {
                addChild(theMonster.sprite)
                addChild(thePlayer.sprite)
                addChild(theSlider.sprite)
                addChild(theSlider.toggle.sprite)
                addChild(theResetButton.sprite)
                addChild(thePauseButton.sprite)
                addChild(theDebugButton)
                log.log("Sprite Children Added")

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

            func enableStatusLabel() {
                labelNode.fontSize = STATUS_LABEL_FONT_SIZE
                labelNode.fontColor = FONT_COLOR
                labelNode.position = CGPoint(x: self.size.width * LABEL_LOCATION,
                                             y: self.size.height * LABEL_LOCATION)
                addChild(labelNode)
            }

            // MARK: Obstacle Functions

            func isOnGround(obstacle: GameObstacle) -> Bool {
                return obstacle.sprite.name == ImageNameConstants.TRASH_CAN_SPRITE_NAME || obstacle.sprite.name == ImageNameConstants.OIL_SLICK_SPRITE_NAME || obstacle.sprite.name == ImageNameConstants.SPIDER_SPRITE_NAME
            }

            func addObject() {
                // choose type of object
                let obstacle = generateWhichObject()
                let centerOfSprite = obstacle.sprite.size.height / 2
                // where monster/objects will spawn along y axis
                var randomY = random(min: centerOfSprite, max: self.size.height * MAX_SPRITE_HEIGHT_POSITION_ADJUSTMENT - centerOfSprite)

                if isOnGround(obstacle: obstacle) {
                    randomY = random(min: centerOfSprite, max: self.size.height * 0.3 - centerOfSprite)
                }

                // object position (spawn off immediately screen on x axis, and random point on y)
                obstacle.sprite.position = CGPoint(x: self.size.width + centerOfSprite, y: randomY)

                // object spawns
                addChild(obstacle.sprite)

                if obstacle.sprite.name == ImageNameConstants.GHOST_SPRITE_NAME {
                    log.log("Animate Ghost")
                    repeatActions(functionToRepeat: { AnimationUtils.animateGhostFloat(ghostSprite: obstacle.sprite) }, waitInterval: 0.05)
                }
                if obstacle.sprite.name == ImageNameConstants.BAT_SPRITE_NAME {
                    log.log("Animate Bat")
                    repeatActions(functionToRepeat: { AnimationUtils.animateBatFlap(batSprite: obstacle.sprite) }, waitInterval: 0.05)
                }
                if obstacle.sprite.name == ImageNameConstants.SPIDER_SPRITE_NAME {
                    log.log("Animate Spider")
                    repeatActions(functionToRepeat: { AnimationUtils.animateSpiderSkitter(spiderSprite: obstacle.sprite) }, waitInterval: 0.05)
                }

                obstacle.glide(point: CGPoint(x: -centerOfSprite, y: randomY))
                // glide is the actual moving of the sprite

            }

            //randomly chooses a type of object to create that moves across screen
            func generateWhichObject() -> GameObstacle {
                let randomIndex = Int(arc4random_uniform(UInt32(ImageNameConstants.items.count)))
                log.log("\(ImageNameConstants.items[randomIndex]) Randomly Selected")
                switch ImageNameConstants.items[randomIndex] {
                case ImageNameConstants.GHOST_SPRITE_NAME: return Ghost()
                case ImageNameConstants.TRASH_CAN_SPRITE_NAME: return TrashCan()
                case ImageNameConstants.BAT_SPRITE_NAME: return Bat()
                case ImageNameConstants.OIL_SLICK_SPRITE_NAME: return OilSlick()
                case ImageNameConstants.SPIDER_SPRITE_NAME: return Spider()
                default: return GameObstacle()
                }
            }

            // MARK  Background Functions

            override func update(_ currentTime: TimeInterval) {
                moveGrounds()
            }

            func createGrounds() {
                let background = Background()
                var position = CGFloat(0)

                background.sprites.forEach {
                    $0.position = CGPoint(x: position * $0.size.width, y: $0.size.height / 2)
                    position += 1
                    self.addChild($0)
                }

            }

            func moveGrounds() {
                self.enumerateChildNodes(withName: "background", using: { node, _ in
                    node.position.x -= MOVE_FLOOR_BY
                    if node.position.x < -(self.scene?.size.width)! {
                        node.position.x += (self.scene?.size.width)! * NUMBER_OF_FLOORS
                    }
                })
            }

            // MARK: Monster Score End Condition Functions

            func updateMonster() {
                theMonster.incrementMove()
                monsterMove()
                updateLabel()
                moveToggle()
                checkAndTriggerEndCondition()
            }

            func monsterMove() {
                let monsterXCoord = self.size.width / 2.5 * CGFloat(theMonster.score) * MONSTER_MOVEMENT_RATIO_ADJUSTMENT - theMonster.sprite.size.width / 2
                let monsterYCoord = theMonster.sprite.size.height / 2
                let monsterMovement = SKAction.move(to: CGPoint(x: monsterXCoord, y: monsterYCoord), duration: GameTime.TIME_MONSTER_IS_MOVING)
                theMonster.sprite.run(monsterMovement)
                log.log("Monster Position: \(theMonster.sprite.position)")
            }

            func updateLabel() {
                labelNode.text = "Monster Points: \(theMonster.score) \n Player Points: \(thePlayer.score)"
            }

            func checkAndTriggerEndCondition() {
                if theMonster.score >= GameBalanceConstants.WIN_SCORE_SCALE {
                    gameOver(win: false)
                }
            }

            func moveToggle() {

                let xBarBeginning = self.size.width * BEGINNING_TOGGLE_ADJUSTMENT
                let togglePosition = theSlider.sprite.size.width * CGFloat(theMonster.score) / CGFloat(GameBalanceConstants.WIN_SCORE_SCALE)

                var moveToX = xBarBeginning + togglePosition
                let moveToY = self.size.height * SLIDER_BAR_POSITION_ADJUSTMENT

                if moveToX < xBarBeginning {
                    moveToX = xBarBeginning
                }

                let toggleMove = SKAction.move(to: CGPoint(x: moveToX, y: moveToY), duration: TimeInterval(GameTime.UPDATE_MONSTER_DELAY_TIME_INTERVAL))
                theSlider.toggle.sprite.run(toggleMove)
            }

            func gameOver(win: Bool) {
                run(SKAction.run { self.view?.presentScene(GameOverScene(size: self.size, points: self.thePlayer.score)) })
            }

            func isPlayerBodyA(contact: SKPhysicsContact) -> Bool {
                return contact.bodyA.categoryBitMask == PhysicsUtils.PlayerCategory && contact.bodyB.categoryBitMask == PhysicsUtils.ObstacleCategory
            }

            func isPlayerBodyB(contact: SKPhysicsContact) -> Bool {
                return contact.bodyB.categoryBitMask == PhysicsUtils.PlayerCategory && contact.bodyA.categoryBitMask == PhysicsUtils.ObstacleCategory
            }

            func didBegin(_ contact: SKPhysicsContact) {
                log.log("Contact Between Objects \(contact.bodyA) and \(contact.bodyB) Initiated")

                if isPlayerBodyA(contact: contact) {
                    guard let objectNode = contact.bodyB.node as? SKSpriteNode, let playerNode = contact.bodyA.node as? SKSpriteNode else {
                        log.log("Contact between nonexistant objects detected: player \(contact.bodyA) and object \(contact.bodyB) Initiated")
                        return
                    }
                    objectCollidedWithPlayer(object: objectNode, player: playerNode)

                } else if isPlayerBodyB(contact: contact) {
                    guard let objectNode = contact.bodyA.node as? SKSpriteNode, let playerNode = contact.bodyB.node as? SKSpriteNode else {
                        log.log("Contact between nonexistant objects detected: player \(contact.bodyB) and object \(contact.bodyA) Initiated")
                        return
                    }
                    objectCollidedWithPlayer(object: objectNode, player: playerNode)
                }
            }

             // Removes the object from screen and adjusts player and monster scores
            func objectCollidedWithPlayer(object: SKSpriteNode, player: SKSpriteNode) {
                switch object.name! {

                case ImageNameConstants.BAT_SPRITE_NAME:
                    thePlayer.decreaseScore(points: GameBalanceConstants.MEDIUM_HIT)
                    theMonster.increaseScore(points: GameBalanceConstants.MINOR_HIT)
                    playPlayerHurtSound()
                    object.removeFromParent()
                    log.log("\(ImageNameConstants.BAT_SPRITE_NAME) collided with Player")

                case ImageNameConstants.GHOST_SPRITE_NAME:
                    thePlayer.decreaseScore(points: GameBalanceConstants.MINOR_HIT)
                    log.log("\(ImageNameConstants.GHOST_SPRITE_NAME) collided with Player")
                    playPlayerHurtSound()
                    object.removeFromParent()

                case ImageNameConstants.TRASH_CAN_SPRITE_NAME:
                    thePlayer.increaseScore(points: GameBalanceConstants.MEDIUM_HIT)
                    theMonster.decreaseScore(points: GameBalanceConstants.MEDIUM_HIT)
                    log.log( "\(ImageNameConstants.TRASH_CAN_SPRITE_NAME) collided with Player")

                case ImageNameConstants.OIL_SLICK_SPRITE_NAME:
                    thePlayer.increaseScore(points: GameBalanceConstants.MEDIUM_HIT)
                    theMonster.decreaseScore(points: GameBalanceConstants.MEDIUM_HIT)
                    log.log("\(ImageNameConstants.OIL_SLICK_SPRITE_NAME) collided with Player")

                case ImageNameConstants.SPIDER_SPRITE_NAME:
                    thePlayer.decreaseScore(points: GameBalanceConstants.MEDIUM_HIT)
                    theMonster.increaseScore(points: GameBalanceConstants.MEDIUM_HIT)
                    log.log("\(ImageNameConstants.SPIDER_SPRITE_NAME) collided with Player")
                    playPlayerHurtSound()
                    object.removeFromParent()

                default: log.log("ERROR: Collision Not Supposed to Happen")
                }
            }

            func playPlayerHurtSound() {

                let randomIndex = Int(arc4random_uniform(UInt32(ImageNameConstants.cries.count)))
                run(SKAction.playSoundFileNamed(ImageNameConstants.cries[randomIndex], waitForCompletion: false))

            }

            func playMonsterHurtSound() {
                run(SKAction.playSoundFileNamed("monsterroar.mp3", waitForCompletion: false))
            }

            // MARK: Touch node functions

            override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
                for t in touches {
                    touchDown(atPoint: t.location(in: self))
                    let positionInScene = t.location(in: self)
                    selectNodeForTouch(touchLocation: positionInScene)
                }
            }

            func touchDown(atPoint pos: CGPoint) {
                let message = "User touched down at [\(Int(pos.x)), \(Int(pos.y))]"
                log.log(message)
            }

            func selectNodeForTouch(touchLocation: CGPoint) {

                let touchedNode = self.atPoint(touchLocation)

                if touchedNode is SKSpriteNode {
                    if touchedNode.name == ImageNameConstants.RESET_BUTTON_SPRITE_NAME {
                        if(GameBalanceConstants.debugMode) {
                            run(SKAction.run { self.view?.presentScene(GameOverScene(size: self.size, points: self.thePlayer.score)) })
                        } else {
                            run(SKAction.run { self.view?.presentScene(GameScene(size: self.size)) })
                        }
                        log.log("Reset Button Activated")
                    }

                    if touchedNode.name == ImageNameConstants.PAUSE_BUTTON_SPRITE_NAME {
                        if self.scene?.view?.isPaused ?? false {
                            self.scene?.view?.isPaused = false
                            log.log("Game Unpaused")

                        } else {
                            self.scene?.view?.isPaused = true
                            log.log("Game Paused")
                        }
                    }

                    if touchedNode.name == ImageNameConstants.PLAY_BUTTON_SPRITE_NAME {
                        if GameBalanceConstants.debugMode {
                            GameBalanceConstants.debugMode = false
                            GameBalanceConstants.switchDebugMode(view: self.view!)
                            log.log("DebugMode Turned Off")
                            labelNode.removeFromParent()

                        } else {
                            GameBalanceConstants.debugMode = true
                            GameBalanceConstants.switchDebugMode(view: self.view!)
                            log.log("DebugMode Turned On")
                            enableStatusLabel()

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
                        log.log("Trash Can node distance from Player [\(touchedNode.position.distance(point: (thePlayer.sprite.physicsBody?.node?.position)!))]")
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
                        log.log("Trash Can node distance from Player \(touchedNode.position.distance(point: (thePlayer.sprite.physicsBody?.node?.position)!))]")
                    }
                }
            }

            // Checks how far sprite is from touch and makes sure that the sprite is not behind the player

            func checkPlayerDistance(touchedNode: SKNode) -> Bool {
                guard let playerPosition = thePlayer.sprite.physicsBody?.node?.position else { return false }
                if touchedNode.position.distance(point: playerPosition) < self.size.width * GameBalanceConstants.NODE_IS_CLOSE_ENOUGH_TO_TOUCH_RATIO && touchedNode.position.x >= thePlayer.sprite.position.x {
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
                theMonster.decreaseScore(points: GameBalanceConstants.CRITICAL_HIT)
                node.zRotation = .pi
                log.log("Critical Hit Activated")
            }

            func playJumpSound() {
                if GameTime.isSoundPlayValid() {
                    run(SKAction.playSoundFileNamed("jump.mp3", waitForCompletion: false))
                }
            }

            //Activates Trashcan Sprite and does his effects
            func activateTrashCan(trashSprite: SKNode) {
                guard let sprite = trashSprite as? SKSpriteNode else {
                    log.log("Trash sprite was nil!")
                    return
                }
                AnimationUtils.animateTipTrash(trashSprite: sprite)
                thePlayer.increaseScore(points: GameBalanceConstants.MEDIUM_HIT)
                theMonster.decreaseScore(points: GameBalanceConstants.MEDIUM_HIT)
                run(SKAction.playSoundFileNamed("glassbreak.mp3", waitForCompletion: false))
                playMonsterHurtSound()
                log.log("Player used Trash Can")
            }

            func activateOilSlick(oilSprite: SKNode) {
                thePlayer.increaseScore(points: GameBalanceConstants.MEDIUM_HIT)
                theMonster.decreaseScore(points: GameBalanceConstants.MEDIUM_HIT)
                guard let sprite = oilSprite as? SKSpriteNode else {
                    log.log("Trash sprite was nil!")
                    return
                }
                repeatActions(functionToRepeat: { AnimationUtils.animateOilFire(oilSprite: sprite) }, waitInterval: 0.1)
                run(SKAction.playSoundFileNamed("sizzle.mp3", waitForCompletion: false))
                playMonsterHurtSound()
                log.log("Player used Oil Slick")
            }

            /**************************Player Swipe Functions**************************/

            /* Swipe Distance Function
             *
             *
             */
            @objc func swipedUp(gesture: UISwipeGestureRecognizer) {
                log.log("Player Position: [\(Int((thePlayer.sprite.position.y)))]")
                log.log("Where Player Needs to Be to Jump: [\(Int((self.size.height * PLAYER_START_HEIGHT_ADJUSTMENT)))]")

                if GameTime.isJumpActionValid() == false {
                    return
                }

                let maxJumpHeight = self.size.height - thePlayer.sprite.size.height / 2
                let xValue = self.size.width / 2.5

                let jump = SKAction.move(to: CGPoint(x: self.size.width / 2.5, y: maxJumpHeight), duration: 1.0)
                let fall = SKAction.move(to: CGPoint(x: xValue, y: self.size.height * PLAYER_START_HEIGHT_ADJUSTMENT),
                                         duration: 0.5)

                playJumpSound()
                thePlayer.sprite.run(SKAction.sequence([
                                                               jump,
                                                               fall]
                ))
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
