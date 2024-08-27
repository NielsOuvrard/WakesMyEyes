//
//  TimeSelectorView.swift
//  WakesMyEyes
//
//  Created by Niels Ouvrard on 27/08/2024.
//

import Foundation
import SwiftUI

struct TimeSelectorView: View {
    @State private var selectedDate = Date()

    var body: some View {
        VStack {
            Text("Time Selector Page")
                .font(.largeTitle)
                .padding()

            DatePicker("Select a date", selection: $selectedDate, displayedComponents: [.hourAndMinute])
                .datePickerStyle(WheelDatePickerStyle())
                .labelsHidden()
                .padding()
        }
    }
}