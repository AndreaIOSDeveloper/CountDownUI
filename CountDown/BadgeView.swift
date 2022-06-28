//
//  BadgeView.swift
//  CountDown
//
//  Created by Di Francia, Andrea (Contractor) on 28/06/22.
//

import Foundation
import SwiftUI

struct Badge: View {
    let count: Int

    var body: some View {
        ZStack(alignment: .topTrailing) {
            Color.clear
            if count > 0 {
                Text(String(count))
                    .font(.system(size: 16))
                    .padding(5)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .clipShape(Circle())
                // custom positioning in the top-right corner
                    .alignmentGuide(.top) { $0[.bottom] }
                    .alignmentGuide(.trailing) { $0[.trailing] - $0.width * 0.25 }
            }
        }
    }
}
