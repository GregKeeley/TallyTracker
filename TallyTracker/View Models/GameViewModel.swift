//
//  GameViewModel.swift
//  TallyTracker
//
//  Created by Gregory Keeley on 2/15/23.
//

import SwiftUI

class GameViewModel: ObservableObject {

    @Environment(\.colorScheme) var colorScheme
    
    /// Tracks the score of player 1.
    @Published var player1Score: Int = 0
    /// Track the score of player 2.
    @Published var player2Score: Int = 0
    /// Store the names for player 1.
    @Published var team1Name: String = ""
    /// Stores the name for player 2.
    @Published var team2Name: String = ""
    /// Store the names for player 1.
    @Published var team1Color: Color
    /// Stores the name for player 2.
    @Published var team2Color: Color
    /// Tracks the current count of the serve. This will increment every time the score of the game
    /// increments until the 'serveLimit' is reached. Once this happens, the serve count will reset to zero and repeat.
    @Published var serveCount: Int = 0
    /// This represents the max amount of serves that occur before the players switch who serves the ball.
    @Published var serveLimit: Int
    /// This represents the score a single player needs to achieve before that player is declared the winner.
    @Published var scoreLimit: Int
    /// Tracks when the end of the has been reached.
    @Published var gameOver: Bool = false
    /// When to set to 'true', the user will start a game with standard rules.
    @Published var navigateToStandardGame: Bool = false
    /// When to set to 'true', the user will be navigated to the custome game view setup view.
    @Published var navigateToCustomGame: Bool = false
    
    init(serveLimit: Int, scoreLimit: Int, player1Color: Color, player2Color: Color) {
        self.serveLimit = serveLimit
        self.scoreLimit = scoreLimit
        self.team1Color = player1Color
        self.team2Color = player2Color
    }
    
    func resetGame() {
        
    }
    
}
