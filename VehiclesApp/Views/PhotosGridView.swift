//
//  PhotosGridView.swift
//  VehiclesApp
//
//  Created by BrainX IOS Dev on 7/19/23.
//

import SwiftUI

struct PhotosGridView: View {
    
    @StateObject var viewModel = VehiclesViewModel()
    @State private var selectedCamera: CameraType = .none
    @State private var isDropdownVisible: Bool = false
    @State private var selectedVehicle: Vehicle?
    @State private var isPopupVisible: Bool = false
    
    let rover: Tabs
    
    var body: some View {
        NavigationView {
            ScrollView {
                grilView
                    .padding()
            }
            .blur(radius: isPopupVisible ? 10 : 0)
            .navigationBarTitle(rover.rawValue)
            .navigationBarItems(trailing: filterButton)
            .overlay(popupView)
            .onAppear {
                viewModel.loadData(for: rover.rawValue)
            }
            .onDisappear {
                isPopupVisible = false
                isDropdownVisible = false
            }
        }
        .alert(isPresented: $viewModel.error) {
            Alert(title: Text("Oops"),
                  message: Text(viewModel.errorMessage ?? ""),
                  dismissButton: .default(Text("OK"))
            )
        }
    }
    
    private var grilView: some View {
        LazyVGrid(columns: [GridItem(.flexible()),
                            GridItem(.flexible()),
                            GridItem(.flexible())],
                  spacing: 16) {
            
            ForEach(viewModel.photos) { photo in
                GridImageCell(url: photo.imgSrc)
                    .onAppear {
                        if viewModel.shouldLoadMoreData(photo) {
                            viewModel.loadData(for: rover.rawValue)
                        }
                    }
                    .onTapGesture {
                        isPopupVisible.toggle()
                        selectedVehicle = photo
                    }
            }
        }
    }
    
    private var filterButton: some View {
        Menu {
            ForEach(CameraType.allCases, id: \.self) { camera in
                Button(action: {
                    self.selectedCamera = camera
                }) {
                    HStack {
                        Image(systemName: camera == selectedCamera ? "checkmark.circle.fill" : "circle")
                        Text(camera.rawValue.uppercased())
                    }
                }
            }
        } label: {
            Image(systemName: "line.horizontal.3.decrease.circle.fill")
                .imageScale(.large)
        }
        .menuStyle(BorderlessButtonMenuStyle())
        .onTapGesture {
            isDropdownVisible.toggle()
        }
    }
    
    private var popupView: some View {
        Group {
            if let vehicle = selectedVehicle {
                VehiclePopupView(vehicle: vehicle, isPopupVisible: $isPopupVisible)
                    .onTapGesture {
                        withAnimation {
                            isPopupVisible = false
                        }
                    }
            } else {
                EmptyView()
            }
        }
    }
}
