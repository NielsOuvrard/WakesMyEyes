//
//  HomeView.swift
//  WakesMyEyes
//
//  Created by Niels Ouvrard on 27/08/2024.
//

import Foundation
import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Wakes My Eyes")
                    .font(.largeTitle)
                    .padding()
                
                Spacer()
                
                VStack(spacing: 10) {
                    // Navigation Links to other pages
                    VStack(spacing: 20) {
                        NavigationLink(destination: BluetoothDevicesView()) {
                            Text("Connect your device")
                        }
                        
                        NavigationLink(destination: TimeSelectorView()) {
                            Text("Time")
                        }
                        
                        NavigationLink(destination: SettingsView()) {
                            Text("Settings")
                        }
                    }
                }
            }
        }
    }
}
