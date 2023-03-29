//
//  OffsetCircleView.swift
//  TallyTracker
//
//  Created by Gregory Keeley on 3/25/23.
//

import SwiftUI

struct OffsetCircleView: View {
    /// Color used in the foreground of the overlay circle.
    @Binding var color: Color
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Circle()
                    .offset(x: geo.size.width * 0.01, y: geo.size.width * 0.01)
                Circle()
                    .frame(width: geo.size.width * 0.9, height: geo.size.height * 0.9)
                    .foregroundColor(color)
            }
        }
    }
    
}



//MARK: - Previews
struct OffsetCircleView_Previews: PreviewProvider {
    static let color: Color = .white
    static var previews: some View {
        OffsetCircleView(color: .constant(color))
            .frame(width: 24, height: 24)
            .previewLayout(.sizeThatFits)
    }
}
