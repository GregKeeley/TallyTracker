//
//  SimpleCircleButtonView.swift
//  TallyTracker
//
//  Created by Gregory Keeley on 4/26/23.
//

import SwiftUI

struct SimpleCircleButtonView: View {
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Circle()
                    .foregroundColor(AppColors.neutralGray2)
                    .frame(width: geo.size.height, height: geo.size.height)
                Image(systemName: "minus.circle")
                    .resizable()
                    .clipShape(Circle())
                    .frame(width: 42.5, height: 42.5)
            }
        }
    }
}



//MARK: - Previews
struct SimpleCircleButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SimpleCircleButtonView()
            .previewLayout(.sizeThatFits)
    }
}
