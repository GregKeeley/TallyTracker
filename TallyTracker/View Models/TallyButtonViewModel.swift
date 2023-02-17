//
//  TallyButtonViewModel.swift
//  TallyTracker
//
//  Created by Gregory Keeley on 2/15/23.
//

import SwiftUI

class TallyButtonViewModel: ObservableObject {
    @Published var color: Color
    @Published var playerName: String
    @Published var playerScore: Int
    @Published var isPlayerOne: Bool
    
    init(color: Color, playerName: String, playerScore: Int, isPlayerOne: Bool) {
        self.color = color
        self.playerName = playerName
        self.playerScore = playerScore
        self.isPlayerOne = isPlayerOne
    }
}
