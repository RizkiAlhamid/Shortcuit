//
//  AboutUsView.swift
//  Shortcuit
//
//  Created by Muhammad Rizki Miftha Alhamid on 11/12/23.
//

import SwiftUI

struct AboutUsView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Shortcuit")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                    .padding()
                
                Text("Welcome to Shortcuit – your gateway to understanding circuits in a whole new way! Our project was born from the collective struggle of grasping electrical currents, and Shortcuit is here to simplify it all.")
                    .padding()
                
                Text("What Shortcuit Does:")
                    .font(.headline)
                    .fontWeight(.bold)
                
                Text("Shortcuit is an AR-powered educational tool. Visualize circuits in real-time by placing virtual elements in your surroundings. It also functions as a testing ground, allowing you to predict and analyze circuit behavior without real-world risks.")
                    .padding()
                
                Text("How We Built It:")
                    .font(.headline)
                    .fontWeight(.bold)
                
                Text("Shortcuit is built on Reality and ARKit technologies, enabling seamless interaction with virtual circuit elements. The testing feature integrates principles from circuit simulation tools.")
                    .padding()
                
                Text("What We Learned:")
                    .font(.headline)
                    .fontWeight(.bold)
                
                Text("Through our implementation of AR, we were able to gain an understanding of the improvements the 3D visualization would bring to the real world. The development process deepened our understanding of combining AR with circuit simulation, from image detection to user interface design.")
                    .padding()
                
                Text("What's Next for Shortcuit:")
                    .font(.headline)
                    .fontWeight(.bold)
                
                Text("We're enhancing Shortcuit with more educational features, a broader range of circuit components, and refined testing. Your feedback guides us as we make Shortcuit a comprehensive tool for learning and prototyping circuits. Join us in reshaping how circuits are understood and tested with Shortcuit!")
                    .padding()
                
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    AboutUsView()
}
