//
//  PhysicsExploration.swift
//  HelloAR2
//
//  Created by BSTAR on 20/01/2026.
//

import SwiftUI
import RealityKit
import ARKit
import Combine

struct PhysicsExploration: View {
    var body: some View {
        PhysicsExplorationView()
            .ignoresSafeArea()
    }
}

//class Coordinator4: NSObject {
//    
//    weak var arView: ARView?
//    var collisionSubscriptions = [Cancellable]()
//    
//    @objc func handleTap(_ recognizer: UITapGestureRecognizer) {
//        
//        guard let view = self.arView else { return }
//        let tappedLocation = recognizer.location(in: view)
//        
//        let results = view.raycast(from: tappedLocation, allowing: .estimatedPlane, alignment: .horizontal)
//        
//        if let result = results.first {
//            
//            let anchorEntity = AnchorEntity(raycastResult: result)
//            let box = ModelEntity(mesh: .generateBox(size: 0.3), materials: [SimpleMaterial(color: .green, isMetallic: true)])
//            
//            box.position.y = 0.3
//            box.generateCollisionShapes(recursive: true)
//            box.physicsBody = PhysicsBodyComponent(
//                massProperties: .default,
//                material: .generate(),
//                mode: .dynamic
//            )
//            box.collision = CollisionComponent(shapes: [.generateBox(size: [0.2, 0.2, 0.2])], mode: .trigger, filter: .sensor)
//            
//            collisionSubscriptions.append(view.scene.subscribe(to: CollisionEvents.Began.self) { event in
//                box.model?.materials = [SimpleMaterial(color: .purple, isMetallic: true)]
//            })
//            
//            collisionSubscriptions.append(view.scene.subscribe(to: CollisionEvents.Ended.self) { event in
//                box.model?.materials = [SimpleMaterial(color: .green, isMetallic: true)]
//            })
//            
//            anchorEntity.addChild(box)
//            view.scene.anchors.append(anchorEntity )
//            
//        }
//    }
//    
//}

class Coordinator4: NSObject {
    
    weak var arView: ARView?
    var collisionSubscriptions = [Cancellable]()
    
    func buildEnvironment() {
        
        guard let arView = self.arView else { return }
        
        let anchor = AnchorEntity(plane: .horizontal)
        
        let box1 = ModelEntity(mesh:  .generateBox(size: 0.2), materials: [SimpleMaterial(color: .red, isMetallic: true)])
        box1.generateCollisionShapes(recursive: true)
        box1.collision = CollisionComponent(shapes: [.generateBox(size: [0.2, 0.2, 0.2])], mode: .trigger, filter: .sensor)
                
        let box2 = ModelEntity(mesh:  .generateBox(size: 0.2), materials: [SimpleMaterial(color: .red, isMetallic: true)])
        box1.generateCollisionShapes(recursive: true)
        box1.collision = CollisionComponent(shapes: [.generateBox(size: [0.2, 0.2, 0.2])], mode: .trigger, filter: .sensor)
        box2.position.z = 0.3
        
        let sphere1 = ModelEntity(mesh:  .generateSphere(radius: 0.2), materials: [SimpleMaterial(color: .red, isMetallic: true)])
        sphere1.generateCollisionShapes(recursive: true)
        sphere1.collision = CollisionComponent(shapes: [.generateSphere(radius: 0.2)], mode: .trigger, filter: .sensor)
        box2.position.x += 0.3
        
        let sphere2 = ModelEntity(mesh:  .generateSphere(radius: 0.2), materials: [SimpleMaterial(color: .red, isMetallic: true)])
        sphere1.generateCollisionShapes(recursive: true)
        sphere1.collision = CollisionComponent(shapes: [.generateSphere(radius: 0.2)], mode: .trigger, filter: .sensor)
        box2.position.x -= 0.3
        
        anchor.addChild(box1)
        anchor.addChild(box2)
        anchor.addChild(sphere1)
        anchor.addChild(sphere2)
        
        arView.scene.anchors.append(anchor)
        
        arView.installGestures(.all, for: box1)
        arView.installGestures(.all, for: box2)
        arView.installGestures(.all, for: sphere1)
        arView.installGestures(.all, for: sphere2)
        
        collisionSubscriptions.append(arView.scene.subscribe(to: CollisionEvents.Began.self) { event in
            guard let entity1 = event.entityA as? ModelEntity,
                  let entity2 = event.entityB as? ModelEntity else { return }
            
            entity1.model?.materials = [SimpleMaterial(color: .green, isMetallic: true)]
            entity2.model?.materials = [SimpleMaterial(color: .green, isMetallic: true)]
            
        })
         
        collisionSubscriptions.append(arView.scene.subscribe(to: CollisionEvents.Ended.self) { event in
            guard let entity1 = event.entityA as? ModelEntity,
                  let entity2 = event.entityB as? ModelEntity else { return }
            
            entity1.model?.materials = [SimpleMaterial(color: .red, isMetallic: true)]
            entity2.model?.materials = [SimpleMaterial(color: .red, isMetallic: true)]
        })
        
    }
    
}

struct PhysicsExplorationView: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        
        context.coordinator.arView = arView
        context.coordinator.buildEnvironment()
        
        return arView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator4 {
        Coordinator4()
    }
    
}
