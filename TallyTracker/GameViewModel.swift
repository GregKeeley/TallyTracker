//
//  GameViewModel.swift
//  TallyTracker
//
//  Created by Gregory Keeley on 2/15/23.
//

import Foundation

class GameViewModel: ObservableObject {
    /// Tracks the score of player 1.
    @Published var player1Score: Int = 0
    /// Track the score of player 2.
    @Published var player2Score: Int = 0
    /// Store the names for player 1.
    @Published var player1Name: String = ""
    /// Stores the name for player 2.
    @Published var player2Name: String = ""
    /// Tracks the current count of the serve. This will increment every time the score of the game
    /// increments until the 'serveLimit' is reached. Once this happens, the serve count will reset to zero and repeat.
    @Published var serveCount: Int = 0
    /// This represents the max amount of serves that occur before the players switch who serves the ball.
    @Published var serveLimit: Int?
    /// This represents the score a single player needs to achieve before that player is declared the winner.
    @Published var scoreLimit: Int = 11
    /// Tracks when the end of the has been reached.
    @Published var gameOver: Bool = false
    
    init(serveLimit: Int) {
        self.serveLimit = serveLimit
    }
    
}
