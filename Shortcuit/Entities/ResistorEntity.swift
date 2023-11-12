//
//  ResistorModel.swift
//  CircuitAR
//
//  Created by Muhammad Rizki Miftha Alhamid on 11/11/23.
//

import Foundation
import RealityKit
import Combine
import SwiftUI

class ResistorEntity: Entity, HasModel, HasAnchoring, HasCollision, CircuitComponentEntity {
    var collisionSubs: [Cancellable] = []
    var modelEntity: ModelEntity?
    
    required init(color: UIColor) {
        super.init()
        
        // load uzdz
        guard let modelEntity = try? Entity.loadModel(named: "Resistor") else {
            fatalError("Failed to load the model from Battery.usdz")
        }
        modelEntity.move(to: Transform(scale: [0.3,0.3,0.3]), relativeTo: modelEntity)
        
        // set up collision
        self.components[CollisionComponent] = CollisionComponent(
            shapes: [.generateBox(size: [0.2,0.2,0.5])],
            mode: .trigger,
          filter: .sensor
        )
        
        modelEntity.model?.materials = [SimpleMaterial(color: color, isMetallic: false)]
        self.modelEntity = modelEntity
        self.addChild(modelEntity)
    }
    
    convenience init(color: UIColor, position: SIMD3<Float>) {
        self.init(color: color)
        self.position = position
    }
    
    required init() {
        fatalError("init() has not been implemented")
    }
    
}
