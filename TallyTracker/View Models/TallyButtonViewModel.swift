//
//  TallyButtonViewModel.swift
//  TallyTracker
//
//  Created by Gregory Keeley on 2/15/23.
//

import SwiftUI

class TallyButtonViewModel: ObservableObject {
    
    /// Represents the team color.
    @Published var color: Color
    /// Represents the name of the team.
    @Published var teamName: String
    /// Tracks the score of the team.
    @Published var teamScore: Int
    /// Used to determine if this view model belongs to team 1.
    @Published var isTeamOne: Bool
    ///
    @Published var scoreLimit: Int
    ///
    @Published var serveLimit: Int
    ///
    @Published var serveCount: Int
    ///
    @Published var isCurrentlyServing: Bool
    
    init(color: Color, teamName: String, teamScore: Int, isTeamOne: Bool, serveLimit: Int, isCurrentlyServing: Bool, serveCount: Int, scoreLimit: Int) {
        self.color = color
        self.teamName = teamName
        self.teamScore = teamScore
        self.isTeamOne = isTeamOne
        self.serveLimit = serveLimit
        self.isCurrentlyServing = isCurrentlyServing
        self.serveCount = serveCount
        self.scoreLimit = scoreLimit
    }
    
    
}
