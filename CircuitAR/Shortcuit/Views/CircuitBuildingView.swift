//
//  CircuitBuildingView.swift
//  CircuitAR
//
//  Created by Muhammad Rizki Miftha Alhamid on 11/10/23.
//

import SwiftUI
import RealityKit
import ARKit
import Combine

struct CircuitBuildingView: View {
    @State private var selectedComponentType: ComponentType?
    @State private var confirmAdd = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ARViewContainer(selectedComponentType: $selectedComponentType, confirmAdd: $confirmAdd)
            
            if selectedComponentType != nil {
                PlacementButtonsView(selectedComponentType: $selectedComponentType, confirmAdd: $confirmAdd)
            } else {
                ComponentPickerView(selectedComponentType: $selectedComponentType)
            }
            
        }
        
    }
    
}

enum ComponentType {
    case battery
    case resistor
    case wire
}

struct ARViewContainer: UIViewRepresentable {
    @Binding var selectedComponentType: ComponentType?
    @Binding var confirmAdd: Bool

    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = .horizontal
        config.environmentTexturing = .automatic
        arView.session.run(config)
        return arView
    }

    func updateUIView(_ uiView: ARView, context: Context) {
        if confirmAdd {
            let position = uiView.ray(through: uiView.center)
            if selectedComponentType == .battery {
                print("DEBUG: adding model to scene - Battery)")
                let battery = BatteryEntity(color: .darkGray, position: position!.direction)
                uiView.scene.anchors.append(battery)
                uiView.installGestures(.all, for: battery)
                //battery.addCollisions()
            } else if selectedComponentType == .resistor {
                print("DEBUG: adding model to scene - Resistor")
                let resistor = ResistorEntity(color: .white, position: position!.direction)
                uiView.scene.anchors.append(resistor)
                uiView.installGestures(.all, for: resistor)
                //resistor.addCollisions()
            } else if selectedComponentType == .wire {
                print("DEBUG: adding model to scene - Wire")
                let wire = WireEntity(color: .cyan, position: position!.direction)
                uiView.scene.anchors.append(wire)
                uiView.installGestures(.all, for: wire)
                wire.addCollisions()
            }
            DispatchQueue.main.async {
                confirmAdd = false
                selectedComponentType = nil
            }
        }
    }
}

struct ComponentPickerView: View {
    @Binding var selectedComponentType: ComponentType?
    
    var body: some View {
        HStack {
            Button {
                selectedComponentType = .wire
            } label: {
                Text("Wire")
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.brown))
            }
            Button {
                selectedComponentType = .battery
            } label: {
                Text("Battery")
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.brown))
            }
            Button {
                selectedComponentType = .resistor
            } label: {
                Text("Resistor")
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.brown))
            }
        }
    }
}

struct PlacementButtonsView: View {
    @Binding var selectedComponentType: ComponentType?
    @Binding var confirmAdd: Bool
    
    var body: some View {
        HStack {
            // Cancel Button
            Button {
                selectedComponentType = nil
            } label: {
                Image(systemName: "xmark")
                    .frame(width: 60, height: 60)
                    .font(.title)
                    .background(Color.white.opacity(0.75))
                    .cornerRadius(30)
                    .padding(20)
            }
            Button {
                confirmAdd = true
            } label: {
                Image(systemName: "checkmark")
                    .frame(width: 60, height: 60)
                    .font(.title)
                    .background(Color.white.opacity(0.75))
                    .cornerRadius(30)
                    .padding(20)
            }
            
        }
    }
}


#Preview {
    ContentView()
}
