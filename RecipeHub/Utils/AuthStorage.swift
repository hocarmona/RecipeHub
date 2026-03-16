//
//  AuthStorage.swift
//  RecipeHub
//
//  Created by Hector Carmona on 3/16/26.
//

import Foundation

/// Simple wrapper to manage authentication state
final class AuthStorage {
    static let shared = AuthStorage()
    private let key = "isLoggedIn"
    
    private init() {}
    
    var isLoggedIn: Bool {
        get { UserDefaults.standard.bool(forKey: key) }
        set { UserDefaults.standard.set(newValue, forKey: key) }
    }
    
    func login() {
        isLoggedIn = true
    }
    
    func logout() {
        isLoggedIn = false
    }
}
