//
//  GaugeProgressStyle.swift
//  CountDown
//
//  Created by Di Francia, Andrea (Contractor) on 06/07/22.
//

import SwiftUI

struct GaugeProgressStyle: ProgressViewStyle {
    var strokeColor = Color.primary
    var strokeWidth = 12.0

    func makeBody(configuration: Configuration) -> some View {
        let fractionCompleted = configuration.fractionCompleted ?? 0

        return ZStack {
            Circle()
                .trim(from: 0, to: fractionCompleted)
                .stroke(strokeColor, style: StrokeStyle(lineWidth: strokeWidth, lineCap: .round))
                .rotationEffect(.degrees(-90))
                .padding(-6)
            Text("Loading...")
                .foregroundColor(Color.primary)
                
        }
    }
}
