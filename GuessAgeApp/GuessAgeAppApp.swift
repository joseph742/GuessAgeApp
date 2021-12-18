//
//  GuessAgeAppApp.swift
//  GuessAgeApp
//
//  Created by Joseph Umoru on 25/11/2021.
//

import SwiftUI

@main
struct GuessAgeAppApp: App {
    var body: some Scene {
        WindowGroup {
            let viewModel = RandomUserViewModel()
            RandomUserView(viewModel: viewModel)
        }
    }
}
