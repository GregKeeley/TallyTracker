//
//  MainMenuView.swift
//  TallyTracker
//
//  Created by Gregory Keeley on 2/14/23.
//

import SwiftUI

struct MainMenuView: View {
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Spacer()
                    Image(systemName: "gear")
                        .resizable()
                        .frame(width: 28, height: 28)
                    .padding(.trailing)
                }
                HStack {
                    Spacer()
                    Text("Logo")
                        .font(.system(size: 48, weight: .bold))
                        .frame(maxWidth: UIScreen.main.bounds.size.width * 0.33)
                        .background(.white)
                        .ignoresSafeArea()
                        .colorInvert()
                    Spacer()
                }
                Spacer()
                HStack {
                    VStack {
                        MainMenuGameButtonView(gameTitle: "Official Rules", message: "Play to 11. Win by 2. Best of 5.")
                        Spacer(minLength: 40)
                        MainMenuGameButtonView(gameTitle: "House Rules", message: "Custom game.")
                    }
                    .frame(width: UIScreen.main.bounds.size.width * 0.8, height: UIScreen.main.bounds.size.height * 0.3)
                }
                Spacer()
            }
        }
    }
}

struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView()
    }
}
