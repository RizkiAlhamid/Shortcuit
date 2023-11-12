//
//  ContentView.swift
//  CircuitAR
//
//  Created by Muhammad Rizki Miftha Alhamid on 11/10/23.
//

import SwiftUI
import RealityKit

struct ContentView : View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Shortcuit") // Display the project name
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                
                NavigationLink(destination: CircuitBuildingView()) {
                    Text("Build Circuit")
                        .padding()
                        .foregroundColor(.white)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue))
                }
                
                NavigationLink(destination: CircuitScanningView()) {
                    Text("Scan Circuit")
                        .padding()
                        .foregroundColor(.white)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue))
                }
                
                NavigationLink(destination: AboutUsView()) {
                    Image(systemName: "info.circle")
                        .font(.title)
                        .foregroundColor(.blue)
                        .padding()
                }
            }
        }
    }
}



#Preview {
    ContentView()
}
