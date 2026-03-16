//
//  AppCoordinator.swift
//  RecipeHub
//
//  Created by Hector Carmona on 3/16/26.
//

import Combine
import SwiftUI

/// Main coordinator that handles Auth <-> Main flow
@MainActor
final class AppCoordinator: Coordinator {
    typealias Route = AppRoute
    
    @Published var currentRoute: AppRoute
    let navigationController: NavigationController
    
    // Child coordinators will be injected here
    private var authCoordinator: AuthCoordinator?
    private var mainCoordinator: MainCoordinator?
    
    init() {
        let isLoggedIn = AuthStorage.shared.isLoggedIn
        self.currentRoute = isLoggedIn ? .main : .auth
        self.navigationController = NavigationController()
    }
    
    var rootView: some View {
        Group {
            switch currentRoute {
            case .auth:
                authFlow()
            case .main:
                mainFlow()
            }
        }
        .animation(.easeInOut, value: currentRoute)
    }
    
    func coordinate(_ route: AppRoute) -> some View {
        EmptyView()
    }
    
    // MARK: - Private Helpers
    
    @ViewBuilder
    private func authFlow() -> some View {
        if authCoordinator == nil {
            authCoordinator = AuthCoordinator(parent: self)
        }
        authCoordinator?.rootView
    }
    
    @ViewBuilder
    private func mainFlow() -> some View {
        if mainCoordinator == nil {
            mainCoordinator = MainCoordinator(parent: self)
        }
        mainCoordinator?.rootView
    }
    
    // MARK: - Navigation Actions
    
    func didLogin() {
        AuthStorage.shared.login()
        currentRoute = .main
        authCoordinator = nil
    }
    
    func didLogout() {
        AuthStorage.shared.logout()
        currentRoute = .auth
        mainCoordinator = nil
    }
}
