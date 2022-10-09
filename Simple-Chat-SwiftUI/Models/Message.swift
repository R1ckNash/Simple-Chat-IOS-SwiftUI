//
//  Message.swift
//  Simple-Chat-SwiftUI
//
//  Created by Илья Лясин on 01.10.2022.
//

import Foundation

struct Message: Identifiable, Hashable {
    let id: String
    let sender: String
    let body: String
}
