//
//  diaryApp.swift
//  diary
//
//  Created by 君野敬祐 on 2020/12/06.
//

import SwiftUI

@main
struct diaryApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
