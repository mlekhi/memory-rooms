//
//  GameScene.swift
//  memory-rooms
//
//  Created by Maya Lekhi on 2025-01-15.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    private var player: Player!
    private var walls: [Wall] = []
    private var objects: [GameObject] = []

    override func didMove(to view: SKView) {
        super.didMove(to: view)

        // Add the player
        player = Player()
        addChild(player)

        // Add walls
        addWall(color: .black, size: CGSize(width: 400, height: 20), position: CGPoint(x: 0, y: 400)) // North wall
        addWall(color: .black, size: CGSize(width: 20, height: 800), position: CGPoint(x: -200, y: 0)) // West wall
        addWall(color: .black, size: CGSize(width: 400, height: 20), position: CGPoint(x: 0, y: -400)) // South wall
        addWall(color: .black, size: CGSize(width: 20, height: 800), position: CGPoint(x: 200, y: 0)) // East wall

        // Add objects
        addObject(color: .green, size: CGSize(width: 50, height: 50), position: CGPoint(x: -50, y: 50))
        addObject(color: .yellow, size: CGSize(width: 30, height: 30), position: CGPoint(x: 50, y: -50))
    }

    private func addWall(color: UIColor, size: CGSize, position: CGPoint) {
        let wall = Wall(color: color, size: size, position: position)
        walls.append(wall)
        addChild(wall)
    }

    private func addObject(color: UIColor, size: CGSize, position: CGPoint) {
        let object = GameObject(color: color, size: size, position: position)
        objects.append(object)
        addChild(object)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            player.moveToward(touch.location(in: self), walls: walls)
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            player.moveToward(touch.location(in: self), walls: walls)
        }
    }
}
