//
//  ContentView.swift
//  HelloAR2
//
//  Created by BSTAR on 15/01/2026.
//

import SwiftUI
import RealityKit
import ARKit

struct ContentView : View {

    var body: some View {
        
        ARViewContainer().edgesIgnoringSafeArea(.all)
        
    }

}

struct ARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        arView.addGestureRecognizer(UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleTap)))
        
        context.coordinator.view = arView
        
        let anchor = AnchorEntity(plane: .horizontal)
        
        let material = SimpleMaterial(color: .red, isMetallic: true)
        let box = ModelEntity(mesh: .generateBox(size: 0.3), materials: [material])
        
        box.generateCollisionShapes(recursive: true)
//
//        let sphereMaterial = SimpleMaterial(color: .systemPink, isMetallic: true)
//        let sphere = ModelEntity(mesh: .generateSphere(radius: 0.3), materials: [sphereMaterial])
//        sphere.position = simd_make_float3(0, 0.4, 0)
//        
//        let planeMaterial = SimpleMaterial(color: .blue, isMetallic: true)
//        let plane = ModelEntity(mesh: .generatePlane(width: 0.5, depth: 0.3), materials: [planeMaterial])
//        plane.position = simd_make_float3(0, 0.7, 0)
        
//        let textMaterial = SimpleMaterial(color: .blue, isMetallic: true)
//        let text = ModelEntity(mesh: .generateText("Hello AR", extrusionDepth: 0.03, font: .systemFont(ofSize: 0.2), containerFrame: .zero, alignment: .center, lineBreakMode: .byCharWrapping), materials: [textMaterial])
        
        anchor.addChild(box)
        
        arView.scene.anchors.append(anchor)
        
        return arView
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
}

#Preview {
    ContentView()
}
 
