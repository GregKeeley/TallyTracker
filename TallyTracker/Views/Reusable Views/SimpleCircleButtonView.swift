//
//  SimpleCircleButtonView.swift
//  TallyTracker
//
//  Created by Gregory Keeley on 4/26/23.
//

import SwiftUI

struct SimpleCircleButtonView: View {
    @State var imageName: String
    @State var color: Color
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Circle()
                    .foregroundColor(color)
//                    .frame(width: geo.size.height, height: geo.size.height)
                Image(systemName: imageName)
                    .resizable()
//                    .clipShape(Circle())
//                    .frame(width: geo.size.height * 1.05, height: geo.size.height * 1.05)
            }
        }
    }
}



//MARK: - Previews
struct SimpleCircleButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SimpleCircleButtonView(imageName: "minus.circle", color: AppColors.neutralGray1)
            .frame(width: 40, height: 40)
            .previewLayout(.sizeThatFits)
    }
}
