//
//  NetworkManager.swift
//  Simple-Chat-SwiftUI
//
//  Created by Илья Лясин on 01.10.2022.
//

import Foundation
import FirebaseFirestore

class NetworkManager: ObservableObject {
    
    @Published var messages = [Message]()
    
    private var db = Firestore.firestore()
    
    func fetchData() {
        
        db.collection(K.FStore.collectionName)
            .order(by: K.FStore.dateField)
            .addSnapshotListener { querySnapshot, error in
                
                guard error == nil else {
                    print("There was an issue retrieving data from Firestore \(error!.localizedDescription)")
                    return
                }
                
                self.messages = []
                
                if let snapshotDocuments = querySnapshot?.documents {
                    for document in snapshotDocuments {
                        let data = document.data()
                        if let messageSender = data[K.FStore.senderField] as? String,
                           let messageBody = data[K.FStore.bodyField] as? String,
                           let messageId = data[K.FStore.idField] as? String {
                            
                            let newMessage = Message(id: messageId, sender: messageSender, body: messageBody)
                            
                            DispatchQueue.main.async {
                                self.messages.append(newMessage)
                            }
                        }
                    }
                }
            }
    }
}
