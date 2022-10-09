//
//  LoginPageView.swift
//  Simple-Chat-SwiftUI
//
//  Created by Илья Лясин on 18.09.2022.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct SignUpView: View {
    
    @StateObject var viewRouter: ViewRouter
    
    @State var email: String = ""
    @State var password: String = ""
    @State var passwordConfirmation: String = ""
    @State var signUpErrorMessage = ""
    @State var signUpProcessing = false
    
    @ObservedObject private var keyboard = KeyboardResponder()
    
    var body: some View {
        
        NavigationView {
            ZStack {
                Image(K.Images.backgroundImage)
                    .resizable()
                    .edgesIgnoringSafeArea(.vertical)
                
                VStack(spacing: 15) {
                    Section {
                        TextField(K.Placeholders.email, text: $email)
                        SecureField(K.Placeholders.password, text: $password)
                        SecureField(K.Placeholders.confirm, text: $passwordConfirmation)
                    }
                    .textFieldStyle(CustomTextFieldStyle())
                    
                    Button(action: {
                        signUpUser(userEmail: email, userPassword: password)
                    }) {
                        Text(K.Titles.singUpTitle)
                            .font(.largeTitle)
                            .fontWeight(.black)
                            .foregroundColor(K.Colors.baseColor)
                    }
                    .disabled(!signUpProcessing && !email.isEmpty && !password.isEmpty && !passwordConfirmation.isEmpty && password == passwordConfirmation ? false : true)
                    
                    if signUpProcessing {
                        ProgressView()
                    }
                    
                    if !signUpErrorMessage.isEmpty {
                        Text("Failed creating account: \(signUpErrorMessage)")
                            .foregroundColor(.red)
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(K.Titles.backButtonTitle) {
                            viewRouter.currentPage = .homePage
                        }
                    }
                }
                .padding()
                .edgesIgnoringSafeArea(keyboard.currentHeight == 0.0 ? .leading: .bottom)
                .onTapGesture {
                    self.endEditing(true)
                }
            }
        }
    }
    
    func signUpUser(userEmail: String, userPassword: String) {
        
        signUpProcessing = true
        
        Auth.auth().createUser(withEmail: userEmail, password: userPassword) { authResult, error in
            guard error == nil else {
                signUpErrorMessage = error!.localizedDescription
                signUpProcessing = false
                return
            }
            
            switch authResult {
            case .none:
                signUpProcessing = false
            case .some(_):
                signUpProcessing = false
                viewRouter.currentPage = .chatPage
            }
        }
    }
}

struct LoginPageView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(viewRouter: ViewRouter(), signUpProcessing: false)
    }
}
