//
//  ChessApp.swift
//  Chess
//
//  Created by Jorge de Carvalho on 05/01/26.
//

import SwiftUI
import CoreData

@main
struct ChessApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            VStack {
                GameView()
            }
        }
    }
}
