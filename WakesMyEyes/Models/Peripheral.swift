//
//  Peripherical.swift
//  WakesMyEyes
//
//  Created by Niels Ouvrard on 26/08/2024.
//

import Foundation
import CoreBluetooth

struct Peripheral: Identifiable {
    let id: UUID
    let name: String
    let rssi: Int
    let cbPeripheral: CBPeripheral
}
