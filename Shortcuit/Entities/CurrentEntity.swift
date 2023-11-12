//
//  CurrentEntity.swift
//  Shortcuit
//
//  Created by Muhammad Rizki Miftha Alhamid on 11/11/23.
//

import Foundation
import RealityKit
import Combine
import SwiftUI

class CurrentEntity: Entity, HasModel, HasCollision, HasAnchoring {
    required init(color: UIColor) {
        super.init()
        
        self.components[ModelComponent] = ModelComponent(
            mesh: .generateSphere(radius: 0.05),
            materials: [SimpleMaterial(
                color: color,
                isMetallic: false)
            ]
        )
    }
    
    convenience init(color: UIColor, position: SIMD3<Float>) {
        self.init(color: color)
        self.position = position
    }
    
    required init() {
        fatalError("init() has not been implemented")
    }
}
