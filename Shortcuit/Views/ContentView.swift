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
            HStack {
                NavigationLink {
                    CircuitBuildingView()
                } label: {
                    Text("Build Circuit")
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray))
                }
                NavigationLink {
                    CircuitScanningView()
                } label: {
                    Text("Scan Circuit")
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray))
                }

            }
        }
    }
}



#Preview {
    ContentView()
}
