//
//  ColorThemeSelectionView.swift
//  TallyTracker
//
//  Created by Gregory Keeley on 4/27/23.
//

struct ColorSelectionShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        
        return path
    }
}
import SwiftUI

struct ColorThemeSelectionView: View {
    var body: some View {
        ZStack {
            GeometryReader{ geo in
                ColorSelectionShape()
                    .fill(.red)
                    .cornerRadius(4)
                ColorSelectionShape()
                    .fill(.green)
                    .rotationEffect(Angle(degrees: 180))
                    .cornerRadius(4)
                ColorSelectionShape()
                    .stroke(lineWidth: 8)
                    .fill(.black)
                    .rotationEffect(Angle(degrees: 180))
                    .cornerRadius(4)
                ColorSelectionShape()
                    .stroke(lineWidth: 8)
                    .fill(.black)
                    .cornerRadius(4)
//                Rectangle()
//                    .stroke(lineWidth: 8)
//                    .cornerRadius(4)
//                Rectangle()
//                    .frame(width: geo.size.width * 0.05, height: geo.size.height * 3)
//                    .rotationEffect(Angle(degrees: 45))
            }
        }
    }
}



//MARK: - Previews
struct ColorThemeSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        ColorThemeSelectionView()
            .previewLayout(.sizeThatFits)
            .frame(width: 80, height: 80)
    }
}
