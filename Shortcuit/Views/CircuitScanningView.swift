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
    var body: some View {
        CircuitScanningARViewContainer().edgesIgnoringSafeArea(.all)
    }
}

struct CircuitScanningARViewContainer: UIViewRepresentable {
    var arView = ARView(frame: .zero)
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, ARSessionDelegate {
        var parent: CircuitScanningARViewContainer
        
        init(parent: CircuitScanningARViewContainer) {
            self.parent = parent
        }
        
        func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
            guard let imageAnchor = anchors[0] as? ARImageAnchor else {
                print("Problems loading anchor.")
                return
            }
            
            // size of video plane depending of the image
            let width = Float(imageAnchor.referenceImage.physicalSize.width * 1.03)
            let height = Float(imageAnchor.referenceImage.physicalSize.height * 1.03)
            
            // Sets the aspect ratio of the video to be played, and the corner radius of the video
            let circuitPlane = ModelEntity(mesh: .generatePlane(width: width, depth: height, cornerRadius: 0.3), materials: [SimpleMaterial(
                color: .black,
                isMetallic: false)
            ])
            guard let modelEntity = try? Entity.loadModel(named: "Circuit") else {
                fatalError("Failed to load the model from Battery.usdz")
            }
            
            // Assigns reference image that will be detected
            if let imageName = imageAnchor.name, imageName == "circuit" {
                let anchor = AnchorEntity(anchor: imageAnchor)
                //let anchor = AnchorEntity()
//                let position = parent.arView.ray(through: parent.arView.center)
//                let anchor = AnchorEntity(world: position!.direction)
                // Adds specified video to the anchor
                parent.arView.installGestures(.all, for: modelEntity)
                anchor.addChild(circuitPlane)
                parent.arView.scene.addAnchor(anchor)
            }
        }
        
        // Checks for tracking status
//        func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
//            guard let imageAnchor = anchors[0] as? ARImageAnchor else {
//                print("Problems loading anchor.")
//                return
//            }
//            
//            // Plays/pauses the video when tracked/loses tracking
//            if imageAnchor.isTracked {
//                //videoPlayer.play()
//            } else {
//                //videoPlayer.pause()
//            }
//        }
    }
    
    func makeUIView(context: Context) -> ARView {
        guard let referenceImages = ARReferenceImage.referenceImages(
            inGroupNamed: "AR Resources", bundle: nil)
        else {
            fatalError("Missing expected asset catalog resources.")
        }
        
        // Assigns coordinator to delegate the AR View
        arView.session.delegate = context.coordinator
        
        let configuration = ARImageTrackingConfiguration()
        configuration.isAutoFocusEnabled = true
        configuration.trackingImages = referenceImages
        configuration.maximumNumberOfTrackedImages = 1
        
        // Enables People Occulusion on supported iOS Devices
        if ARWorldTrackingConfiguration.supportsFrameSemantics(.personSegmentationWithDepth) {
            configuration.frameSemantics.insert(.personSegmentationWithDepth)
        } else {
            print("People Segmentation not enabled.")
        }
        print("Screennnn")
        arView.session.run(configuration)
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
}

#Preview {
    CircuitScanningView()
}
