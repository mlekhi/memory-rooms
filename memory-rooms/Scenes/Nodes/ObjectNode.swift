//
//  ObjectNode.swift
//  memory-rooms
//
//  Created by Maya Lekhi on 2025-01-17.
//

import SpriteKit

class GameObject: SKSpriteNode {
    init(color: UIColor, size: CGSize, position: CGPoint) {
        super.init(texture: nil, color: color, size: size)
        self.position = position
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
