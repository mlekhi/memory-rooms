//
//  PhysicsCategory.swift
//  memory-rooms
//
//  Created by Maya Lekhi on 2025-01-24.
//

import Foundation

struct PhysicsCategory {
    static let None: UInt32 = 0           // No category
    static let Player: UInt32 = 0x1 << 0 // First category (1)
    static let Wall: UInt32 = 0x1 << 1   // Second category (2)
    static let Object: UInt32 = 0x1 << 2 // Third category (4)
    static let Enemy: UInt32 = 0x1 << 3  // Fourth category (8)
}
