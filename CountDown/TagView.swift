//
//  TagView.swift
//  CountDown
//
//  Created by Di Francia, Andrea (Contractor) on 26/06/22.
//

import Foundation
import SwiftUI

struct TagView: View {
    var title: String
    var colorTag: Color
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(.white)
                .frame(width: 50, height: 30)
            Text(title)
                .foregroundColor(colorTag)
                .font(.system(size: 13))
                .bold()
        }
    }
}

struct TagView_Previews: PreviewProvider {
    static var previews: some View {
        TagView(title: "Prova", colorTag: .red)
    }
}
