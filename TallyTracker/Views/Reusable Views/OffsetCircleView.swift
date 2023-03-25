//
//  OffsetCircleView.swift
//  TallyTracker
//
//  Created by Gregory Keeley on 3/25/23.
//

import SwiftUI

struct OffsetCircleView: View {
    @State var color: Color
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Circle()
//                    .frame(width: geo.size.width * 0.55)
                Circle()
                    .foregroundColor(color)
                    .frame(width: geo.size.width * 0.9)
                    .offset(x: -geo.size.width * 0.01, y: -geo.size.width * 0.01)
            }
        }
    }
}

struct OffsetCircleView_Previews: PreviewProvider {
    static var previews: some View {
        OffsetCircleView(color: .white)
    }
}
