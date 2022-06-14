//
//  RememberMyNumberApp.swift
//  RememberMyNumber
//
//  Created by Antony Wilson on 6/12/22.
//

import SwiftUI

@main
struct RememberMyNumberApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView(coreDM: CoreDataManager())
        }
    }
}
