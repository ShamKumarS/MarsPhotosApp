//
//  ContentView.swift
//  VehiclesApp
//
//  Created by BrainX IOS Dev on 7/18/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selectedTab: Tabs = .curiosity
    
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundEffect = UIBlurEffect(style: .systemMaterial)
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            PhotosGridView(rover: .curiosity)
                .tabItem {
                    Label(Tabs.curiosity.rawValue, systemImage: "list.dash")
                }
                .tag(Tabs.curiosity)
            
            PhotosGridView(rover: .opportunity)
                .tabItem {
                    Label(Tabs.opportunity.rawValue, systemImage: "square.and.pencil")
                }
                .tag(Tabs.opportunity)
            
            PhotosGridView(rover: .spirit)
                .tabItem {
                    Label(Tabs.spirit.rawValue, systemImage: "gear")
                }
                .tag(Tabs.spirit)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
