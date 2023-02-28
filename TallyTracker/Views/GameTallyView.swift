//
//  ContentView.swift
//  TallyTracker
//
//  Created by Gregory Keeley on 2/11/23.
//

import SwiftUI

struct GameTallyView: View {
    /// Used to dismiss this view.
    @Environment(\.presentationMode) private var presentationMode
    /// View model for the UI.
    @StateObject var viewModel: GameViewModel
    /// Height size class, used to determine available horizontal space available and handle layout on the device.
    @Environment(\.verticalSizeClass) var heightSizeClass: UserInterfaceSizeClass?
    /// Width size class, used to determine available vertical space available and handle layout on the device.
    @Environment(\.horizontalSizeClass) var widthSizeClass: UserInterfaceSizeClass?
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                if heightSizeClass == .regular && widthSizeClass == .compact {
                    VStack {
                        TallyButtonView(gameVM: viewModel,
                                        teamColor: viewModel.firstTeamColor,
                                        teamName: viewModel.firstTeamName,
                                        teamScore: $viewModel.firstTeamScore,
                                        isTeamOne: true,
                                        serveLimit: viewModel.serveLimit,
                                        serveCount:  $viewModel.serveCount,
                                        isPlayer1Serving: $viewModel.isFirstTeamServing,
                                        teamWins: $viewModel.totalTeamWinColors,
                                        gameOver: $viewModel.gameOver)
                        .disabled(viewModel.gameOver)
                        HStack {
                            ForEach(0..<viewModel.matchLimit, id:\.self) { index in
                                if viewModel.totalTeamWinColors[index] == viewModel.firstTeamColor {
                                    Circle()
                                        .frame(width: 20)
                                        .foregroundColor(viewModel.firstTeamColor)
                                } else if viewModel.totalTeamWinColors[index] == viewModel.secondTeamColor {
                                    Circle()
                                        .frame(width: 20)
                                        .foregroundColor(viewModel.secondTeamColor)
                                } else {
                                    Circle()
                                        .stroke()
                                        .frame(width: 20)
                                        .foregroundColor(.gray)
                                }
                                
                            }
                        }
                        TallyButtonView(gameVM: viewModel,
                                        teamColor: viewModel.secondTeamColor,
                                        teamName: viewModel.secondTeamName,
                                        teamScore: $viewModel.secondTeamScore,
                                        isTeamOne: false,
                                        serveLimit: viewModel.serveLimit,
                                        serveCount:  $viewModel.serveCount,
                                        isPlayer1Serving: $viewModel.isFirstTeamServing,
                                        teamWins: $viewModel.totalTeamWinColors,
                                        gameOver: $viewModel.gameOver)
                        .disabled(viewModel.gameOver)
                    }
                    .alert(isPresented: $viewModel.matchComplete, content: {
                        let primaryButton = Alert.Button.default(Text("Yes")) {
                            // Switch player sides on view, reset matchComplete variable.
                            // SWITCH HERE, How?
                            viewModel.startNewMatch()
                        }
                        let secondaryButton = Alert.Button.default(Text("No")) {
                            viewModel.startNewMatch()
                        }
                        return Alert(title: Text("Switch Sides?"), primaryButton: primaryButton, secondaryButton: secondaryButton)
                    })
                    .padding()
                } else {
                    HStack {
                        TallyButtonView(gameVM: viewModel,
                                        teamColor: viewModel.secondTeamColor,
                                        teamName: viewModel.secondTeamName,
                                        teamScore: $viewModel.secondTeamScore,
                                        isTeamOne: false,
                                        serveLimit: viewModel.serveLimit,
                                        serveCount:  $viewModel.serveCount,
                                        isPlayer1Serving: $viewModel.isFirstTeamServing,
                                        teamWins: $viewModel.totalTeamWinColors,
                                        gameOver: $viewModel.gameOver)
                        .offset(x: viewModel.teamsSwitchedSides ?  (geo.size.width) / 2 : 0, y: 0)
                        .animation(Animation.easeOut(duration: 0.5), value: viewModel.teamsSwitchedSides)
                        .disabled(viewModel.gameOver)
                        VStack {
                            ForEach(0..<viewModel.matchLimit, id:\.self) { index in
                                if viewModel.totalTeamWinColors[index] == viewModel.firstTeamColor {
                                    Circle()
                                        .frame(width: 20)
                                        .foregroundColor(viewModel.firstTeamColor)
                                } else if viewModel.totalTeamWinColors[index] == viewModel.secondTeamColor {
                                    Circle()
                                        .frame(width: 20)
                                        .foregroundColor(viewModel.secondTeamColor)
                                } else {
                                    Circle()
                                        .stroke()
                                        .frame(width: 20)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                        TallyButtonView(gameVM: viewModel,
                                        teamColor: viewModel.firstTeamColor,
                                        teamName: viewModel.firstTeamName,
                                        teamScore: $viewModel.firstTeamScore,
                                        isTeamOne: true,
                                        serveLimit: viewModel.serveLimit,
                                        serveCount:  $viewModel.serveCount,
                                        isPlayer1Serving: $viewModel.isFirstTeamServing,
                                        teamWins: $viewModel.totalTeamWinColors,
                                        gameOver: $viewModel.gameOver)
                        .offset(x: viewModel.teamsSwitchedSides ?  (-geo.size.width / 2) : 0, y: 0)
                        .animation(Animation.easeOut(duration: 0.5), value: viewModel.teamsSwitchedSides)
                        .disabled(viewModel.gameOver)
                    }
                    .padding()
                }
            }
        }
        // Game Over alert.
        .alert(isPresented: $viewModel.gameOver, content: {
            let primaryButton = Alert.Button.default(Text("Confirm")) {
                viewModel.resetGame()
            }
            let secondaryButton = Alert.Button.cancel(Text("No")) {
                // dismiss view here.
                viewModel.resetGame()
                presentationMode.wrappedValue.dismiss()
            }
            return Alert(title: Text("Play Again?"), primaryButton: primaryButton, secondaryButton: secondaryButton)
        })
        .navigationBarBackButtonHidden()
    }
    
}



//MARK: - Previews
struct ContentView_Previews: PreviewProvider {
    
    static var viewModel:GameViewModel {
        let viewModel = GameViewModel(serveLimit: 5,
                                      scoreLimit: 15,
                                      firstTeamColor: .red,
                                      secondTeamColor: .blue,
                                      firstTeamName: "Greg",
                                      secondTeamName: "Terry",
                                      firstTeamIsServing: true,
                                      matchLimit: 5,
                                      teamsAutomaticallySwitchSides: true)
        viewModel.totalTeamWinColors = Array(repeating: .gray, count: viewModel.matchLimit)
        //        viewModel.gameOver = true
        return viewModel
    }
    
    static var previews: some View {
        GameTallyView(viewModel: viewModel)
    }
}
