//
//  View.swift
//  VehiclesApp
//
//  Created by BrainX IOS Dev on 7/20/23.
//

import SwiftUI

extension View {
    
    @ViewBuilder
    func embedInNavigation() -> some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                self
            }
        } else {
            NavigationView {
                self
            }
        }
    }
}
