//
//  GameScene.swift
//  memory-rooms
//
//  Created by Maya Lekhi on 2025-01-15.
//

import SpriteKit
import GameplayKit
import AVFoundation

class GameScene: SKScene {
    private var player: Player!
    private var walls: [Wall] = []
    private var objects: [GameObject] = []
    
    private var touchpad: SKShapeNode!
    private var gamepadButton: SKShapeNode!
    private var currentDirection: String? = nil

    private var textField: SKShapeNode!
    private var textLabel: SKLabelNode?
    private var interactionTexts: [String] = []
    private var currentTextIndex: Int = 0
    private var isTextFieldVisible: Bool = false

    private var imageField: SKShapeNode?
    private var imageNodes: [SKSpriteNode] = []
    private var currentImageIndex: Int = 0
    private var isImageFieldVisible: Bool = false

    private var footstepPlayer: AVAudioPlayer?

    override func didMove(to view: SKView) {
        super.didMove(to: view)
        setupAudio()

        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)

        // Add the player
        player = Player()
        addChild(player)

        let customWallColor = UIColor(red: 144/255, green: 133/255, blue: 112/255, alpha: 1.0) // aka #A07A52
        // Add walls
        addWall(color: customWallColor, size: CGSize(width: 520, height: 20), position: CGPoint(x: 0, y: 500)) // North wall
        addWall(color: customWallColor, size: CGSize(width: 20, height: 825), position: CGPoint(x: -250, y: 90)) // West wall
        addWall(color: customWallColor, size: CGSize(width: 520, height: 20), position: CGPoint(x: 0, y: -325)) // South wall
        addWall(color: customWallColor, size: CGSize(width: 20, height: 825), position: CGPoint(x: 250, y: 90)) // East wall

        // add objects here
//        addStaticObject(image: "touchpad_design", size: CGSize(width: 50, height: 50), position: CGPoint(x: -50, y: 200))
        
        addInteractiveObject(image: "bed", size: CGSize(width: 200, height: 220), position: CGPoint(x: 140, y: 380), interactionText: "hi! this is a bed")
        
        let additionalImages: [UIImage] = [
            UIImage(named: "plant-1")!,
            UIImage(named: "plant-2")!,
            UIImage(named: "plant-3")!
        ]
        addInteractiveObject(image: "plant", size: CGSize(width: 100, height: 100), position: CGPoint(x: -150, y: 100), interactionText: "i love our plant garden together <3", additionalImages: additionalImages)

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
        // Load the object image
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
    
    private func setupAudio() {
        if let footstepURL = Bundle.main.url(forResource: "footstep", withExtension: "wav") {
            do {
                footstepPlayer = try AVAudioPlayer(contentsOf: footstepURL)
                footstepPlayer?.numberOfLoops = -1 // Loop indefinitely
                footstepPlayer?.volume = 0.5 // Adjust volume as needed
                footstepPlayer?.rate = 1.5 // Speeds up playback by 50%
                footstepPlayer?.prepareToPlay()
            } catch {
                print("Could not create audio player: \(error)")
            }
        }
    }
    
