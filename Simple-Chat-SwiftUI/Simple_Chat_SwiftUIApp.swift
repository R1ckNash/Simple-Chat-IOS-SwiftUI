//
//  Simple_Chat_SwiftUIApp.swift
//  Simple-Chat-SwiftUI
//
//  Created by Илья Лясин on 18.09.2022.
//

import SwiftUI
import Firebase

@main
struct Simple_Chat_SwiftUIApp: App {
    
    @StateObject var viewRouter = ViewRouter()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            MotherView(viewRouter: viewRouter)
                .environmentObject(viewRouter)
        }
    }
}
