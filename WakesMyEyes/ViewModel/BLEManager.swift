//
//  BLEManager.swift
//  WakesMyEyes
//
//  Created by Niels Ouvrard on 26/08/2024.
//

import Foundation
import SwiftUI
import CoreBluetooth

class BLEManager: NSObject, ObservableObject, CBCentralManagerDelegate, CBPeripheralDelegate {
    var myCentral: CBCentralManager! // Declare a variable for the central manager
    
    @Published var isSwitchedOn = false
    @Published var peripherals = [Peripheral]()
    @Published var connectedPeripheralUUID: UUID?
    
    override init() {
        super.init()
        myCentral = CBCentralManager(delegate: self, queue: nil)
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        isSwitchedOn = central.state == .poweredOn
        if isSwitchedOn {
            startScanning()
        } else {
            stopScanning()
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String: Any], rssi RSSI: NSNumber) {
        let newPeripheral = Peripheral(id: peripheral.identifier, name: peripheral.name ?? "Unknown", rssi: RSSI.intValue)
        
        if !peripherals.contains(where: {$0.id == newPeripheral.id}) {
            DispatchQueue.main.async {
                self.peripherals.append(newPeripheral)
            }
        }
    }
    
    
    func startScanning() {
        print("startScanning") // Print a message to the console
        myCentral.scanForPeripherals(withServices: nil, options: nil) // Start scanning with no specific services
    }
    
    func stopScanning() {
        print("stopScanning") // Print a message to the console
        myCentral.stopScan() // Stop scanning
    }
    
    
    
    func connect(to peripheral: Peripheral) {
        guard let cbPeripheral = myCentral.retrievePeripherals(withIdentifiers: [peripheral.id]).first
            else { // Retrieve the peripheral by its identifier
            print("Peripheral not found for connection") // Print a message if the peripheral is not found
            return // Return if the peripheral is not found
        }
        
        connectedPeripheralUUID = cbPeripheral.identifier // Set the connected peripheral's UUID
        cbPeripheral.delegate = self // Set self as the delegate of the peripheral
        myCentral.connect(cbPeripheral, options: nil) // Connect to the peripheral
    }
    
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("Connected to \(peripheral.name ?? "Unknown")") // Print a message to the console
        peripheral.discoverServices(nil) // Discover services on the connected peripheral
    }
    
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        print("Failed to connect to \(peripheral.name ?? "Unknown"): \(error?.localizedDescription ?? "No error information")") // Print a message to the console
        if peripheral.identifier == connectedPeripheralUUID { // Check if the failed peripheral is the connected one
            connectedPeripheralUUID = nil
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        print("Disconnected from \(peripheral.name ?? "Unknown"): \(error?.localizedDescription ?? "No error information")") // Print a message to the console
        if peripheral.identifier == connectedPeripheralUUID { // Check if the failed peripheral is the connected one
            connectedPeripheralUUID = nil
        }
    }
    
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        if let services = peripheral.services {
            // Check if services are discovered
            for service in services { // Iterate through the services
                print("Discovered service: \(service.uuid)") // Print the service UUID peripheral
                peripheral.discoverCharacteristics(nil, for: service)
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        if let characteristics = service.characteristics {
            for characteristic in characteristics { // Iterate through the services
                print ("Discovered characteristic: \(characteristic.uuid)")
            }
        }
    }
}
