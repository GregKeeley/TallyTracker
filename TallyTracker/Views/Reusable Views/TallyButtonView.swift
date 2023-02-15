//
//  TallyButtonView.swift
//  TallyTracker
//
//  Created by Gregory Keeley on 2/13/23.
//

import SwiftUI

struct TallyButtonView: View {
    @StateObject var viewModel: TallyButtonViewModel
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                VStack {
                    HStack {
                        ZStack {
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
                    .stroke(lineWidth: 2)
                    .padding(8)
                    .foregroundColor(viewModel.color.opacity(0.8))
                Text(viewModel.playerScore.description)
                    .font(.system(size: 148, weight: .bold))
                    .minimumScaleFactor(0.5)
                    .foregroundColor(viewModel.color.opacity(0.8))
            }
            .contentShape(RoundedRectangle(cornerRadius: 8))
            .onTapGesture {
                viewModel.playerScore += 1
            }
            .onLongPressGesture(minimumDuration: 1.0, perform: {
                viewModel.playerScore -= 1
            })
        }
    }
    
}



struct TallyButton_Previews: PreviewProvider {
    static let viewModel = TallyButtonViewModel(color: .red, playerName: "Greg", playerScore: 5)
    static var previews: some View {
        TallyButtonView(viewModel: viewModel)
            .frame(width: 400, height: 400)
            .previewLayout(.sizeThatFits)
    }
}
