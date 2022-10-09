//
//  ViewRouter.swift
//  Simple-Chat-SwiftUI
//
//  Created by Илья Лясин on 18.09.2022.
//

import SwiftUI

class ViewRouter:ObservableObject {
    @Published var currentPage: Pages = .homePage
}
