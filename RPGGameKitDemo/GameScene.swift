//
//  GameScene.swift
//  RPGGameKitDemo
//
//  Created by Amory Rouault on 26/05/2021.
//

import SpriteKit
import RPGGameKit

class GameScene: RPGGameScene {
    
    var hero: RPGEntity!
    
    override func didMove(to view: SKView) {
        
        // Create a game demo using RPGGameKit
        self.hero = RPGEntity(color: .red, size: CGSize(width: 32, height: 32))
        self.hero.add(to: self)
        
        // Camera
        let camera = RPGCamera(scene: self)
        self.hero.attach(camera: camera)
        
        // Player movement
        hero.buildPhysics()
        
        let heroGestureDetector = RPGGDEntity(entity: self.hero)
        heroGestureDetector.addUI()
        
        RPGGestureDetectorService.shared.register(heroGestureDetector, withKey: "HeroGestureDetector")
        RPGGestureDetectorService.shared.setDefaultGestureDetector(key: "HeroGestureDetector")
        RPGGestureDetectorService.shared.activateDefault()
                
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        self.hero.update()
    }
}
