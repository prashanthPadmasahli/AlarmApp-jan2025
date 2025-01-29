//
//  ContentView.swift
//  AlarmApp-jan2025
//
//  Created by mac on 28/01/25.
//

import SwiftUI

import SwiftUI
import UserNotifications


// MARK: - Main ContentView (Alarm List)
struct ContentView: View {
    @StateObject private var viewModel = AlarmViewModel()
    @State private var showAddAlarm = false

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(viewModel.alarms) { alarm in
                        HStack {
                            Text(alarm.time, style: .time)
                                .font(.title2)
                            Spacer()
                            Toggle("", isOn: Binding(
                                get: { alarm.isEnabled },
                                set: { _ in viewModel.toggleAlarm(alarm) }
                            ))
                        }
                    }
                    .onDelete(perform: { indexSet in
                        indexSet.forEach { viewModel.removeAlarm(viewModel.alarms[$0]) }
                    })
                }
            }
            .navigationTitle("Alarms")
            .toolbar {
                Button(action: { showAddAlarm = true }) {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showAddAlarm) {
                AddAlarmView(viewModel: viewModel)
            }
        }
    }
}

