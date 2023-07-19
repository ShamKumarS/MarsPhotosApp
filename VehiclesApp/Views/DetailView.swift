//
//  DetailView.swift
//  VehiclesApp
//
//  Created by BrainX IOS Dev on 7/19/23.
//

import SwiftUI

struct DetailView: View {
    let vehicle: Vehicle
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Spacer()
                AsyncImage(url: URL(string: vehicle.imgSrc))
                    .frame(width: 300, height: 300)
                    .scaledToFit()
                    .cornerRadius(20)
                    .shadow(radius: 20)
                Spacer()
            }
            
            Text("Earth date: \(vehicle.earthDate)")
                .font(.title)
            
            Text("Landing date: \(vehicle.rover.landingDate)")
            
            Text("Launch date: \(vehicle.rover.launchDate)")
            
            Spacer()
        }
        .padding([.leading, .trailing], 15)
    }
}
