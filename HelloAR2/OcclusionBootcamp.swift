//
//  OcclusionBootcamp.swift
//  HelloAR2
//
//  Created by BSTAR on 18/01/2026.
//

import SwiftUI
import ARKit
import RealityKit
import Combine

class Coordinator2 {
    var arView: ARView?
    var cancellable: AnyCancellable?
    
    func setup() {
        
        guard let arView = self.arView else { return }
        
        let anchor = AnchorEntity(plane: .horizontal)
        
        let box = ModelEntity(mesh: .generateBox(size: 0.3), materials: [OcclusionMaterial()])
        box.generateCollisionShapes(recursive: true)
        
        arView.installGestures(.all, for: box)
        
        cancellable = ModelEntity.loadAsync(named: "Fender")
            .sink { [weak self] completion in
                
                if case let .failure(error) = completion {
                    fatalError("Unable to load model \(error)")
                }
                
                self?.cancellable?.cancel()
                
            } receiveValue: { entity in
                anchor.addChild(entity)
            }
        
        anchor.addChild(box)
        arView.scene.addAnchor(anchor)
        
    }
    
}

struct OcclusionBootcamp: View {
    var body: some View {
       ARScreen()
            .ignoresSafeArea()
    }
}

struct ARScreen: UIViewRepresentable {
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        
        context.coordinator.arView = arView
        context.coordinator.setup()
        
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
    func makeCoordinator() -> Coordinator2 {
        Coordinator2()
    }
}

#Preview {
    OcclusionBootcamp()
}
