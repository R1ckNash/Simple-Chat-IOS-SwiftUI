//
//  ChatView.swift
//  Simple-Chat-SwiftUI
//
//  Created by Илья Лясин on 18.09.2022.
//

import SwiftUI
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

struct ChatView: View {
    
    @StateObject var viewRouter: ViewRouter
    
    @State var signOutProcessing = false
    @State var text: String = ""
    
    @ObservedObject var networkManager = NetworkManager()
    @ObservedObject var keyboard = KeyboardResponder()
    
    let db = Firestore.firestore()
    
    var body: some View {
        NavigationView {
            ScrollViewReader { scrollView in
                VStack(spacing: .ulpOfOne) {
                    List {
                        ForEach(networkManager.messages, id: \.self) { msg in
                            MessageView(currentMessage: msg)
                                .listRowSeparator(.hidden)
                                .listRowBackground(Color(.white))
                                .id(msg)
                        }
                    }
                    .listStyle(PlainListStyle())
                    .background(Color(.white))
                    .scrollContentBackground(.hidden)
                    .onAppear() {
                        self.networkManager.fetchData()
                    }
                    HStack {
                        TextField(K.Placeholders.message, text: $text)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(minHeight: CGFloat(30))
                        Button(action: {
                            saveMessage(text)
                            text = ""
                        }) {
                            Image(systemName: K.Images.sendButtonImage)
                                .frame(width: 25, height: 25)
                                .foregroundColor(.white)
                        }
                    }
                    .padding()
                    .background(Color(red: 0.98, green: 0.69, blue: 0.63))
                }
                .navigationBarTitle(Text(K.Titles.chatTitle),  displayMode: .inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        if signOutProcessing {
                            ProgressView()
                        } else {
                            Button(K.Titles.singOutTitle) {
                                signOutUser()
                            }
                        }
                    }
                }
                .toolbarBackground(Color(red: 0.98, green: 0.69, blue: 0.63), for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
                .padding(.bottom, keyboard.currentHeight)
                .edgesIgnoringSafeArea(keyboard.currentHeight == 0.0 ? .leading: .bottom)
            }
        }
        .onTapGesture {
            self.endEditing(true)
        }
    }
    
    func saveMessage(_ text: String) {
        let user = Auth.auth().currentUser
        if let user = user {
            db.collection(K.FStore.collectionName).addDocument(data: [
                K.FStore.idField: randomString(length: 5),
                K.FStore.senderField: user.email!,
                K.FStore.bodyField: text,
                K.FStore.dateField: Date.timeIntervalSinceReferenceDate
            ]) { error in
                guard error == nil else {
                    print(error!.localizedDescription)
                    return
                }
            }
        }
    }
    
    func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    func signOutUser() {
        signOutProcessing = true
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print(K.ErrorMessages.signOutError, signOutError)
        }
        withAnimation {
            viewRouter.currentPage = .homePage
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(viewRouter: ViewRouter())
    }
}
