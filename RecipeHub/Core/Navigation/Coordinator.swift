//
//  Coordinator.swift
//  RecipeHub
//
//  Created by Hector Carmona on 3/13/26.
//

import SwiftUI

/// Base protocol for all coordinators
@MainActor
protocol Coordinator: AnyObject, ObservableObject {
    associatedtype Route: RecipeHub.Route
    associatedtype Body: View
    
    var navigationController: NavigationController { get }
    
    /// Root view of the coordinator with navigationDestination configured
    @ViewBuilder var rootView: Body { get }
    
    /// Factory that creates the destination view for each route
    associatedtype Destination: View
    @ViewBuilder func coordinate(_ route: Route) -> Destination
}
