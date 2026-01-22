//
//  ARCoachingBootcamp.swift
//  HelloAR2
//
//  Created by BSTAR on 22/01/2026.
//

import SwiftUI
import RealityKit
import ARKit

struct ARCoachingBootcamp: View {
    var body: some View {
        ARCoachingBootcampView()
            .ignoresSafeArea()
    }
}

extension ARView: ARCoachingOverlayViewDelegate {
    
    func addCoaching() {
        let coachingOverlay = ARCoachingOverlayView()
        coachingOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        coachingOverlay.goal = .horizontalPlane
        coachingOverlay.session = self.session
        
        self.addSubview(coachingOverlay)
    }
    
    private func addVirtualObjects() {
        
        let box = ModelEntity(mesh: .generateBox(size: 0.3), materials: [SimpleMaterial(color: .green, isMetallic: true)])
        
        guard let anchor = self.scene.anchors.first(where: { $0.name == "Plane Anchor" }) else {
            return
        }
        
        anchor.addChild(box)
        
    }
    
    public func coachingOverlayViewDidDeactivate(_ coachingOverlayView: ARCoachingOverlayView) {
        addVirtualObjects()
    }
    
}

struct ARCoachingBootcampView: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        let anchor = AnchorEntity(plane: .horizontal)
        anchor.name = "Plane Anchor"
        arView.scene.addAnchor(anchor)
        arView.addCoaching()
        
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        
    }
    
    
}

#Preview {
    ARCoachingBootcamp()
}
