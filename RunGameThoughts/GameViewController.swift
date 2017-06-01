//
//  GameViewController.swift
//  RunGameThoughts
//
//  Created by Ione Axelrod on 4/19/17.
//  Copyright © 2017 Ione Axelrod. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mainScene = TitleScreenScene(size: view.bounds.size)
        //let mainScene = GameScene(size: view.bounds.size)

        let skView = view as! SKView
        
        skView.ignoresSiblingOrder = true
        
        mainScene.scaleMode = .resizeFill
        skView.presentScene(mainScene)
        
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}


