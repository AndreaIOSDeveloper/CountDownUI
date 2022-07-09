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
    @State private var dateComponents: DateComponents?
    @State private var isToggle : Bool = false

    let settings = [
           "Notification",
           "Privacy",
           "Contact us",
           "Credits",
       ]
    
    init() {   }
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Time in community:")
                    .padding()
                    .multilineTextAlignment(.leading)
                    .font(.body)
                    .foregroundColor(.gray)
            HStack {
                VStack {
                    Text(String(format: "%02d", dateComponents?.day ?? 00))
                        .bold()
                        .foregroundColor(Color.primary)
                    Text("Days")
                        .foregroundColor(Color.primary)
                }
                .padding(.trailing)
                
                VStack {
                    Text(String(format: "%02d", dateComponents?.hour ?? 00))
                        .bold()
                        .foregroundColor(Color.primary)
                    Text("Hours")
                        .foregroundColor(Color.primary)
                }
                .padding(.trailing)
                
                VStack {
                    Text(String(format: "%02d", dateComponents?.minute ?? 00))
                        .bold()
                        .foregroundColor(Color.primary)
                    Text("Mins")
                        .foregroundColor(Color.primary)
                }
                .padding(.trailing)
                
                VStack {
                    Text(String(format: "%02d", dateComponents?.second ?? 00))
                        .bold()
                        .foregroundColor(Color.primary)
                    Text("Secs")
                        .foregroundColor(Color.primary)
                }
                
            }
            .onReceive(timer) { _ in
                if self.isTimerRunning {
                    dateComponents = Date().passedTime(from: startTime ?? Date())
                }
            }
            .onAppear() {
                if !isTimerRunning {
                    receiceCurrentDateAppUsed { date in
                        if date == nil {
                            saveCurrentUserDate()
                            startTime = Date()
                        } else {
                            startTime = date ?? Date()
                        }
                    }
                }
                isTimerRunning.toggle()
            }
                
                Spacer()
             
                List(settings, id: \.self) { setting in
                    if setting == "Notification" {
                        Toggle(setting, isOn: $isToggle)
                    } else {
                    
                    NavigationLink(destination: PlayerView(name: setting)) {
                        Text(setting)
                    }
                    }
                }
                .navigationTitle("Profile")
                
                Text("Made with ❤️ from Andrea Di Francia")
                    .padding()
                    .multilineTextAlignment(.center)
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
            
            
        }
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.large)
    }
    
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
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

extension Date {
    func passedTime(from date: Date) -> DateComponents {
        let difference = Calendar.current.dateComponents([.day, .hour, .minute, .second], from: date, to: self)
//        let strDay = String(format: "%02d", difference.day ?? 00)
//        let strOre = String(format: "%02d", difference.hour ?? 00)
//        let strMin = String(format: "%02d", difference.minute ?? 00)
//        let strSec = String(format: "%02d", difference.second ?? 00)
        return difference
//        return "day: \(strDay) Hours:\(strOre):\(strMin):\(strSec)"
    }
}

struct PlayerView: View {
    let name: String

    var body: some View {
        Text("Selected player: \(name)")
            .font(.largeTitle)
    }
}
