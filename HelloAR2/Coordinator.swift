//
//  Coordinator.swift
//  HelloAR2
//
//  Created by BSTAR on 15/01/2026.
//

import Foundation
import ARKit
import RealityKit

class Coordinator: NSObject {
    
    weak var view: ARView?
    
    @objc func handleTap(_ recognizer: UITapGestureRecognizer) {
        guard let view = self.view else { return }
        let tappedLocation = recognizer.location(in: view)
        
        let result = view.raycast(from: tappedLocation, allowing: .estimatedPlane, alignment: .horizontal)
        
        if let result = result.first {
            
            // create an anchor for each place tapped
            let anchorEntity = AnchorEntity(raycastResult: result)
            
            // create a model entity for that anchor
            let modelEntity = ModelEntity(mesh: .generateBox(size: 0.3))
            modelEntity.generateCollisionShapes(recursive: true)
            modelEntity.model?.materials = [SimpleMaterial(color: .blue, isMetallic: true)]
            
            anchorEntity.addChild(modelEntity)
            
            view.scene.addAnchor(anchorEntity)
            
            view.installGestures(.all, for: modelEntity)
            
        }
//
//        if let entity = view.entity(at: tappedLocation) as? ModelEntity {
//            let material = SimpleMaterial(color: .yellow, isMetallic: true)
//            entity.model?.materials = [material]
//        }
        
        
    }
    
}
 
