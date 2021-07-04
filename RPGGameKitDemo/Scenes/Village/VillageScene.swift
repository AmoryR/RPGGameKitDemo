//
//  VillageScene.swift
//  RPGGameKitDemo
//
//  Created by Amory Rouault on 03/07/2021.
//

import SpriteKit
import RPGGameKit

class VillageScene: RPGGameScene {
    
    private var hero: RPGEntity!
    
    override func didMove(to view: SKView) {
        
        // Hero
        self.hero = RPGEntity(textureName: "Hero")
        self.hero.position.x = 16
        self.hero.buildPhysics()
        self.hero.add(to: self)
        
        // Camera
        let camera = RPGCamera(scene: self)
        self.hero.attach(camera: camera)
        
        // Movement
        let heroGestureDetector = RPGGDEntity(entity: self.hero)
        heroGestureDetector.addUI()
        RPGGestureDetectorService.shared.register(heroGestureDetector, withKey: "HeroGestureDetector")
        RPGGestureDetectorService.shared.activateGestureDetector(withKey: "HeroGestureDetector")
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        self.hero.update()
    }
    
}
