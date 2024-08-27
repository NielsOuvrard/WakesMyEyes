//
//  ContentView.swift
//  WakesMyEyes
//
//  Created by Niels Ouvrard on 26/08/2024.
//

import Foundation
import SwiftUI
import CoreBluetooth

struct BluetoothDevicesView: View {
    @StateObject var bleManager = BLEManager()
    @State private var isPresentingTimeSelector = false
    
    var body: some View {
        VStack(spacing: 10) {
            // Text("Connect your device")
            //     .font(.largeTitle)
            //     .frame(maxWidth: .infinity, alignment: .center)
            
            List(bleManager.peripherals) { peripheral in
                HStack {
                    if peripheral.name == "Hoot hoot" {
                        Text(peripheral.name)
                            .foregroundColor(.blue)
                            .bold()
                    } else {
                        Text(peripheral.name)
                    }
                    Spacer()
                    Text(String(peripheral.rssi))
                    Button(action: {
                        bleManager.connect(to: peripheral)
                    }) {
                        if bleManager.connectedPeripheralUUID == peripheral.id {
                            Text("Connected")
                                .foregroundColor(.green)
                        } else {
                            Text("Connect")
                        }
                    }
                }
            }
            .frame(height: UIScreen.main.bounds.height / 2)

            
            Spacer()
            
            Text("STATUS")
                .font(.headline)
            if bleManager.isSwitchedOn {
                Text("Bluetooth is switched on")
                    .foregroundColor(.green)
            } else {
                Text("Bluetooth is NOT switched on")
                    .foregroundColor(.red)
            }
            Spacer()
        
        
            VStack(spacing: 25) {
                Button (action: {
                    bleManager.startScanning()
                }) {
                    Text("Start Scanning")
                }.buttonStyle(BorderedProminentButtonStyle())
                
                
                Button(action: {
                    bleManager.stopScanning()
                }) {
                    Text("Stop Scanning")
                }
                .buttonStyle(BorderedProminentButtonStyle())
            }
            .padding()
            
            .padding()
        }
        .navigationTitle("Bluetooth Devices")
        
        .onAppear {
            if bleManager.isSwitchedOn {
                bleManager.startScanning()
            }
        }
    }
}
