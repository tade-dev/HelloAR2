//
//  RealityComposerBootcamp.swift
//  HelloAR2
//
//  Created by BSTAR on 24/01/2026.
//

import SwiftUI
import RealityKit
import ARKit

struct RealityComposerBootcamp: View {
    var body: some View {
        RealityComposerBootcampViewContainer()
            .ignoresSafeArea()
    }
}

struct RealityComposerBootcampViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        

        
        return arView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    
}


#Preview {
    RealityComposerBootcamp()
}
