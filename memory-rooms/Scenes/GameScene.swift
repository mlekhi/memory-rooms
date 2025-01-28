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
    private var textField: SKShapeNode!
    private var textLabel: SKLabelNode?
    
    private var currentDirection: String? = nil
    private var interactionTexts: [String] = []
    private var currentTextIndex: Int = 0
    private var isTextFieldVisible: Bool = false
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)

        // Add the player
        player = Player()
        addChild(player)

        let customWallColor = UIColor(red: 144/255, green: 133/255, blue: 112/255, alpha: 1.0) // aka #A07A52
        // Add walls
<<<<<<< Updated upstream
        addWall(color: .black, size: CGSize(width: 420, height: 20), position: CGPoint(x: 0, y: 500)) // North wall
        addWall(color: .black, size: CGSize(width: 20, height: 800), position: CGPoint(x: -200, y: 100)) // West wall
        addWall(color: .black, size: CGSize(width: 420, height: 20), position: CGPoint(x: 0, y: -300)) // South wall
        addWall(color: .black, size: CGSize(width: 20, height: 800), position: CGPoint(x: 200, y: 100)) // East wall
=======
        addWall(color: customWallColor, size: CGSize(width: 520, height: 20), position: CGPoint(x: 0, y: 500)) // North wall
        addWall(color: customWallColor, size: CGSize(width: 20, height: 825), position: CGPoint(x: -250, y: 90)) // West wall
        addWall(color: customWallColor, size: CGSize(width: 520, height: 20), position: CGPoint(x: 0, y: -325)) // South wall
        addWall(color: customWallColor, size: CGSize(width: 20, height: 825), position: CGPoint(x: 250, y: 90)) // East wall
>>>>>>> Stashed changes

        // add objects here
        addStaticObject(image: "touchpad_design", size: CGSize(width: 50, height: 50), position: CGPoint(x: -50, y: 200))
        addStaticObject(image: "touchpad_design", size: CGSize(width: 30, height: 30), position: CGPoint(x: 50, y: -50))
<<<<<<< Updated upstream
        addInteractiveObject(image: "touchpad_design", size: CGSize(width: 30, height: 30), position: CGPoint(x: 50, y: -50), interactionText: "hi! something romantic here")
=======
        addInteractiveObject(image: "touchpad_design", size: CGSize(width: 50, height: 50), position: CGPoint(x: 100, y: -50), interactionText: "hi! something romantic here")
        
        
        let additionalImages: [UIImage] = [
            UIImage(named: "touchpad_design")!,
            UIImage(named: "touchpad_design")!,
            UIImage(named: "touchpad_design")!
        ]
        addInteractiveObject(image: "touchpad_design", size: CGSize(width: 50, height: 50), position: CGPoint(x: 100, y: 100), interactionText: "this one has images", additionalImages: additionalImages)
>>>>>>> Stashed changes

        createGamepad()
    }

    private func addWall(color: UIColor, size: CGSize, position: CGPoint) {
        let wall = Wall(color: color, size: size, position: position)
        walls.append(wall)
        addChild(wall)
    }

    private func addStaticObject(image: String, size: CGSize, position: CGPoint) {
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
        touchpad.position = CGPoint(x: -size.width / 4, y: -550)
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
        gamepadButton.position = CGPoint(x: size.width / 4, y: -550)
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
    
    private func showTextField(textInput: String) {
        // replace with custom image eventuallyt
        interactionTexts = textInput.components(separatedBy: ". ").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
        currentTextIndex = 0

        let textFieldSize = CGSize(width: 500, height: 100)
        textField = SKShapeNode(rectOf: textFieldSize, cornerRadius: 5)
        textField?.position = CGPoint(x: frame.midX, y: -400)
        textField?.fillColor = .white
        textField?.strokeColor = .gray
        textField?.lineWidth = 2
        textField?.alpha = 0.8
        textField?.isUserInteractionEnabled = false

        // Create and set up the label
        textLabel = SKLabelNode(text: interactionTexts[currentTextIndex])
        textLabel?.fontName = "Helvetica"
        textLabel?.fontSize = 24
        textLabel?.fontColor = .black
        textLabel?.position = CGPoint(x: 0, y: -12)
        textLabel?.horizontalAlignmentMode = .center
        textLabel?.verticalAlignmentMode = .center

        if let textField = textField, let textLabel = textLabel {
            textField.addChild(textLabel)
            addChild(textField)
            isTextFieldVisible = true
        }
    }

    private func updateTextField() {
        currentTextIndex += 1
        if currentTextIndex < interactionTexts.count {
            textLabel?.text = interactionTexts[currentTextIndex]
        } else {
            hideTextField()
        }
    }

    private func hideTextField() {
        textField?.removeFromParent()
        textLabel?.removeFromParent()
        isTextFieldVisible = false
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
            
            let facingDirection = player.getFacingDirection()
            print("direction: \(facingDirection)")
            
            if isTextFieldVisible {
                updateTextField()
            } else if let interactiveObject = findInteractiveObject(direction: facingDirection) {
                showTextField(textInput: interactiveObject.interactionText)
<<<<<<< Updated upstream
                print("Interaction: \(interactiveObject.interactionText)")
=======

                if let images = interactiveObject.additionalImages, !images.isEmpty {
                    showImages(images: images)
                }
>>>>>>> Stashed changes
            } else {
                print("No interactive object ahead")
            }
        }
    }
    
    private func findInteractiveObject(direction: String) -> InteractiveObject? {
        let interactionRange: CGFloat = 25.0 // ADJUSTTTTT
        
        var futureFrame = player.frame
        switch direction {
        case "Up":
            futureFrame.origin.y += interactionRange
        case "Down":
            futureFrame.origin.y -= interactionRange
        case "Left":
            futureFrame.origin.x -= interactionRange
        case "Right":
            futureFrame.origin.x += interactionRange
        default:
            break
        }

        for node in children {
            if let interactiveObject = node as? InteractiveObject {
                if futureFrame.intersects(interactiveObject.frame) {
                    return interactiveObject
                }
            }
        }

        return nil
    }


}
