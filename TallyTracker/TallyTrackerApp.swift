//
//  TallyTrackerApp.swift
//  TallyTracker
//
//  Created by Gregory Keeley on 2/11/23.
//

import SwiftUI

@main
struct TallyTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            TallyView(player1Score: 0, player2Score: 0)
        }
    }
}
