//
//  TallyViewLandscape.swift
//  TallyTracker
//
//  Created by Gregory Keeley on 2/12/23.
//

import SwiftUI

struct TallyViewLandscape: View {
    @State var player1Score: Int
    @State var player2Score: Int
    
    var body: some View {
        HStack {
            Spacer()
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .stroke()
                    .foregroundColor(.red.opacity(0.8))
                Text(player1Score.description)
                    .font(.system(size: 148, weight: .bold))
                    .minimumScaleFactor(0.5)
                    .foregroundColor(.red.opacity(0.8))
            }
            .onTapGesture {
                player1Score += 1
            }
            .frame(width: UIScreen.main.bounds.height * 0.9, height: UIScreen.main.bounds.height * 0.9)
            Spacer()
            Divider()
            Spacer()
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .stroke()
                    .foregroundColor(.blue.opacity(0.8))
                Text(player2Score.description)
                    .font(.system(size: 148, weight: .bold))
                    .minimumScaleFactor(0.5)
                    .foregroundColor(.blue.opacity(0.8))
            }
            .onTapGesture {
                player2Score += 1
            }
            .frame(width: UIScreen.main.bounds.height * 0.9, height: UIScreen.main.bounds.height * 0.9)
            Spacer()
        }
        .padding()
    }
}

struct TallyViewLandscape_Previews: PreviewProvider {
    static var previews: some View {
        TallyViewLandscape(player1Score: 5, player2Score: 7)
    }
}
