//
//  MainMenuGameButtonView.swift
//  TallyTracker
//
//  Created by Gregory Keeley on 2/14/23.
//

import SwiftUI

struct MainMenuGameButtonView: View {
    
    @State var gameTitle: String
    @State var message: String
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .stroke()
            HStack {
                VStack(alignment: .leading) {
                    Text(gameTitle)
                        .font(.system(size: 32, weight: .bold))
                        .minimumScaleFactor(0.4)
                    Text(message)
                        .font(.system(size: 24, weight: .regular))
                        .minimumScaleFactor(0.4)
                }
                .padding()
                Image(systemName: "x.circle")
                    .resizable()
                    .padding(40)
                    .aspectRatio(contentMode: .fit)
            }
        }
        
    }
}



struct MainMenuGameButtonView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuGameButtonView(gameTitle: "Official Rules", message: "Play to 11. Win by 2. Best of 5.")
            .previewLayout(.sizeThatFits)
    }
}
