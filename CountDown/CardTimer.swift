//
//  CardTimer.swift
//  CountDown
//
//  Created by Andrea Di Francia on 15/06/22.
//

import Foundation
import SwiftUI

struct TimeCard {
    var years: Int
    var months: Int
    var days: Int
    var hours: Int
    var mins: Int
    var secs: Int
    
    init(years: Int, months: Int, days: Int, hours: Int, mins: Int, secs: Int) {
        self.years = years
        self.months = months
        self.days = days
        self.hours = hours
        self.mins = mins
        self.secs = secs
    }
}

struct CardTimer: View {
    private var title: String?
    private var subTitle: String?
    private var colorCard: Color = .red
    private var time: TimeCard = TimeCard(years: 0, months: 0, days: 0, hours: 0, mins: 0, secs: 0)
    @State private var isSelected: Bool = false
    @State private var imageName: String = "star"

    init(object: CountDownObject) {
        self.title = object.title
        self.subTitle = object.subTitle
        self.colorCard = object.colorCard
        self.time = object.timer ?? TimeCard(years: 0, months: 0, days: 0, hours: 0, mins: 0, secs: 0)
    }
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    self.isSelected.toggle()
                    self.imageName = isSelected ? "star.fill" : "star"
                }) {
                    Image(systemName: imageName)
                        .foregroundColor(.white)
                }
            }
            Text(title ?? "Title")
                .foregroundColor(Color.white)
                .bold()
                .padding(.bottom, 4.0)
            
            Text(subTitle ?? "SubTitle")
                .padding(.bottom, 16.0)
                .foregroundColor(Color.white)
            HStack {
                VStack {
                    Text(time.days.description)
                        .bold()
                        .foregroundColor(Color.white)
                    Text("Days")
                        .foregroundColor(Color.white)
                }
                .padding(.trailing)
                
                VStack {
                    Text(time.hours.description)
                        .bold()
                        .foregroundColor(Color.white)
                    Text("Hours")
                        .foregroundColor(Color.white)
                }
                .padding(.trailing)
                
                VStack {
                    Text(time.mins.description)
                        .bold()
                        .foregroundColor(Color.white)
                    Text("Mins")
                        .foregroundColor(Color.white)
                }
                .padding(.trailing)
                
                VStack {
                    Text(time.secs.description)
                        .bold()
                        .foregroundColor(Color.white)
                    Text("Secs")
                        .foregroundColor(Color.white)
                }
            }
        }
        .padding()
        .background(colorCard)
    }
}

struct CardTimer_Previews: PreviewProvider {
    static var previews: some View {
        CardTimer(object: CountDownObject(id: "0", title: "Test", subTitle: "Test", colorCard: .red, isConfirmed: false, futureDate: Calendar.current.date(from: DateComponents(year: 2022, month: 11, day: 27, hour: 0, minute: 0, second: 0))!) )
    }
}
