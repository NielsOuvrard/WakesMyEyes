//
//  HomeView.swift
//  WakesMyEyes
//
//  Created by Niels Ouvrard on 27/08/2024.
//

import Foundation
import SwiftUI
struct HomeView: View {
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        NavigationView {
            VStack {
                Text("Wakes My Eyes")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                    .foregroundColor(colorScheme == .dark ? Color.white : Color.black)

                Spacer()
                
                VStack(spacing: 20) {
                    // Navigation Links to other pages
                    NavigationLink(destination: BluetoothDevicesView()) {
                        Text("Connect your device")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.white)
                            .background(colorScheme == .dark ? Color.blue : Color.blue.opacity(0.7))
                            .cornerRadius(10)
                    }
                    
                    NavigationLink(destination: TimeSelectorView()) {
                        Text("Time")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.white)
                            .background(colorScheme == .dark ? Color.green : Color.green.opacity(0.7))
                            .cornerRadius(10)
                    }
                    
                    NavigationLink(destination: SettingsView()) {
                        Text("Settings")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.white)
                            .background(colorScheme == .dark ? Color.orange : Color.orange.opacity(0.7))
                            .cornerRadius(10)
                    }
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .background(colorScheme == .dark ? Color.black.edgesIgnoringSafeArea(.all) : Color.white.edgesIgnoringSafeArea(.all))
            .navigationBarHidden(true)
        }
    }
}
