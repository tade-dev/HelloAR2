//
//  MeasurementAppBootcamp.swift
//  HelloAR2
//
//  Created by BSTAR on 22/01/2026.
//

import SwiftUI
import ARKit
import RealityKit

struct MeasurementAppBootcamp: View {
    var body: some View {
        MeasurementAppView()
            .ignoresSafeArea()
    }
}

class Coordinator6: NSObject {
    var arView: ARView?
    var startAnchor: AnchorEntity?
    var endAnchor: AnchorEntity?
    
    lazy var measurementButton: UIButton = {
        let button = UIButton(configuration: .filled())
        button.setTitle("0.00", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = false
        return button
    }()
    
    lazy var resetButton: UIButton = {
        let button = UIButton(configuration: .gray(), primaryAction: UIAction(handler: { [weak self] action in
            guard let arView = self?.arView else { return }
            
            self?.startAnchor = nil
            self?.endAnchor = nil
            
            arView.scene.anchors.removeAll()
            self?.measurementButton.setTitle("0.00", for: .normal)
        }))
        
        button.setTitle("Reset", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func handleTap(_ recognizer: UITapGestureRecognizer) {
        
        guard let arView else { return }
        
        let tappedLocation = recognizer.location(in: arView)
        
        let results = arView.raycast(from: tappedLocation, allowing: .estimatedPlane, alignment: .horizontal)
            
        if let result = results.first {
            
            if startAnchor == nil {
                 
                startAnchor = AnchorEntity(raycastResult: result)
                let cone = ModelEntity(mesh: .generateCone(height: 0.1, radius: 0.1), materials: [SimpleMaterial(color: .green, isMetallic: true)])
                startAnchor?.addChild(cone)
                guard let startAnchor else { return }
                arView.scene.addAnchor(startAnchor)
                
            } else if endAnchor == nil{
                
                endAnchor = AnchorEntity(raycastResult: result)
                let cone = ModelEntity(mesh: .generateCone(height: 0.1, radius: 0.1), materials: [SimpleMaterial(color: .red, isMetallic: true)])
                endAnchor?.addChild(cone)
                guard let endAnchor, let startAnchor else { return }
                arView.scene.addAnchor(endAnchor)
                
                let distance = simd_distance(startAnchor.position(relativeTo: nil), endAnchor.position(relativeTo: nil))
                measurementButton.setTitle(String(format: "%.2f meters", distance), for: .normal)
            }
            
        }
        
    }
    
    func setupUI() {
        
        guard let arView else { return }
        
        let stackView = UIStackView(arrangedSubviews: [measurementButton, resetButton])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        arView.addSubview(stackView)
        
        stackView.centerXAnchor.constraint(equalTo: arView.centerXAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: arView.bottomAnchor, constant: -60).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
    }
    
}

struct MeasurementAppView: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = .horizontal
        arView.session.run(config)
        
        arView.addGestureRecognizer(UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator6.handleTap)))
        context.coordinator.arView = arView
        context.coordinator.setupUI()
        
        arView.addCoaching()
        
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
    func makeCoordinator() -> Coordinator6 {
        Coordinator6()
    }
    
}

#Preview {
    MeasurementAppBootcamp()
}
