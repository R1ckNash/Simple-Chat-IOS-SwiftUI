//
//  Constants.swift
//  Simple-Chat-SwiftUI
//
//  Created by Илья Лясин on 26.09.2022.
//

import SwiftUI

struct K {
    
    struct Images {
        static let backgroundImage = "ILY-Chat-background"
        static let signInImage = "door.left.hand.open"
        static let signUpImage = "newspaper.fill"
        static let sendButtonImage = "paperplane.fill"
        static let baseAvatar = "person.fill"
    }
    
    struct Titles {
        static let appNameTitle = " The\nChat"
        static let chatTitle = "Chat"
        static let singInTitle = "Sign In"
        static let singUpTitle = "Sign Up"
        static let singOutTitle = "Sign Out"
        static let backButtonTitle = "Back"
    }
    
    struct Colors {
        static let baseColor = Color(red: 0.98, green: 0.69, blue: 0.63)
    }
    
    struct Placeholders {
        static let email = "Email"
        static let password = "Password"
        static let confirm = "Confirm"
        static let message = "Message..."
    }
    
    struct FStore {
        static let collectionName = "messages"
        static let idField = "id"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
    }
    
    struct ErrorMessages {
        static let signOutError = "Error signing out: %@"
    }
}
