//
//  MotherView.swift
//  Simple-Chat-SwiftUI
//
//  Created by Илья Лясин on 18.09.2022.
//

import SwiftUI

struct MotherView: View {
    
    @StateObject var viewRouter: ViewRouter
    
    var body: some View {
        
        switch viewRouter.currentPage {
        case .homePage:
            HomeView(viewRouter: viewRouter)
        case .registerPage:
            SignUpView(viewRouter: viewRouter)
        case .loginPage:
            SignInView(viewRouter: viewRouter)
        case .chatPage:
            ChatView(viewRouter: viewRouter)
        }
    }
}

struct MotherView_Previews: PreviewProvider {
    static var previews: some View {
        MotherView(viewRouter: ViewRouter())
    }
}
