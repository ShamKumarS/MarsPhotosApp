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
                GridImageCell(url: vehicle.imgSrc, width: 300, height: 300)
                Spacer()
            }
            
            Text("\(LocalizedKey.dateTaken.string) \(vehicle.earthDate)")
                .font(.headline)
            
            Text("\(LocalizedKey.vehicle.string) \(vehicle.rover.name)")
                .font(.headline)
            
            Text("\(LocalizedKey.launchDate.string) \(vehicle.rover.launchDate)")
                .font(.subheadline)
            
            Text("\(LocalizedKey.landingDate.string) \(vehicle.rover.landingDate)")
                .font(.subheadline)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .padding()
        .offset(y: isPopupVisible ? 0 : UIScreen.main.bounds.height)
        .animation(.spring(), value: isPopupVisible)
    }
}
