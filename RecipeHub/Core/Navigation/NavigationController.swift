//
//  NavigationController.swift
//  RecipeHub
//
//  Created by Hector Carmona on 3/13/26.
//

import SwiftUI

/// Observable wrapper for NavigationPath
final class NavigationController: ObservableObject {
    @Published var path = NavigationPath()
    
    func push<R: Route>(_ route: R) {
        path.append(route)
    }
    
    func pop() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    func replace<R: Route>(with route: R) {
        popToRoot()
        push(route)
    }
}
