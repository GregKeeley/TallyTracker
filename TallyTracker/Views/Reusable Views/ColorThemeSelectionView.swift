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
    var cornerRadius: CGFloat = 8
    var body: some View {
        GeometryReader{ geo in
            ZStack {
                // Bottom Corner
                ColorSelectionShape()
                    .fill(.red)
                    .cornerRadius(cornerRadius)
                // Top Corner
                ColorSelectionShape()
                    .fill(.green)
                    .rotationEffect(Angle(degrees: 180))
                    .cornerRadius(cornerRadius)
                // Top corner edge
                ColorSelectionShape()
                    .stroke(lineWidth: 8)
                    .fill(.black)
                    .rotationEffect(Angle(degrees: 180))
                    .cornerRadius(cornerRadius)
                // Bottom corner edge
                ColorSelectionShape()
                    .stroke(lineWidth: 8)
                    .fill(.black)
                    .cornerRadius(cornerRadius)
                // Diagonal through line.
                Rectangle()
                    .frame(width: geo.size.width * 0.05, height: geo.size.height * 3)
                    .rotationEffect(Angle(degrees: 45))
                    .position(x: geo.size.width)
                    .cornerRadius(cornerRadius)
            }
            VStack {
                HStack {
                    Text("1")
                        .font(Font.custom(AppFonts.poppinsSemiBold, size: 20))
                        .frame(width: geo.size.width / 2, height: geo.size.height / 2)
                    Spacer()
                }
                HStack {
                    Spacer()
                    Text("2")
                        .font(Font.custom(AppFonts.poppinsSemiBold, size: 20))
                        .frame(width: geo.size.width / 2, height: geo.size.height / 2)
                }
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
