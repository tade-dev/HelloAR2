//
//  ContentView 2.swift
//  HelloAR2
//
//  Created by BSTAR on 18/01/2026.
//


import SwiftUI
import RealityKit
import ARKit
import AVFoundation

struct ContentView2 : View {

    var body: some View {
        
        ARViewContainer2().edgesIgnoringSafeArea(.all)
        
    }

}

struct ARViewContainer2: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        
        let anchor = AnchorEntity(plane: .horizontal)
        
        guard let url = Bundle.main.url(forResource: "video", withExtension: "mp4") else {
            fatalError("Video file was not found!")
        }
        
        let player = AVPlayer(url: url)
        
        let material = VideoMaterial(avPlayer: player)
        
        material.controller.audioInputMode = .spatial
        
        let modelEntity = ModelEntity(mesh: .generatePlane(width: 0.5, depth: 0.4), materials: [material])
        
        player.play()
        
        anchor.addChild(modelEntity)
        arView.scene.addAnchor(anchor)
        
        
        return arView
    }

    func updateUIView(_ uiView: ARView, context: Context) {}
    
}

#Preview {
    ContentView2()
}
 
