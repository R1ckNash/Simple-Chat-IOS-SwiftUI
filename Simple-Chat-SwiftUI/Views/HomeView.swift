//
//  AuthorizationPageView.swift
//  Simple-Chat-SwiftUI
//
//  Created by Илья Лясин on 18.09.2022.
//

import SwiftUI
import Firebase

struct HomeView: View {
    
    @StateObject var viewRouter: ViewRouter
    
    var body: some View {
        ZStack {
            Image(K.Images.backgroundImage)
                .resizable()
                .edgesIgnoringSafeArea(.vertical)
            VStack(spacing: 20) {
                Section(header: Text(K.Titles.appNameTitle)
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .foregroundColor(K.Colors.baseColor)) {
                        
                        ControlButton(viewRouter: viewRouter, page: .loginPage, buttonTitle: K.Titles.singInTitle, imageName: K.Images.signInImage)
                        ControlButton(viewRouter: viewRouter, page: .registerPage, buttonTitle: K.Titles.singUpTitle, imageName: K.Images.signUpImage)
                    }
            }
        }
    }
}


struct AuthorizationPageView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewRouter: ViewRouter())
    }
}

struct ControlButton: View {
    
    var viewRouter: ViewRouter
    let page: Pages
    let buttonTitle: String
    let imageName: String
    
    var body: some View {
        Button(action: {viewRouter.currentPage = page}) {
            RoundedRectangle(cornerRadius: 18)
                .fill(Color(red: 0.99, green: 0.80, blue: 0.43))
                .frame(height: 50)
                .overlay(HStack {
                    Image(systemName: imageName)
                        .foregroundColor(Color(.white))
                    Text(buttonTitle)
                        .foregroundColor(Color(.white))
                        .font(.title)
                        .fontWeight(.black)
                })
                .padding(.horizontal)
        }
    }
}
