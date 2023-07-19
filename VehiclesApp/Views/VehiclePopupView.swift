//
//  VehiclePopupView.swift
//  VehiclesApp
//
//  Created by BrainX IOS Dev on 7/19/23.
//

import SwiftUI

struct VehiclePopupView: View {
    
    let vehicle: Vehicle
    @Binding var isPopupVisible: Bool
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Spacer()
                AsyncImage(url: URL(string: vehicle.imgSrc))
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 300, height: 300)
                    .cornerRadius(20)
                    .shadow(radius: 20)
                Spacer()
            }
            
            Text("Date Taken: \(vehicle.earthDate)")
                .font(.headline)
            
            Text("Vehicle: \(vehicle.rover.name)")
                .font(.headline)
            
            Text("Launch Date: \(vehicle.rover.launchDate)")
                .font(.subheadline)
            
            Text("Landing Date: \(vehicle.rover.landingDate)")
                .font(.subheadline)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .padding()
        .offset(y: isPopupVisible ? 0 : UIScreen.main.bounds.height)
        .animation(.spring(), value: isPopupVisible)
        .opacity(isPopupVisible ? 1 : 0)
    }
}
