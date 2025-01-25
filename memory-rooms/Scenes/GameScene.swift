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
    private var gamepadButton: SKShapeNode!
    private var currentDirection: String? = nil
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)

        // Add the player
        player = Player()
        addChild(player)

        // Add walls
        addWall(color: .black, size: CGSize(width: 400, height: 20), position: CGPoint(x: 0, y: 400)) // North wall
        addWall(color: .black, size: CGSize(width: 20, height: 800), position: CGPoint(x: -200, y: 0)) // West wall
        addWall(color: .black, size: CGSize(width: 400, height: 20), position: CGPoint(x: 0, y: -400)) // South wall
        addWall(color: .black, size: CGSize(width: 20, height: 800), position: CGPoint(x: 200, y: 0)) // East wall

        // add objects here
        addStaticObject(image: "touchpad_design", size: CGSize(width: 50, height: 50), position: CGPoint(x: -50, y: 200))
        addStaticObject(image: "touchpad_design", size: CGSize(width: 30, height: 30), position: CGPoint(x: 50, y: -50))
        addInteractiveObject(image: "touchpad_design", size: CGSize(width: 30, height: 30), position: CGPoint(x: 50, y: -50), interactionText: "hi! something romantic here")

        createGamepad()
    }

    private func addWall(color: UIColor, size: CGSize, position: CGPoint) {
        let wall = Wall(color: color, size: size, position: position)
        walls.append(wall)
        addChild(wall)
    }

    private func addStaticObject(image: String, size: CGSize, position: CGPoint) {
        guard let objectImage = UIImage(named: image) else {
            print("Error: Image \(image) not found!")
            return
        }
        if let objectImage = UIImage(named: image) {
            let gameObject = GameObject(image: objectImage, size: size, position: position)
            objects.append(gameObject)
            addChild(gameObject)
        }
    }
    
    private func addInteractiveObject(image: String, size: CGSize, position: CGPoint, interactionText: String, additionalImages: [UIImage]? = nil) {
        // Load the main image
        guard let objectImage = UIImage(named: image) else {
            print("Error: Image \(image) not found!")
            return
        }

        let gameObject = InteractiveObject(image: objectImage, size: size, position: position, interactionText: interactionText, additionalImages: additionalImages)
        objects.append(gameObject)
        addChild(gameObject)
    }

    private func createGamepad() {
        // base of touchpad
        let touchpadSize = CGSize(width: 100, height: 100)
        touchpad = SKShapeNode(rectOf: touchpadSize, cornerRadius: 10)
        touchpad.position = CGPoint(x: -size.width / 4, y: -500)
        touchpad.fillColor = .clear
        touchpad.strokeColor = .clear
        touchpad.lineWidth = 2
        touchpad.alpha = 0.8
        touchpad.isUserInteractionEnabled = false
        
        let touchpadDesign = SKSpriteNode(imageNamed: "touchpad_design")
        touchpadDesign.size = touchpadSize
        
        touchpad.addChild(touchpadDesign)
        
        addChild(touchpad)
        
        
        // interaction button
        let buttonSize = CGSize(width: 50, height: 50)
        gamepadButton = SKShapeNode(rectOf: buttonSize, cornerRadius: 10)
        gamepadButton.position = CGPoint(x: size.width / 4, y: -500)
        gamepadButton.fillColor = .clear
        gamepadButton.strokeColor = .clear
        gamepadButton.lineWidth = 2
        gamepadButton.alpha = 0.8
        gamepadButton.isUserInteractionEnabled = false
        
        let buttonDesign = SKSpriteNode(imageNamed: "gamepad_button")
        buttonDesign.size = buttonSize
        
        gamepadButton.addChild(buttonDesign)
        
        addChild(gamepadButton)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("TOUCHES RECIEVED")
        if let touch = touches.first {
            let location = touch.location(in: self)
            
            if touchpad.contains(location) {
//                print("TOUCH HANDLING ON TOUCHPAD")
                handleWalk(location: location)
                
            }
            if gamepadButton.contains(location) {
//                print("TOUCH HANDLING ON TOUCHPAD")
                handlePress(location: location)
                
            }

        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            
            if touchpad.contains(location) {
                handleWalk(location: location)
            } else {
                currentDirection = nil
                player.stopWalking()
            }
            
            if gamepadButton.contains(location) {
                handlePress(location: location)
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        currentDirection = nil
        player.stopWalking()
    }
    
    private func handleWalk(location: CGPoint) {
        // touchpad location handling
        let touchpadDx = location.x - touchpad.position.x
        let touchpadDy = location.y - touchpad.position.y

        let absDx = abs(touchpadDx)
        let absDy = abs(touchpadDy)

        // Determine cardinal direction
        var direction: String
        if absDx > absDy {
            direction = touchpadDx > 0 ? "Right" : "Left"
        } else {
            direction = touchpadDy > 0 ? "Up" : "Down"
        }
        
        print("\(direction)")

        if currentDirection != direction {
            currentDirection = direction
            player.startWalking(direction: direction)
        }
    }
    
    private func handlePress(location: CGPoint) {
        // gamepad interaction button location handling
        let buttonDx = location.x - gamepadButton.position.x
        let buttonDy = location.y - gamepadButton.position.y
        
        let absDx = abs(buttonDx)
        let absDy = abs(buttonDy)

        
        if absDx <= gamepadButton.frame.width / 2 && absDy <= gamepadButton.frame.height / 2 {
            print("Interaction button clicked")
            
            // Check for InteractiveObject in the direction the player is facing
            let facingDirection = player.getFacingDirection()
            print("direction: \(facingDirection)")
        }

    }

}
