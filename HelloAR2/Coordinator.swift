//
//  Coordinator.swift
//  HelloAR2
//
//  Created by BSTAR on 15/01/2026.
//

import Foundation
import ARKit
import RealityKit
import Combine

class Coordinator: NSObject {
    
    weak var view: ARView?
    var cancellables: AnyCancellable?
    
    @objc func handleTap(_ recognizer: UITapGestureRecognizer) {
        guard let view = self.view else { return }
        
        guard view.scene.anchors.first(where: { anchor in
            anchor.name == "LunarRoverAnchor"
        }) == nil else {
            return
        }
        
        let tappedLocation = recognizer.location(in: view)
        
        let result = view.raycast(from: tappedLocation, allowing: .estimatedPlane, alignment: .horizontal)
        
        if let result = result.first {
            
            // create anchor entity
            let anchor = AnchorEntity(raycastResult: result)
            
//            cancellables = ModelEntity.loadAsync(named: "Football")
//                .append(ModelEntity.loadAsync(named: "Fender"))
//                .collect()
//                .sink { loadCompletion in
//                    if case let .failure(error) = loadCompletion {
//                        print("Error loading model: \(error)")
//                    }
//                    
//                    self.cancellables?.cancel()
//                } receiveValue: { entities in
//                    
//                    var x: Float = 0.0
//                    
//                    entities.forEach { entity in
//                        
//                        entity.position = simd_make_float3(x, 0, 0)
//                        
//                        anchor.addChild(entity)
//                        
//                        x += 0.3
//                    }
//                }
            
            cancellables = ModelEntity.loadAsync(named: "LunarRover")
                .sink { loadCompletion in
                    if case let .failure(error) = loadCompletion {
                        print("Error loading model: \(error)")
                    }
                    
                    self.cancellables?.cancel()
                } receiveValue: { entity in
                    anchor.name = "LunarRoverAnchor"
                    anchor.addChild(entity)
                }

            // add anchor to the scene
            view.scene.addAnchor(anchor)
            
            
            
            // create an anchor for each place tapped
//            let anchorEntity = AnchorEntity(raycastResult: result)
//            
//            // create a model entity for that anchor
//            let modelEntity = ModelEntity(mesh: .generateBox(size: 0.3))
//            modelEntity.generateCollisionShapes(recursive: true)
//            modelEntity.model?.materials = [SimpleMaterial(color: .blue, isMetallic: true)]
//            
//            anchorEntity.addChild(modelEntity)
//            
//            view.scene.addAnchor(anchorEntity)
//            
//            view.installGestures(.all, for: modelEntity)
//            
        }
//
//        if let entity = view.entity(at: tappedLocation) as? ModelEntity {
//            let material = SimpleMaterial(color: .yellow, isMetallic: true)
//            entity.model?.materials = [material]
//        }
        
        
    }
    
}
 
