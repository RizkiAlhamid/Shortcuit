//
//  CircuitScanningView.swift
//  Shortcuit
//
//  Created by Muhammad Rizki Miftha Alhamid on 11/12/23.
//

import SwiftUI
import RealityKit
import ARKit

struct CircuitScanningView: View {
    @State var confirmAdd = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            CircuitScanningARViewContainer()
                .edgesIgnoringSafeArea(.all)
        }
    }
}

struct CircuitScanningARViewContainer: UIViewRepresentable {
    var arView = ARView(frame: .zero)

    func makeUIView(context: Context) -> ARView {
        //let entity = ModelEntity(mesh: .generateBox(size: 0.1))
        guard let modelEntity = try? Entity.loadModel(named: "Circuit") else {
            fatalError("Failed to load the model from Battery.usdz")
        }
        modelEntity.move(to: Transform(scale: [0.1,0.1,0.1]), relativeTo: modelEntity)
        let rotation: Float = 90 * .pi / 180
        modelEntity.move(to: Transform(yaw: rotation), relativeTo: modelEntity)
        modelEntity.position += [-0.03, 0, 0.04]
//        modelEntity.move(to: Transform(translation: [2, 0.3, 3]), relativeTo: nil)
        let anchor = AnchorEntity(.image(group: "AR Resources", name: "circuit"))
        //anchor.move(to: Transform(translation: newTranslation), relativeTo: anchor)
        
        modelEntity.setParent(anchor)
        arView.scene.anchors.append(anchor)
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
    }
}

struct PlaceAnchorView: View {
    @Binding var foundAnchor: Bool
    @Binding var confirmAdd: Bool
    
    var body: some View {
        HStack {
            // Cancel Button
            Button {
                foundAnchor = false
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
    CircuitScanningView()
}
