//
//  CircuitBuildingViewModel.swift
//  Shortcuit
//
//  Created by Muhammad Rizki Miftha Alhamid on 11/11/23.
//

import Foundation
import RealityKit
import SwiftUI

class CircuitBuildingViewModel: ObservableObject {
    // array of component entities
    var circuitComponentEntities: [CircuitComponentEntity] = []
    @Published var isValidCircuit: Bool = false
    
    // add
    func addEntity(_ entity: CircuitComponentEntity) {
        circuitComponentEntities.append(entity)
    }
    
    // remove
    
    
    // get all positions
    func getCoordinates() -> [SIMD3<Float>] {
        var positions: [SIMD3<Float>] = []
        for entity in circuitComponentEntities {
            if let batteryEntity = entity as? BatteryEntity {
                positions.append(batteryEntity.position)
            } else if let resistorEntity = entity as? ResistorEntity {
                positions.append(resistorEntity.position)
            } else if let wireEntity = entity as? WireEntity {
                positions.append(wireEntity.position)
            }
        }
        print(positions)
        return positions
    }
    
    func generateCurrentEntity(arView: ARView, position: SIMD3<Float>) {
        //let position = arView.ray(through: arView.center)
        let current = CurrentEntity(color: .yellow, position: position)
        arView.scene.anchors.append(current)
        let coordinate = position + [0,0.3,0]
        current.move(to: Transform(translation: coordinate), relativeTo: nil, duration: 2)
    }
    
    func moveTheCurrentEntity(arView: ARView, currentEntity: CurrentEntity) {
        let coordinates = getCoordinates()
        
        DispatchQueue.main.async {
            for coordinate in coordinates {
                let newCoordinate = coordinate + [0,0.3,0]
                currentEntity.move(to: Transform(translation: newCoordinate), relativeTo: nil, duration: 2)
            }
        }
    }
    
    func createBatteryEntity(arView: ARView) {
        let position = arView.ray(through: arView.center)
        let battery = BatteryEntity(color: .yellow, position: position!.direction)
        print("Battery position - \(battery.position)")
        arView.scene.anchors.append(battery)
        arView.installGestures(.all, for: battery)
        addEntity(battery)
    }
    
    func createResistorEntity(arView: ARView) {
        let position = arView.ray(through: arView.center)
        let resistor = ResistorEntity(color: .blue, position: position!.direction)
        print("Resistor position - \(resistor.position)")
        arView.scene.anchors.append(resistor)
        arView.installGestures(.all, for: resistor)
        addEntity(resistor)
    }
    
    func checkCollision(arView: ARView) {
        for circuitComponentEntity in circuitComponentEntities {
            if let battery = circuitComponentEntity as? BatteryEntity, battery.isConnected {
                generateCurrentEntity(arView: arView, position: battery.position)
            }
        }
    }
}
