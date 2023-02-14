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
                    Spacer()
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
