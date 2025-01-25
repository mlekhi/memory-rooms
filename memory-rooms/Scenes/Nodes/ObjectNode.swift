//
//  ObjectNode.swift
//  memory-rooms
//
//  Created by Maya Lekhi on 2025-01-17.
//

import SpriteKit

class GameObject: SKSpriteNode {
    var interactionText: String? // should this stay optional??

    init(image: UIImage, size: CGSize, position: CGPoint, interactionText: String? = nil) {
        let texture = SKTexture(image: image)
        super.init(texture: texture, color: .clear, size: size)
        self.position = position
        
        self.interactionText = interactionText

        self.physicsBody = SKPhysicsBody(rectangleOf: size)
        self.physicsBody?.isDynamic = false
        self.physicsBody?.categoryBitMask = 0b0001 // Unique category
        self.physicsBody?.collisionBitMask = 0b0010 // Collides with category 0b0010
        self.physicsBody?.contactTestBitMask = 0b0010 // Detects contact with category 0b0010
        self.physicsBody?.restitution = 0.0
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let interactionText = interactionText {
            print("interaction: \(interactionText)")
        } else {
            print("TOUCHEDDDDD")
        }
    }
}
