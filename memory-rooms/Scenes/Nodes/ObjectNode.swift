//
//  ObjectNode.swift
//  memory-rooms
//
//  Created by Maya Lekhi on 2025-01-17.
//

import SpriteKit

class GameObject: SKSpriteNode {

    init(image: UIImage, size: CGSize, position: CGPoint) {
        let texture = SKTexture(image: image)
        super.init(texture: texture, color: .clear, size: size)
        self.position = position
        
        self.physicsBody = SKPhysicsBody(rectangleOf: size)
        self.physicsBody?.isDynamic = false
        self.physicsBody?.categoryBitMask = 2 // match the player class
        self.physicsBody?.collisionBitMask = 1 // match the player class
        self.physicsBody?.contactTestBitMask = 1 
        self.physicsBody?.restitution = 0.0
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class InteractiveObject: GameObject {
    var interactionText: String
    var additionalImages: [UIImage]? // optional

    init(image: UIImage, size: CGSize, position: CGPoint, interactionText: String, additionalImages: [UIImage]? = nil) {
        self.interactionText = interactionText
        self.additionalImages = additionalImages
        super.init(image: image, size: size, position: position)

        // Enable user interaction for this node
        self.isUserInteractionEnabled = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Print the interaction text when touched
        print("Interaction: \(interactionText)")

        // Handle additional images (example logic)
        if let images = additionalImages, !images.isEmpty {
            print("This object has additional images: \(images.count)")
            // You can add custom logic to display or process the additional images
        }
    }
}
