//
//  PlayerNode.swift
//  memory-rooms
//
//  Created by Maya Lekhi on 2025-01-17.
//

import SpriteKit

class Player: SKSpriteNode {
    private var walkFrames: [SKTexture] = []
    private var currentDirection: String = "Idle"

    init() {
        let texture = SKTexture(imageNamed: "character_idle")
        super.init(texture: texture, color: .clear, size: texture.size())

        loadWalkTextures(direction: "Fwd")
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func loadWalkTextures(direction: String) {
        let atlasName: String
        if direction == "Up" {
            atlasName = "PlayerWalkUp"
        } else if direction == "Down" {
            atlasName = "PlayerWalkDown"
        } else if direction == "Left" {
            atlasName = "PlayerWalkLeft"
        } else {
            // assume right
            atlasName = "PlayerWalkRight"
        }
        
        let walkAtlas = SKTextureAtlas(named: atlasName)
        print("walkAtlas: \(walkAtlas)")
        walkFrames = walkAtlas.textureNames
            .sorted()
            .map { walkAtlas.textureNamed($0) }
        print("Loaded frames: \(walkFrames.map { $0.description })")
    }

    func startWalking(direction: String) {
        print("STARTED WALKING")

        if currentDirection != direction {
            currentDirection = direction
            loadWalkTextures(direction: direction)
        }
        
        self.removeAction(forKey: "walking")
        guard !walkFrames.isEmpty else { return }

        let walkAction = SKAction.animate(with: walkFrames, timePerFrame: 0.1, resize: false, restore: true)
        let repeatAction = SKAction.repeatForever(walkAction)
        
        self.run(repeatAction, withKey: "walking")
        
        print("calling movetoward")
        moveToward(direction: direction)
    }

    func stopWalking() {
        print("STOPPED WALKING")
        self.removeAction(forKey: "walking")
        self.removeAction(forKey: "moving")
        self.texture = SKTexture(imageNamed: "character_idle")
    }

    func moveToward(direction: String/*, walls: [SKSpriteNode], objects: [GameObject]*/) {
        print("move toward started with \(direction)")
        
        let moveAction: SKAction
        
        if direction == "Up" {
            moveAction = SKAction.move(by: CGVector(dx: 0, dy: 50), duration: 0.5)
        } else if direction == "Down" {
            moveAction = SKAction.move(by: CGVector(dx: 0, dy: -50), duration: 0.5)
        } else if direction == "Left" {
            moveAction = SKAction.move(by: CGVector(dx: -50, dy: 0), duration: 0.5)
        } else {
            moveAction = SKAction.move(by: CGVector(dx: 50, dy: 0), duration: 0.5)
        }
        
        let repeatMoveAction = SKAction.repeatForever(moveAction)
        
        // Start the movement action
        self.run(repeatMoveAction, withKey: "moving")
    }

//    func isMoveValid(to position: CGPoint, walls: [SKSpriteNode], objects: [GameObject]) -> Bool {
//        let futureFrame = CGRect(
//            x: position.x - self.size.width / 2,
//            y: position.y - self.size.height / 2,
//            width: self.size.width,
//            height: self.size.height
//        )
//
//        // Check collision with walls
//        for wall in walls {
//            if wall.frame.intersects(futureFrame) {
//                return false
//            }
//        }
//
//        // Check collision with objects
//        for object in objects {
//            if object.frame.intersects(futureFrame) {
//                return false
//            }
//        }
//
//        return true
//    }
}
