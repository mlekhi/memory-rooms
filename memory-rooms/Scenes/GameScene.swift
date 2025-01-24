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
    
    private var touchpad: SKShapeNode!
    private var currentDirection: String? = nil
    
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

//        // Add objects
//        addObject(color: .green, size: CGSize(width: 50, height: 50), position: CGPoint(x: -50, y: 50))
//        addObject(color: .yellow, size: CGSize(width: 30, height: 30), position: CGPoint(x: 50, y: -50))
        
        createTouchpad()
    }

    private func addWall(color: UIColor, size: CGSize, position: CGPoint) {
        let wall = Wall(color: color, size: size, position: position)
        walls.append(wall)
        addChild(wall)
    }

//    private func addObject(color: UIColor, size: CGSize, position: CGPoint) {
//        let object = GameObject(color: color, size: size, position: position)
//        objects.append(object)
//        addChild(object)
//    }
    
    private func createTouchpad() {
        let touchpadSize = CGSize(width: 150, height: 150)
        touchpad = SKShapeNode(rectOf: touchpadSize, cornerRadius: 10)
        touchpad.position = CGPoint(x: size.width / 4, y: size.height / 4)
        touchpad.fillColor = .gray
        touchpad.alpha = 0.5
        touchpad.isUserInteractionEnabled = false
        
        addChild(touchpad)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("TOUCHES RECIEVED")
        if let touch = touches.first {
            let location = touch.location(in: self)
            
            if touchpad.contains(location) {
                print("TOUCH HANDLING ON TOUCHPAD")
                handleTouch(location: location)
                
            }
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            
            if touchpad.contains(location) {
                handleTouch(location: location)
            } else {
                currentDirection = nil
                player.stopWalking()
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        currentDirection = nil
        player.stopWalking()
    }
    
    private func handleTouch(location: CGPoint) {
        
        let dx = location.x - touchpad.position.x
        let dy = location.y - touchpad.position.y

        let absDx = abs(dx)
        let absDy = abs(dy)

        // Determine cardinal direction
        var direction: String
        if absDx > absDy {
            direction = dx > 0 ? "Right" : "Left"
        } else {
            direction = dy > 0 ? "Up" : "Down"
        }
        
        print("\(direction)")

        // Avoid redundant movement updates
        if currentDirection != direction {
            currentDirection = direction
            player.startWalking(direction: direction)
        }
    }

}
