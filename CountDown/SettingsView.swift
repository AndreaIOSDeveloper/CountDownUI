//
//  SettingsView.swift
//  CountDown
//
//  Created by Di Francia, Andrea (Contractor) on 08/07/22.
//

import SwiftUI

struct SettingsView: View {
    @StateObject private var viewModel = DataViewModel.shared
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @State private var isTimerRunning = false
    @State private var startTime: Date?
    @State private var timerString = "00:00:00"
    
    init() { }
    
    private func saveCurrentUserDate() {
        let userDefaults = UserDefaults.standard

        do {
            try userDefaults.setObject(Date(), forKey: "UserDateStartApp")
            print("🟢 Salvo Data Iniziale di utilizzo l'app: \(Date())")
        } catch {
            print(error.localizedDescription)
            print("🟠 ERRORE Salvataggio data app: \(error.localizedDescription)")
        }
    }
    
    func receiceCurrentDateAppUsed(callback: (Date?)->()) {
        let userDefaults = UserDefaults.standard
        do {
            let dateUsedAppFirstTime = try userDefaults.getObject(forKey: "UserDateStartApp", castTo: Date.self)
            print("🟢 Data utilizzo app prima volta: \(dateUsedAppFirstTime)")
            callback(dateUsedAppFirstTime)
        } catch {
            print("🟠 ERRORE data utilizzo app prima volta: \(error.localizedDescription)")
            callback(nil)
        }
    }
    
    var body: some View {
        NavigationView {
            Text(self.timerString)
                        .font(Font.system(.largeTitle, design: .monospaced))
                        .onReceive(timer) { _ in
                            if self.isTimerRunning {
                                timerString = Date().passedTime(from: startTime ?? Date())
                            }
                        }
                        .onAppear() {
                            if !isTimerRunning {
                                timerString = "00:00:00"
                                receiceCurrentDateAppUsed { date in
                                    if date == nil {
                                        saveCurrentUserDate()
                                    } else {
                                        startTime = date ?? Date()
                                    }
                                }
                            }
                            isTimerRunning.toggle()
                        }
        }
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.large)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

extension Date {
    func passedTime(from date: Date) -> String {
        let difference = Calendar.current.dateComponents([.minute, .second], from: date, to: self)
        let strOre = String(format: "%02d", difference.hour ?? 00)
        let strMin = String(format: "%02d", difference.minute ?? 00)
        let strSec = String(format: "%02d", difference.second ?? 00)
        
        return "\(strOre):\(strMin):\(strSec)"
    }
}
