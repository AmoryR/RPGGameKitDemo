//
//  GameViewController.swift
//  RPGGameKitDemo
//
//  Created by Amory Rouault on 26/05/2021.
//

import UIKit
import RPGGameKit
//import SpriteKit
//import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        RPGSceneLoader.shared.set(mainViewController: self)
        RPGSceneLoader.shared.presentScene(named: "GameScene")
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
