//
//  TimeSelectorView.swift
//  WakesMyEyes
//
//  Created by Niels Ouvrard on 27/08/2024.
//

import Foundation
import SwiftUI

import UserNotifications
struct TimeSelectorView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var alarmTime = Date()
    
    init() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("Notifications authorization granted.")
            } else {
                print("Notifications authorization denied because: \(error?.localizedDescription ?? "Unknown reason")")
            }
        }
    }
 
    var body: some View {
        NavigationView {
            VStack {
                DatePicker("Set Alarm", selection: $alarmTime, displayedComponents: .hourAndMinute)
                    .datePickerStyle(WheelDatePickerStyle())
                    .labelsHidden()
                    .padding()
                    .background(colorScheme == .dark ? Color.black : Color.white)
                    .cornerRadius(10)

                Button("Set Alarm") {
                    // Here you can add the code to set the alarm
                    print("Alarm set for \(alarmTime)")
                    scheduleNotification()
                }
                .padding()
                .background(colorScheme == .dark ? Color.blue : Color.blue.opacity(0.7))
                .foregroundColor(.white)
                .cornerRadius(10)

                Spacer()
            }
            .background(colorScheme == .dark ? Color.black.edgesIgnoringSafeArea(.all) : Color.white.edgesIgnoringSafeArea(.all))
            .navigationTitle("Set Alarm")
        }
    }


    func scheduleNotification() {
        let center = UNUserNotificationCenter.current()

        let content = UNMutableNotificationContent()
        content.title = "Wakes your eyes"
        content.body = "Your alarm is ringing!\nOpen your eyes!"

        let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: alarmTime)

        // print hours and minutes
        print("Hours: \(dateComponents.hour ?? 0), Minutes: \(dateComponents.minute ?? 0)")
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
    }

    /*
    func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Reminder"
        content.body = "Don't forget to check your tasks!"
        content.sound = UNNotificationSound.default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

        let request = UNNotificationRequest(identifier: "reminderNotification", content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            } else {
                print("Notification scheduled successfully")
            }
        }
    }
    */

}