    private func showTextField(textInput: String) {
        // replace with custom image eventually
        interactionTexts = textInput.components(separatedBy: ". ").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
        currentTextIndex = 0

        let textFieldSize = CGSize(width: 500, height: 100)
        textField = SKShapeNode(rectOf: textFieldSize)
        textField?.lineJoin = .miter
        textField?.position = CGPoint(x: frame.midX, y: -400)
        textField?.fillColor = .white
        textField?.strokeColor = .gray
        textField?.lineWidth = 10
        textField?.alpha = 0.8
        textField?.isUserInteractionEnabled = false

        // Create and set up the label
        textLabel = SKLabelNode(text: interactionTexts[currentTextIndex])
        textLabel?.fontName = "VT323"
        textLabel?.fontSize = 32
        textLabel?.fontColor = .gray
        textLabel?.position = CGPoint(x: 0, y: 0)
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
            hideImageField()
        }
    }

    private func hideTextField() {
        textField?.removeFromParent()
        textLabel?.removeFromParent()
        isTextFieldVisible = false
    }
    
    private func showImages(images: [UIImage]) {
        // Initialize the image field if not already created
        let imageFieldSize = CGSize(width: 600, height: 800)
        imageField = SKShapeNode(rectOf: imageFieldSize)
        imageField?.position = CGPoint(x: frame.midX, y: 100)
        imageField?.fillColor = .clear
        imageField?.strokeColor = .clear
        imageField?.isUserInteractionEnabled = false

        if let imageField = imageField {
            addChild(imageField)
        }

        isImageFieldVisible = true
        currentImageIndex = 0 // Reset to the start of the array
        displayImageSet(images: images)
    }
    private func displayImageSet(images: [UIImage]) {
        for node in imageNodes {
            node.removeFromParent()
        }
        imageNodes.removeAll()

        // fixed positions
        let placements: [[(position: CGPoint, size: CGSize, rotation: CGFloat)]] = [
            [(CGPoint(x: 0, y: 0), CGSize(width: 300, height: 400), -.pi / 24)], // 1 image
            [
                (CGPoint(x: 100, y: 200), CGSize(width: 250, height: 350), .pi / 12),
                (CGPoint(x: -100, y: -200), CGSize(width: 250, height: 350), -.pi / 12)
            ], // 2 images
            [
                (CGPoint(x: -100, y: 260), CGSize(width: 250, height: 350), -.pi / 8),
                (CGPoint(x: 150, y: -50), CGSize(width: 250, height: 350), .pi / 12),
                (CGPoint(x: -150, y: -250), CGSize(width: 250, height: 350), -.pi / 12),
            ] // 3 images
        ]

        let numImages = min(images.count, 3)
        let layout = placements[numImages - 1]

        for (index, image) in images.enumerated() {
            guard index < layout.count else { break }

            let (position, size, rotation) = layout[index]
            let texture = SKTexture(image: image)
            let spriteNode = SKSpriteNode(texture: texture)

            spriteNode.position = position
            spriteNode.size = size
            spriteNode.zRotation = rotation
            spriteNode.zPosition = 10

            let frameTexture = SKTexture(imageNamed: "polaroid_frame")
            let frameNode = SKSpriteNode(texture: frameTexture)
            frameNode.position = position
            frameNode.size = CGSize(width: size.width + 20, height: size.height + 20)
            frameNode.zRotation = rotation
            frameNode.zPosition = 9
            
            imageField?.addChild(frameNode)
            imageField?.addChild(spriteNode)
            
            imageNodes.append(spriteNode)
        }
    }

    private func hideImageField() {
        imageField?.removeFromParent()
        imageNodes.removeAll()
        isImageFieldVisible = false
    }


    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            
            if touchpad.contains(location) {
                handleWalk(location: location)
                
            }
            if gamepadButton.contains(location) {
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
        footstepPlayer?.stop()
    }
    
    private func handleWalk(location: CGPoint) {
        let touchpadDx = location.x - touchpad.position.x
        let touchpadDy = location.y - touchpad.position.y
        
        let absDx = abs(touchpadDx)
        let absDy = abs(touchpadDy)
        
        var direction: String
        if absDx > absDy {
            direction = touchpadDx > 0 ? "Right" : "Left"
        } else {
            direction = touchpadDy > 0 ? "Up" : "Down"
        }
        
        if currentDirection != direction {
            currentDirection = direction
            player.startWalking(direction: direction)
            footstepPlayer?.play() // Start playing footstep sound
        }
    }
    
    private func handlePress(location: CGPoint) {
        // gamepad interaction button location handling
        let buttonDx = location.x - gamepadButton.position.x
        let buttonDy = location.y - gamepadButton.position.y

        let absDx = abs(buttonDx)
        let absDy = abs(buttonDy)

        if absDx <= gamepadButton.frame.width / 2 && absDy <= gamepadButton.frame.height / 2 {
            
            let facingDirection = player.getFacingDirection()
            
            if isTextFieldVisible {
                updateTextField()
            } else if let interactiveObject = findInteractiveObject(direction: facingDirection) {
                showTextField(textInput: interactiveObject.interactionText)

                if let images = interactiveObject.additionalImages, !images.isEmpty {
                    showImages(images: images)
                }
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
