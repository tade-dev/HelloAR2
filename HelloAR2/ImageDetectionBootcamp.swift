//
//  MeasurementAppBootcamp 2.swift
//  HelloAR2
//
//  Created by BSTAR on 23/01/2026.
//


import SwiftUI
import ARKit
import RealityKit
import Combine

struct ImageDetectionBootcamp: View {
    var body: some View {
        ImageDetectionBootcampView()
            .ignoresSafeArea()
    }
}

class Coordinator7: NSObject {
    var arView: ARView?
    var cancellables = Set<AnyCancellable>()

    func setupUI() {
        
        guard let arView else { return }
        
        let anchor = AnchorEntity(.image(group: "AR Resources", name: "image"))
        
        ModelEntity.loadAsync(named: "Chameleon")
            .sink { completion in
                if case let .failure(error) = completion {
                    print("Unable to load model \(error)")
                }
            } receiveValue: { entity in
                entity.scale = [0.3, 0.3, 0.3]
                anchor.addChild(entity)
                arView.scene.addAnchor(anchor)
            }
            .store(in: &cancellables)

        
    }
    
}

struct ImageDetectionBootcampView: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        
        context.coordinator.arView = arView
        context.coordinator.setupUI()
        
        arView.addCoaching()
        
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
    func makeCoordinator() -> Coordinator7 {
        Coordinator7()
    }
     
}

#Preview {
    MeasurementAppBootcamp()
}
