//
//  SetGameApp.swift
//  Set Game
//
//  Created by Leozítor Floro on 25/09/20.
//

import SwiftUI

@main
struct SetGameApp: App {
    var body: some Scene {
        WindowGroup {
            let game = SetGameViewModel()
            SetGameView(viewModel: game)
        }
    }
}
