//
//  CustomTextFieldStyle.swift
//  Simple-Chat-SwiftUI
//
//  Created by Илья Лясин on 01.10.2022.
//

import SwiftUI

struct CustomTextFieldStyle: TextFieldStyle {
    
    func _body(configuration: TextField<Self._Label>) -> some View  {
        RoundedRectangle(cornerRadius: 18)
            .fill(Color(red: 0.99, green: 0.80, blue: 0.43))
            .frame(height: 50)
            .overlay(HStack {
                configuration
                    .foregroundColor(Color(.white))
                    .font(.title)
                    .fontWeight(.medium)
                    .padding(10)
            })
    }
}
