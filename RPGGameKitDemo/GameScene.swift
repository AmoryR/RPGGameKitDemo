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
    private let npcCategoryMask: UInt32 = 0x1 << 1
    private let npcContactCategoryMask: UInt32 = 0x1 << 2
    private let brickCategoryMask: UInt32 = 0x1 << 3
    
    var hero: RPGEntity!
    
    override func didMove(to view: SKView) {
        
        // Create a game demo using RPGGameKit
        self.hero = RPGEntity(textureName: "Front")
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
        
        // Collisions
        self.addCollisionToTilemap(named: "Bricks", withCategoryMask: self.brickCategoryMask)
        hero.addCollisionMask(collisionMask: self.brickCategoryMask)
        
        // NPC
        guard let npc = self.childNode(withName: "NPC") as? RPGEntity else {
            fatalError("No npc on scene")
        }
        npc.createFeedback(textureName: "Feedback")
        npc.setCategoryMask(categoryMask: self.npcCategoryMask)
        npc.addContactArea(categoryMask: self.npcContactCategoryMask)
        
        hero.addCollisionMask(collisionMask: self.npcCategoryMask)
        hero.addContactTest(contactMask: self.npcContactCategoryMask)
        
        let contactAreaHandler = RPGCHContactArea(entityCategoryMask: self.heroCategoryMask, contactAreaCategoryMask: self.npcContactCategoryMask)
        contactAreaHandler.feedbackBody = .B
        self.register(collisionHandler: contactAreaHandler, withKey: "ContactHandler")
        
        // UI
        RPGUIService.shared.enableUI(on: self)
        
        let hud = RPGHUD(size: CGSize(width: 100, height: 20), anchor: .topCenter)
        hud.show()
                
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        self.hero.update()
    }
}
