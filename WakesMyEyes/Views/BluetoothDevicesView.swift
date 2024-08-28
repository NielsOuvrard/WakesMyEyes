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
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var bleManager = BLEManager()
    @State private var isScanning = true

    var body: some View {
        VStack {
            List(bleManager.peripherals) { peripheral in
                HStack {
                    Text(peripheral.name)
                        .font(.headline)
                        .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                    Spacer()
                    /*
                    Button(action: {
                        if peripheral.isConnected {
                            bleManager.disconnect(peripheral: peripheral)
                        } else {
                            bleManager.connect(peripheral: peripheral)
                        }
                    }) {
                        if peripheral.isConnected {
                            Text("Disconnect")
                                .foregroundColor(.red)
                        } else {
                            Text("Connect")
                                .foregroundColor(.green)
                        }
                    }
                    */
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
                .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
            if bleManager.isSwitchedOn {
                Text("Bluetooth is switched on")
                    .foregroundColor(.green)
            } else {
                Text("Bluetooth is NOT switched on")
                    .foregroundColor(.red)
            }
            Spacer()

            VStack(spacing: 25) {
                if isScanning {
                    Button (action: {
                        bleManager.stopScanning()
                        isScanning = false
                    }) {
                        Text("Stop Scanning")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.red)
                            .cornerRadius(10)
                    }
                } else {
                    Button(action: {
                        bleManager.startScanning()
                        isScanning = true
                    }) {
                        Text("Start Scanning")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                }
            }
            .padding()

            .padding()
        }
        .background(colorScheme == .dark ? Color.black.edgesIgnoringSafeArea(.all) : Color.white.edgesIgnoringSafeArea(.all))
        .navigationTitle("Bluetooth Devices")

        .onAppear {
            if bleManager.isSwitchedOn {
                bleManager.startScanning()
            }
        }
    }
}