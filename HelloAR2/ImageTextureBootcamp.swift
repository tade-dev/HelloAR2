//
//  ImageTextureBootcamp.swift
//  HelloAR2
//
//  Created by BSTAR on 19/01/2026.
//


import SwiftUI
import ARKit
import RealityKit
import Combine

class Coordinator3 {
    var arView: ARView?
    var cancellable: AnyCancellable?
    
    func setup() {
        
        guard let arView = self.arView else { return }
        
        let anchor = AnchorEntity(plane: .horizontal)
        
        let box = ModelEntity(mesh: .generateBox(size: 0.3))
        
        let texture = try? TextureResource.load(named: "image")
        
        if let texture {
            
            var material = UnlitMaterial()
            material.color = .init(tint: .white, texture: .init(texture))
            box.model?.materials = [material]
            
        }

        anchor.addChild(box)
        arView.scene.addAnchor(anchor)
        
    }
    
}

struct ImageTextureBootcamp: View {
    var body: some View {
        ARImageTextureBootcamp()
            .ignoresSafeArea()
    }
}

struct ARImageTextureBootcamp: UIViewRepresentable {
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        
        context.coordinator.arView = arView
        context.coordinator.setup()
        
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
    func makeCoordinator() -> Coordinator3 {
        Coordinator3()
    }
}

#Preview {
    ImageTextureBootcamp()
}
