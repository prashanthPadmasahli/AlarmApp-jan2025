//
//  AddAlarmView.swift
//  AlarmApp-jan2025
//
//  Created by mac on 28/01/25.
//

import SwiftUI

// MARK: - Add New Alarm View
struct AddAlarmView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: AlarmViewModel
    @State private var selectedTime = Date()

    var body: some View {
        NavigationView {
            VStack {
                DatePicker("Select Time", selection: $selectedTime, displayedComponents: .hourAndMinute)
                    .datePickerStyle(WheelDatePickerStyle())
                    .padding()

                Button("Add Alarm") {
                    viewModel.addAlarm(time: selectedTime)
                    presentationMode.wrappedValue.dismiss()
                }
                .buttonStyle(.borderedProminent)
                .padding()
            }
            .navigationTitle("New Alarm")
        }
    }
}
