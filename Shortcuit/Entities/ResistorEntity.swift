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

class ResistorEntity: Entity, HasModel, HasAnchoring, HasCollision {
    var collisionSubs: [Cancellable] = []
    
    required init(color: UIColor) {
        super.init()
        
        self.components[CollisionComponent] = CollisionComponent(
            shapes: [.generateBox(size: [0.3, 0.3, 0.3])],
            mode: .trigger,
          filter: .sensor
        )
        
        self.components[ModelComponent] = ModelComponent(
            mesh: .generateBox(size: [0.3, 0.3, 0.3]),
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
    
    func addCollisions() {
        guard let scene = self.scene else {
            return
        }
        
        collisionSubs.append(scene.subscribe(to: CollisionEvents.Began.self, on: self) { event in
            guard let boxA = event.entityA as? ResistorEntity else {
                return
            }
            
            boxA.model?.materials = [SimpleMaterial(color: .red, isMetallic: false)]
        })
        collisionSubs.append(scene.subscribe(to: CollisionEvents.Ended.self, on: self) { event in
            guard let boxA = event.entityA as? ResistorEntity else {
                return
            }
            boxA.model?.materials = [SimpleMaterial(color: .yellow, isMetallic: false)]
        })
    }
    
}