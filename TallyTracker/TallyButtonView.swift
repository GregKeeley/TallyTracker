//
//  TallyButtonView.swift
//  TallyTracker
//
//  Created by Gregory Keeley on 2/13/23.
//

import SwiftUI

struct TallyButtonView: View {
    @State var playerScore: Int
    @State private var orientation = UIDevice.current.orientation
    @State var color: Color
    @State var playerName: String
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                VStack {
                    
                    HStack {
                        ZStack {
//                            RoundedRectangle(cornerRadius: 8)
//                                .foregroundColor(color.opacity(0.8))
//                                .frame(height: 48)
//                            Text(playerName)
//                                .font(.system(size: 32, weight: .regular))
//                                .frame(maxWidth: .infinity)
//                                .background(color.opacity(0.8).colorInvert())
//                                .colorInvert()
//                                .padding()
                        }
                        Spacer()
                    }
                    Spacer()
                }
                RoundedRectangle(cornerRadius: 8)
                    .stroke()
                    .foregroundColor(color.opacity(0.8))
                Text(playerScore.description)
                    .font(.system(size: 148, weight: .bold))
                    .minimumScaleFactor(0.5)
                    .foregroundColor(color.opacity(0.8))
                
            }
            .rotationEffect(orientation == .portrait ? .degrees(0) : (UIDevice.current.orientation.rawValue == 3 ? .degrees(90) : .degrees(-90)))
            .contentShape(RoundedRectangle(cornerRadius: 8))
            .onTapGesture {
                playerScore += 1
            }
            .onLongPressGesture(minimumDuration: 1.0, perform: {
                playerScore -= 1
            })
            .onRotate($orientation)
        }
    }
}



struct TallyButton_Previews: PreviewProvider {
    static var previews: some View {
        TallyButtonView(playerScore: 5, color: .green, playerName: "Gregory")
            .frame(width: 400, height: 400)
            .previewLayout(.sizeThatFits)
            .rotationEffect(.degrees(90))
    }
}
