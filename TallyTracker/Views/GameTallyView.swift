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
        ZStack {
            if heightSizeClass == .regular {
                VStack {
                    TallyButtonView(gameVM: viewModel,
                                    teamColor: viewModel.team1Color,
                                    teamName: viewModel.team1Name,
                                    teamScore: $viewModel.team1Score,
                                    isTeamOne: true,
                                    serveLimit: viewModel.serveLimit,
                                    serveCount:  $viewModel.serveCount,
                                    isPlayer1Serving: $viewModel.isTeam1Serving,
                                    teamWins: $viewModel.teamWins,
                                    gameOver: $viewModel.gameOver)
                    .disabled(viewModel.gameOver)
                    HStack {
                        ForEach(0..<viewModel.matchLimit, id:\.self) { index in
                            if viewModel.teamWins[index] == viewModel.team1Color {
                                Circle()
                                    .frame(width: 20)
                                    .foregroundColor(viewModel.team1Color)
                            } else if viewModel.teamWins[index] == viewModel.team2Color {
                                Circle()
                                    .frame(width: 20)
                                    .foregroundColor(viewModel.team2Color)
                            } else {
                                Circle()
                                    .stroke()
                                    .frame(width: 20)
                                    .foregroundColor(.gray)
                            }
                            
                        }
                    }
                    TallyButtonView(gameVM: viewModel,
                                    teamColor: viewModel.team2Color,
                                    teamName: viewModel.team2Name,
                                    teamScore: $viewModel.team2Score,
                                    isTeamOne: false,
                                    serveLimit: viewModel.serveLimit,
                                    serveCount:  $viewModel.serveCount,
                                    isPlayer1Serving: $viewModel.isTeam1Serving,
                                    teamWins: $viewModel.teamWins,
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
                    if viewModel.automaticallySwitchSides && viewModel.hasSwitchedSides {
                        TallyButtonView(gameVM: viewModel,
                                        teamColor: viewModel.team1Color,
                                        teamName: viewModel.team1Name,
                                        teamScore: $viewModel.team1Score,
                                        isTeamOne: true,
                                        serveLimit: viewModel.serveLimit,
                                        serveCount:  $viewModel.serveCount,
                                        isPlayer1Serving: $viewModel.isTeam1Serving,
                                        teamWins: $viewModel.teamWins,
                                        gameOver: $viewModel.gameOver)
                        .disabled(viewModel.gameOver)
                        VStack {
                            ForEach(0..<viewModel.matchLimit, id:\.self) { index in
                                if viewModel.teamWins[index] == viewModel.team1Color {
                                    Circle()
                                        .frame(width: 20)
                                        .foregroundColor(viewModel.team1Color)
                                } else if viewModel.teamWins[index] == viewModel.team2Color {
                                    Circle()
                                        .frame(width: 20)
                                        .foregroundColor(viewModel.team2Color)
                                } else {
                                    Circle()
                                        .stroke()
                                        .frame(width: 20)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                        TallyButtonView(gameVM: viewModel,
                                        teamColor: viewModel.team2Color,
                                        teamName: viewModel.team2Name,
                                        teamScore: $viewModel.team2Score,
                                        isTeamOne: false,
                                        serveLimit: viewModel.serveLimit,
                                        serveCount:  $viewModel.serveCount,
                                        isPlayer1Serving: $viewModel.isTeam1Serving,
                                        teamWins: $viewModel.teamWins,
                                        gameOver: $viewModel.gameOver)
                        .disabled(viewModel.gameOver)
                    } else {
                        TallyButtonView(gameVM: viewModel,
                                        teamColor: viewModel.team2Color,
                                        teamName: viewModel.team2Name,
                                        teamScore: $viewModel.team2Score,
                                        isTeamOne: false,
                                        serveLimit: viewModel.serveLimit,
                                        serveCount:  $viewModel.serveCount,
                                        isPlayer1Serving: $viewModel.isTeam1Serving,
                                        teamWins: $viewModel.teamWins,
                                        gameOver: $viewModel.gameOver)
                        .disabled(viewModel.gameOver)
                        VStack {
                            ForEach(0..<viewModel.matchLimit, id:\.self) { index in
                                if viewModel.teamWins[index] == viewModel.team1Color {
                                    Circle()
                                        .frame(width: 20)
                                        .foregroundColor(viewModel.team1Color)
                                } else if viewModel.teamWins[index] == viewModel.team2Color {
                                    Circle()
                                        .frame(width: 20)
                                        .foregroundColor(viewModel.team2Color)
                                } else {
                                    Circle()
                                        .stroke()
                                        .frame(width: 20)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                        TallyButtonView(gameVM: viewModel,
                                        teamColor: viewModel.team1Color,
                                        teamName: viewModel.team1Name,
                                        teamScore: $viewModel.team1Score,
                                        isTeamOne: true,
                                        serveLimit: viewModel.serveLimit,
                                        serveCount:  $viewModel.serveCount,
                                        isPlayer1Serving: $viewModel.isTeam1Serving,
                                        teamWins: $viewModel.teamWins,
                                        gameOver: $viewModel.gameOver)
                        .disabled(viewModel.gameOver)
                    }
                }
                .padding()
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
                                      scoreLimit: 11,
                                      team1Color: .red,
                                      team2Color: .blue,
                                      isTeam1Serving: true,
                                      matchLimit: 1,
                                      automaticallySwitchSides: true,
                                      team1Name: "Greg",
                                      team2Name: "Terry")
        viewModel.teamWins = Array(repeating: .gray, count: viewModel.matchLimit)
        //        viewModel.gameOver = true
        return viewModel
    }
    
    static var previews: some View {
        GameTallyView(viewModel: viewModel)
    }
}
