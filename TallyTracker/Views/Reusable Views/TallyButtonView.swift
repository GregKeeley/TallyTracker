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
                        //                        ZStack {
                        //                            Text(viewModel.playerName)
                        //                                .font(.system(size: 32, weight: .regular))
                        //                                .frame(maxWidth: geo.size.width / 2)
                        //                                .background(viewModel.color.opacity(0.8).colorInvert())
                        //                                .colorInvert()
                        //                                .padding()
                        //                        }
                        Spacer()
                    }
                    Spacer()
                }
                RoundedRectangle(cornerRadius: 8)
                    .stroke(lineWidth: 2)
                    .padding(8)
                    .foregroundColor(viewModel.color.opacity(0.8))
                
                VStack {
                    Text(viewModel.playerScore.description)
                        .font(.system(size: 148, weight: .bold))
                        .minimumScaleFactor(0.5)
                        .foregroundColor(viewModel.color.opacity(0.8))
                    Text(viewModel.playerName.prefix(12))
                            .font(.system(size: 32, weight: .regular))
                            .lineLimit(1)
                            .minimumScaleFactor(0.4)
                            .frame(maxWidth: geo.size.width / 3.14)
                            .background(viewModel.color.opacity(0.8).colorInvert())
                            .colorInvert()
                }
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
    static let viewModel1 = TallyButtonViewModel(color: .red, playerName: "1234567890123456789", playerScore: 5, isPlayerOne: true)
    static let viewModel2 = TallyButtonViewModel(color: .red, playerName: "Greg", playerScore: 5, isPlayerOne: false)
    static var previews: some View {
        TallyButtonView(viewModel: viewModel1)
            .frame(width: 400, height: 400)
            .previewLayout(.sizeThatFits)
        TallyButtonView(viewModel: viewModel2)
            .frame(width: 400, height: 400)
            .previewLayout(.sizeThatFits)
    }
}
