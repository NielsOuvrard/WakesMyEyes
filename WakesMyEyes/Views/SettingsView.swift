//
//  SettingsView.swift
//  WakesMyEyes
//
//  Created by Niels Ouvrard on 27/08/2024.
//
import Foundation
import SwiftUI

struct SettingsView: View {
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        VStack {
            Text("Settings View")
                .font(.largeTitle)
                .padding()
                .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
            Spacer()
            Text("Here you can set your preferences for the alarm, such as the intensity of the lights and vibrations.")
                .font(.headline)
                .padding()
                .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
            Spacer()
            // Add more settings options here
        }
        .background(colorScheme == .dark ? Color.black.edgesIgnoringSafeArea(.all) : Color.white.edgesIgnoringSafeArea(.all))
    }
}