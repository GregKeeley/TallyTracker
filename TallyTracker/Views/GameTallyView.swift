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
    /// Used to determine the color scheme of the users device for layout/color purposes.
    @Environment(\.colorScheme) var colorScheme
    /// View model for the UI.
    @ObservedObject var viewModel: GameViewModel
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
                                        isFirstTeam: true,
                                        serveLimit: viewModel.serveLimit,
                                        serveCount:  $viewModel.serveCount,
                                        isfirstTeamServing: $viewModel.isFirstTeamServing)
                        .disabled(viewModel.gameOver)
                        ZStack {
                            HStack {
                                //                            Image(systemName: "line.3.horizontal.circle")
                                Image(systemName: "x.circle")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: geo.size.width * 0.075, height: geo.size.width * 0.075)
                                    .padding(.leading)
                                    .onTapGesture {
                                        viewModel.presentAlert.toggle()
                                    }
                                Spacer()
                            }
                            HStack {
                                Spacer()
                                MatchWinsCounterView(gameVM: viewModel, teamWinColors: $viewModel.totalTeamWinColors)
                                    .frame(width: geo.size.width * 0.6, height: geo.size.height * 0.05)
                                Spacer()
                            }
                        }
                        TallyButtonView(gameVM: viewModel,
                                        teamColor: viewModel.secondTeamColor,
                                        teamName: viewModel.secondTeamName,
                                        teamScore: $viewModel.secondTeamScore,
                                        isFirstTeam: false,
                                        serveLimit: viewModel.serveLimit,
                                        serveCount:  $viewModel.serveCount,
                                        isfirstTeamServing: $viewModel.isFirstTeamServing)
                        .disabled(viewModel.gameOver)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                    if viewModel.gameOver {
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 20, height: 20)
                            .modifier(ParticlesModifier())
                        Circle()
                            .fill(Color.red)
                            .frame(width: 12, height: 12)
                            .modifier(ParticlesModifier())
                    }
                } else {
                    ZStack {
                        HStack {
                            TallyButtonView(gameVM: viewModel,
                                            teamColor: viewModel.secondTeamColor,
                                            teamName: viewModel.secondTeamName,
                                            teamScore: $viewModel.secondTeamScore,
                                            isFirstTeam: false,
                                            serveLimit: viewModel.serveLimit,
                                            serveCount:  $viewModel.serveCount,
                                            isfirstTeamServing: $viewModel.isFirstTeamServing)
                            .offset(x: !viewModel.teamsSwitchedSides ? (geo.size.width) * 0.535 : 0, y: 0)
                            .rotation3DEffect(.degrees(viewModel.teamsSwitchedSides ? 360: 0), axis: viewModel.teamsSwitchedSides ? (x: 100, y: 100, z: 100) :(x: 0, y: 0, z: 0))
                            .animation(Animation.easeOut(duration: 0.5), value: viewModel.teamsSwitchedSides)
                            .disabled(viewModel.gameOver)
                            VStack {
                                //                                Image(systemName: "line.3.horizontal.circle")
                                Image(systemName: "x.circle")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: geo.size.width * 0.025, height: geo.size.width * 0.045)
                                    .padding(.top)
                                    .onTapGesture {
                                        viewModel.presentAlert.toggle()
                                    }
                                Spacer()
                                MatchWinsCounterView(gameVM: viewModel, teamWinColors: $viewModel.totalTeamWinColors)
                                    .frame(width: geo.size.width * 0.05, height: geo.size.height * 0.7)
                                Spacer()
                            }
                            TallyButtonView(gameVM: viewModel,
                                            teamColor: viewModel.firstTeamColor,
                                            teamName: viewModel.firstTeamName,
                                            teamScore: $viewModel.firstTeamScore,
                                            isFirstTeam: true,
                                            serveLimit: viewModel.serveLimit,
                                            serveCount:  $viewModel.serveCount,
                                            isfirstTeamServing: $viewModel.isFirstTeamServing)
                            .offset(x: !viewModel.teamsSwitchedSides ? (-geo.size.width * 0.535) : 0, y: 0)
                            .rotation3DEffect(.degrees(viewModel.teamsSwitchedSides ? 360 : 0), axis: viewModel.teamsSwitchedSides ? (x: 100, y: 100, z: 100) :(x: 0, y: 0, z: 0))
                            .animation(Animation.easeOut(duration: 0.5), value: viewModel.teamsSwitchedSides)
                            .disabled(viewModel.gameOver)
                        }
                        if viewModel.gameOver {
                            Circle()
                                .fill(Color.blue)
                                .frame(width: 20, height: 20)
                                .modifier(ParticlesModifier())
                            Circle()
                                .fill(Color.red)
                                .frame(width: 12, height: 12)
                                .modifier(ParticlesModifier())
                        }
                    }
                }
            }
        }
        .alert(isPresented: $viewModel.presentAlert, content: {
            if viewModel.gameOver {
                let primaryButton = Alert.Button.default(Text("Yes")) {
                    viewModel.resetGame()
                }
                let secondaryButton = Alert.Button.cancel(Text("No")) {
                    // dismiss view here.
                    viewModel.resetGame()
                    presentationMode.wrappedValue.dismiss()
                }
                return Alert(title: Text("Play Again?"), primaryButton: primaryButton, secondaryButton: secondaryButton)
            } else {
                let primaryButton = Alert.Button.default(Text("Yes")) {
                    presentationMode.wrappedValue.dismiss()
                }
                return Alert(title: Text("You are about to exit the game."), message: Text("Are you sure?"), primaryButton: primaryButton, secondaryButton: .cancel())
            }
        })
        .navigationBarBackButtonHidden()
    }
    
}



//MARK: - Previews
struct ContentView_Previews: PreviewProvider {
    
    static var viewModel:GameViewModel {
        let viewModel = GameViewModel(serveLimit: 5,
                                      scoreLimit: 2,
                                      firstTeamColor: .red,
                                      secondTeamColor: .blue,
                                      firstTeamName: "Greg",
                                      secondTeamName: "Terry",
                                      firstTeamIsServing: true,
                                      matchLimit: 5,
                                      teamsAutomaticallySwitchSides: true)
        viewModel.gameOver = false
        viewModel.totalTeamWinColors = [.red, .blue, .red, .white, .white]
        return viewModel
    }
    
    static var previews: some View {
        GameTallyView(viewModel: viewModel)
    }
}
