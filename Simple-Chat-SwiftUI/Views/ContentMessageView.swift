//
//  MessageStyleView.swift
//  Simple-Chat-SwiftUI
//
//  Created by Илья Лясин on 05.10.2022.
//

import SwiftUI

struct ContentMessageView: View {
    
    var contentMessage: String
    var isCurrentUser: Bool
    
    var body: some View {
        Text(contentMessage)
            .padding(10)
            .foregroundColor(isCurrentUser ? Color.black : Color.white)
            .background(isCurrentUser ? Color(red: 0.99, green: 0.80, blue: 0.43) : K.Colors.baseColor)
            .cornerRadius(10)
    }
}

struct MessageStyleView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ContentMessageView(contentMessage: "Hello", isCurrentUser: true)
            ContentMessageView(contentMessage: "Sup", isCurrentUser: false)
        }
    }
}
