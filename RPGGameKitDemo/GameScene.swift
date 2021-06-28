//
//  GameScene.swift
//  RPGGameKitDemo
//
//  Created by Amory Rouault on 26/05/2021.
//

import SpriteKit
import RPGGameKit

class GameScene: RPGGameScene {
    
    private let heroCategoryMask: UInt32 = 0x1 << 0
    private let brickCategoryMask: UInt32 = 0x1 << 1
    
    var hero: RPGEntity!
    
    override func didMove(to view: SKView) {
        
        // Create a game demo using RPGGameKit
        self.hero = RPGEntity(color: .red, size: CGSize(width: 16, height: 16))
        self.hero.add(to: self)
        
        // Camera
        let camera = RPGCamera(scene: self)
        self.hero.attach(camera: camera)
        
        // Player movement
        hero.buildPhysics()
        hero.setCategoryMask(categoryMask: self.heroCategoryMask)
        
        let heroGestureDetector = RPGGDEntity(entity: self.hero)
        heroGestureDetector.addUI()
        
        RPGGestureDetectorService.shared.register(heroGestureDetector, withKey: "HeroGestureDetector")
        RPGGestureDetectorService.shared.setDefaultGestureDetector(key: "HeroGestureDetector")
        RPGGestureDetectorService.shared.activateDefault()
        
        // Collision
        guard let bricksTileMap = self.childNode(withName: "Bricks") as? SKTileMapNode else {
            fatalError("No bricks on scene")
        }
        bricksTileMap.createSweetLinePhysicsBody(categoryMask: self.brickCategoryMask)
        
        hero.addCollisionMask(collisionMask: self.brickCategoryMask)
                
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        self.hero.update()
    }
}
