//
//  GameScene.swift
//  RPGGameKitDemo
//
//  Created by Amory Rouault on 26/05/2021.
//

import SpriteKit
import RPGGameKit

class GameScene: RPGGameScene {
    
    override func didMove(to view: SKView) {
        
        // Create a game demo using RPGGameKit
        let hero = RPGEntity(color: .red, size: CGSize(width: 10, height: 10))
        hero.add(to: self)
                
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
