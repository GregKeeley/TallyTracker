//
//  MainMenuMessageView.swift
//  TallyTracker
//
//  Created by Gregory Keeley on 5/3/23.
//

import SwiftUI

struct MainMenuMessageView: View {
    var body: some View {
        GeometryReader { geo in
            ZStack {
                AppColors.primaryLightGreen
                    .cornerRadius(27.0)
                Text("Start Tallying Your Way To Victory!")
                    .font(.custom(AppFonts.poppinsSemiBold, size: 40))
                    .minimumScaleFactor(0.4)
                    .frame(width: geo.size.width * 0.88, height: geo.size.height * 0.85, alignment: .leading)
                RoundedRectangle(cornerRadius: 27.0)
                    .stroke(lineWidth: 4)
            }
        }
    }
}



//MARK: - Previews
struct MainMenuMessageView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuMessageView()
            .frame(width: 327, height: 214)
    }
}
