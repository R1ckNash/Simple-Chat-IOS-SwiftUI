//
//  SignInView.swift
//  Simple-Chat-SwiftUI
//
//  Created by Илья Лясин on 18.09.2022.
//

import SwiftUI
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

struct SignInView: View {
    
    @StateObject var viewRouter: ViewRouter
    
    @State var email: String = ""
    @State var password: String = ""
    @State var signInProcessing = false
    @State var signInErrorMessage = ""
    
    @ObservedObject private var keyboard = KeyboardResponder()
    
    var body: some View {
        
        NavigationView {
            ZStack {
                Image(K.Images.backgroundImage)
                    .resizable()
                    .edgesIgnoringSafeArea(.vertical)
                
                VStack(spacing: 20) {
                    Section {
                        TextField(K.Placeholders.email, text: $email)
                        SecureField(K.Placeholders.password, text: $password)
                    }
                    .textFieldStyle(CustomTextFieldStyle())
                    
                    Button(action: {
                        signInUser(userEmail: email, userPassword: password)
                    }) {
                        Text(K.Titles.singInTitle)
                            .font(.largeTitle)
                            .fontWeight(.black)
                            .foregroundColor(K.Colors.baseColor)
                    }
                    .disabled(!signInProcessing && !email.isEmpty && !password.isEmpty ? false : true)
                    
                    if signInProcessing {
                        ProgressView()
                    }
                    
                    if !signInErrorMessage.isEmpty {
                        Text("Failed sign in: \(signInErrorMessage)")
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
    
    func signInUser(userEmail: String, userPassword: String) {
        
        signInProcessing = true
        
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            
            guard error == nil else {
                signInProcessing = false
                signInErrorMessage = error!.localizedDescription
                return
            }
            switch authResult {
            case .none:
                signInProcessing = false
            case .some(_):
                signInProcessing = false
                withAnimation {
                    viewRouter.currentPage = .chatPage
                }
            }
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(viewRouter: ViewRouter())
    }
}
