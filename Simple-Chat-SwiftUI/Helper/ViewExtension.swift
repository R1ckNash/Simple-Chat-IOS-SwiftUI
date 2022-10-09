//
//  ViewExtension.swift
//  Simple-Chat-SwiftUI
//
//  Created by Илья Лясин on 06.10.2022.
//

import SwiftUI

extension View {
    func endEditing(_ force: Bool) {
        UIApplication.shared.windows.forEach { $0.endEditing(force)}
    }
}
