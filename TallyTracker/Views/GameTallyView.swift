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
                                        isFirstTeam: true,
                                        serveLimit: viewModel.serveLimit,
                                        serveCount:  $viewModel.serveCount,
                                        isfirstTeamServing: $viewModel.isFirstTeamServing)
                        .disabled(viewModel.gameOver)
                        HStack {
                            //                            Image(systemName: "line.3.horizontal.circle")
                            Image(systemName: "arrow.backward.circle")
                                .resizable()
                                .frame(width: 28, height: 28)
                                .onTapGesture {
                                    presentationMode.wrappedValue.dismiss()
                                }
                            Spacer()
                            ForEach(0..<viewModel.matchLimit, id:\.self) { index in
                                if viewModel.totalTeamWinColors[index] == viewModel.firstTeamColor {
                                    ZStack {
                                        Circle()
                                            .frame(width: 28)
                                        Circle()
                                            .frame(width: 24)
                                            .foregroundColor(viewModel.firstTeamColor)
                                            .offset(x: -0.5, y: -0.5)
                                    }
                                } else if viewModel.totalTeamWinColors[index] == viewModel.secondTeamColor {
                                    ZStack {
                                        Circle()
                                            .frame(width: 28)
                                        Circle()
                                            .frame(width: 24)
                                            .foregroundColor(viewModel.secondTeamColor)
                                            .offset(x: -0.5, y: -0.5)
                                    }
                                } else {
                                    ZStack {
                                        Circle()
                                            .frame(width: 28)
                                        Circle()
                                            .frame(width: 24)
                                            .foregroundColor(colorScheme == .dark ? .black : .white)
                                            .offset(x: -0.5, y: -0.5)
                                    }
                                }
                                
                            }
                            Spacer()
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
                    .padding()
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
                            .offset(x: viewModel.teamsSwitchedSides ?  (geo.size.width) / 2 : 0, y: 0)
                            .rotation3DEffect(.degrees(viewModel.teamsSwitchedSides ? 360: 0), axis: viewModel.teamsSwitchedSides ? (x: 100, y: 100, z: 100) :(x: 0, y: 0, z: 0))
                            .animation(Animation.easeOut(duration: 0.5), value: viewModel.teamsSwitchedSides)
                            .disabled(viewModel.gameOver)
                            VStack {
                                //                                Image(systemName: "line.3.horizontal.circle")
                                Image(systemName: "arrow.backward.circle")
                                    .resizable()
                                    .frame(width: 28, height: 28)
                                    .onTapGesture {
                                        presentationMode.wrappedValue.dismiss()
                                    }
                                Spacer()
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
                            .offset(x: viewModel.teamsSwitchedSides ?  (-geo.size.width / 2) : 0, y: 0)
                            .rotation3DEffect(.degrees(viewModel.teamsSwitchedSides ? 360 : 0), axis: viewModel.teamsSwitchedSides ? (x: 100, y: 100, z: 100) :(x: 0, y: 0, z: 0))
                            .animation(Animation.easeOut(duration: 0.5), value: viewModel.teamsSwitchedSides)
                            .disabled(viewModel.gameOver)
                        }
                        .padding()
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
        viewModel.gameOver = false
        viewModel.totalTeamWinColors = [.red, .blue, .gray, .gray, .gray]
        return viewModel
    }
    
    static var previews: some View {
        GameTallyView(viewModel: viewModel)
    }
}
