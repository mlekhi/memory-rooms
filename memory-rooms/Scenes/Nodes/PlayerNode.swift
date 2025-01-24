//
//  PlayerNode.swift
//  memory-rooms
//
//  Created by Maya Lekhi on 2025-01-17.
//

import SpriteKit

class Player: SKSpriteNode {
    private var walkFrames: [SKTexture] = []

    init() {
        let texture = SKTexture(imageNamed: "character_idle")
        super.init(texture: texture, color: .clear, size: texture.size())

        loadWalkTextures()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func loadWalkTextures() {
        let walkAtlas = SKTextureAtlas(named: "PlayerWalk")
        walkFrames = walkAtlas.textureNames
            .sorted()
            .map { walkAtlas.textureNamed($0) }
    }

    func startWalking() {
        self.removeAction(forKey: "walking")
        guard !walkFrames.isEmpty else {
            return
        }
        let walkAction = SKAction.animate(with: walkFrames, timePerFrame: 0.1, resize: false, restore: true)
        let repeatAction = SKAction.repeatForever(walkAction)
        self.run(repeatAction, withKey: "walking")
    }

    func stopWalking() {
        print("STOPPED WALKING")
        self.removeAction(forKey: "walking")
        self.texture = SKTexture(imageNamed: "character_idle")
    }

    func moveToward(_ targetPosition: CGPoint, walls: [SKSpriteNode], speed: CGFloat = 300.0, stepSize: CGFloat = 5.0) {
        let dx = targetPosition.x - self.position.x
        let dy = targetPosition.y - self.position.y
        let distance = hypot(dx, dy)

        guard distance > 0 else { return }

        let unitDx = dx / distance
        let unitDy = dy / distance

        let duration = distance / speed

        var currentPosition = self.position
        while distanceBetween(currentPosition, targetPosition) > stepSize {
            let nextPosition = CGPoint(
                x: currentPosition.x + unitDx * stepSize,
                y: currentPosition.y + unitDy * stepSize
            )

            if !isMoveValid(to: nextPosition, walls: walls) {
                break
            }

            currentPosition = nextPosition
        }

        // start walking animation
        startWalking()

        let moveAction = SKAction.move(to: currentPosition, duration: duration)

        self.run(moveAction) {
            self.stopWalking()
        }
    }

    private func isMoveValid(to position: CGPoint, walls: [SKSpriteNode]) -> Bool {
        let futureFrame = CGRect(
            x: position.x - self.size.width / 2,
            y: position.y - self.size.height / 2,
            width: self.size.width,
            height: self.size.height
        )

        for wall in walls {
            if wall.frame.intersects(futureFrame) {
                return false
            }
        }
        return true
    }

    private func distanceBetween(_ p1: CGPoint, _ p2: CGPoint) -> CGFloat {
        return hypot(p2.x - p1.x, p2.y - p1.y)
    }
}
