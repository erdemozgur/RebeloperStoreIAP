//
//  WindowTraitCollection.swift
//  Layoutless
//
//  Created by Srdan Rasic on 23/06/2018.
//  Copyright © 2018 Declarative Hub. All rights reserved.
//

import Foundation
import UIKit

public struct WindowTraitCollection: Hashable {

    public let traitCollection: UITraitCollection
    public let size: CGSize

    public func hash(into hasher: inout Hasher) {
        hasher.combine(traitCollection)
        hasher.combine(size.width)
        hasher.combine(size.height)
    }
}

public struct TraitQuery: Hashable {

    public let traitCollection: UITraitCollection?
    public let width: Length?
    public let height: Length?

    public init(traitCollection: UITraitCollection) {
        self.traitCollection = traitCollection
        self.width = nil
        self.height = nil
    }

    public init(width: Length) {
        self.traitCollection = nil
        self.width = width
        self.height = nil
    }

    public init(height: Length) {
        self.traitCollection = nil
        self.width = nil
        self.height = height
    }

    public init(width: Length, height: Length) {
        self.traitCollection = nil
        self.width = width
        self.height = height
    }

    public init(traitCollection: UITraitCollection?, width: Length?, height: Length?) {
        self.traitCollection = traitCollection
        self.width = width
        self.height = height
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(traitCollection)
        hasher.combine(width)
        hasher.combine(height)
    }
}

extension WindowTraitCollection {
    
    public func matches(_ query: TraitQuery) -> Bool {
        if let queryTraitCollection = query.traitCollection, !traitCollection.containsTraits(in: queryTraitCollection) {
            return false
        }
        if let width = query.width, !width.satisfies(size.width) {
            return false
        }
        if let height = query.height, !height.satisfies(size.height) {
            return false
        }
        return true
    }
}

extension UIWindow {

    public var windowTraitCollection: WindowTraitCollection {
        return WindowTraitCollection(traitCollection: traitCollection, size: bounds.size)
    }
}
