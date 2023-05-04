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
    var cornerRadius: CGFloat = 25
    var body: some View {
        GeometryReader{ geo in
            ZStack {
                // Bottom Corner
                ColorSelectionShape()
                    .fill(AppColors.secondaryRed)
                    .cornerRadius(cornerRadius)
                // Top Corner
                ColorSelectionShape()
                    .fill(AppColors.secondaryBlue)
                    .rotationEffect(Angle(degrees: 180))
                    .cornerRadius(cornerRadius)
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(lineWidth: geo.size.width * 0.07)
//                    .frame(width: geo.size.width * 0.97, height: geo.size.width * 0.97)
                // Diagonal through line.
                Rectangle()
                    .frame(width: geo.size.width * 0.07, height: geo.size.width * 3)
                    .rotationEffect(Angle(degrees: 45))
                    .position(x: geo.size.width)
                    .cornerRadius(cornerRadius)
            }
            VStack {
                HStack {
                    Text("1")
                        .font(Font.custom(AppFonts.poppinsMedium, size: 148))
                        .minimumScaleFactor(0.2)
                        .frame(width: geo.size.width / 2, height: geo.size.height / 2)
                        .offset(x: (geo.size.width / 16), y: (geo.size.width / 16))
                    Spacer()
                }
                HStack {
                    Spacer(minLength: geo.size.width * 0.6)
                    Text("2")
                        .font(Font.custom(AppFonts.poppinsMedium, size: 36))
                        .minimumScaleFactor(0.7)
                        .frame(height: geo.size.height / 3)
                    Spacer()
                }
                .frame(width: geo.size.width, height: geo.size.height / 4)
            }
        }
    }
}



//MARK: - Previews
struct ColorThemeSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        ColorThemeSelectionView()
            .previewLayout(.sizeThatFits)
            .aspectRatio(contentMode: .fit)
            .frame(width: 80, height: 80)
    }
}
