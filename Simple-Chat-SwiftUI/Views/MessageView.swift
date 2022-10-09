//
//  MessageView.swift
//  Simple-Chat-SwiftUI
//
//  Created by Илья Лясин on 05.10.2022.
//

import SwiftUI
import FirebaseAuth

struct MessageView : View {
    
    var currentMessage: Message
    
    var body: some View {
        let user = Auth.auth().currentUser
        let isCurrentUser = user?.email != currentMessage.sender
        
        HStack(alignment: .bottom, spacing: 15) {
            if isCurrentUser {
                Image(systemName: K.Images.baseAvatar)
                    .resizable()
                    .frame(width: 40, height: 40, alignment: .center)
                    .cornerRadius(20)
                    .foregroundColor(.mint)
            } else {
                Spacer()
            }
            ContentMessageView(contentMessage: currentMessage.body, isCurrentUser: isCurrentUser)
        }
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView(currentMessage: Message(id: "1", sender: "Person", body: "Hi"))
    }
}
