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
    
    private let heroCategoryMask: UInt32 = 0x1 << 0
    private let environmentCategoryMask: UInt32 = 0x1 << 1
    
    override func didMove(to view: SKView) {
        
        // Hero
        self.hero = RPGEntity(textureName: "Hero")
        self.hero.position.x = 16
        self.hero.buildPhysics()
        self.hero.setCategoryMask(categoryMask: self.heroCategoryMask)
        self.hero.add(to: self)
        
        // Hero behavior
        let movementTexturesBehavior = RPGMovementTexturesBehavior(key: "HeroMovementTextures", textures: [
            SKTexture(imageNamed: "HeroFront"),
            SKTexture(imageNamed: "HeroFront"),
            SKTexture(imageNamed: "HeroFront"),
            SKTexture(imageNamed: "HeroFront")
        ])
        self.hero.register(behavior: movementTexturesBehavior)
        
        // Camera
        let camera = RPGCamera(scene: self)
        self.hero.attach(camera: camera)
        
        // Movement
        let heroGestureDetector = RPGGDEntity(entity: self.hero)
        heroGestureDetector.addUI()
        RPGGestureDetectorService.shared.register(heroGestureDetector, withKey: "HeroGestureDetector")
        RPGGestureDetectorService.shared.activateGestureDetector(withKey: "HeroGestureDetector")
        
        // Collisions
        self.hero.addCollisionMask(collisionMask: self.environmentCategoryMask)
        self.buildEnvironment()
    }
    
    private func buildEnvironment() {
    
        // Trees
        guard let trees = self.childNode(withName: "Trees") as? SKTileMapNode else {
            fatalError("No trees in the village")
        }
        trees.createSweetLinePhysicsBody(categoryMask: self.environmentCategoryMask)
        
        // Decoration
        guard let decoration = self.childNode(withName: "Decoration") as? SKTileMapNode else {
            fatalError("No decoration in the village")
        }
        decoration.createSweetLinePhysicsBody(categoryMask: self.environmentCategoryMask)
        
        // House
        guard let house = self.childNode(withName: "House"),
              let walls = house.childNode(withName: "Walls") as? SKTileMapNode else {
            fatalError("No house in the village or poorly build")
        }
        walls.createSweetLinePhysicsBody(categoryMask: self.environmentCategoryMask)
    
    }
    
    override func update(_ currentTime: TimeInterval) {
        self.hero.update()
    }
    
}
