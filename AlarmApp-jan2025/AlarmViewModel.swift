//
//  AlarmViewModel.swift
//  AlarmApp-jan2025
//
//  Created by mac on 28/01/25.
//

import Foundation
import UserNotifications

// MARK: - ViewModel to Handle Alarms
class AlarmViewModel: ObservableObject {
    @Published var alarms: [Alarm] {
        didSet {
            saveAlarms()
        }
    }

    private let alarmsKey = "alarms"

    init() {
        self.alarms = UserDefaults.standard.load(key: alarmsKey, type: [Alarm].self) ?? []
    }

    // Add a new alarm
    func addAlarm(time: Date) {
        let newAlarm = Alarm(time: time, isEnabled: true)
        alarms.append(newAlarm)
        scheduleNotification(for: newAlarm)
    }

    // Toggle Alarm ON/OFF
    func toggleAlarm(_ alarm: Alarm) {
        if let index = alarms.firstIndex(where: { $0.id == alarm.id }) {
            alarms[index].isEnabled.toggle()
            if alarms[index].isEnabled {
                scheduleNotification(for: alarms[index])
            } else {
                removeNotification(for: alarms[index])
            }
        }
    }

    // Remove an alarm
    func removeAlarm(_ alarm: Alarm) {
        alarms.removeAll { $0.id == alarm.id }
        removeNotification(for: alarm)
    }

    // MARK: - Notification Scheduling
    private func scheduleNotification(for alarm: Alarm) {
        let content = UNMutableNotificationContent()
        content.title = "Alarm"
        content.body = "Your alarm is ringing!"
        content.sound = .default

        let triggerDate = Calendar.current.dateComponents([.hour, .minute], from: alarm.time)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)

        let request = UNNotificationRequest(identifier: alarm.id.uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }

    private func removeNotification(for alarm: Alarm) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [alarm.id.uuidString])
    }

    // MARK: - Save Alarms
    private func saveAlarms() {
        UserDefaults.standard.save(alarms, key: alarmsKey)
    }
}
