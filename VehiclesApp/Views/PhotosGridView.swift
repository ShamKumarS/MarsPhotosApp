//
//  PhotosGridView.swift
//  VehiclesApp
//
//  Created by BrainX IOS Dev on 7/19/23.
//

import SwiftUI

struct PhotosGridView: View {
    
    @StateObject var viewModel = VehiclesViewModel()
    
    let rover: Tabs
    
    var body: some View {
        NavigationView {
            ScrollView {
                grilView
                    .padding()
            }
            .blur(radius: viewModel.isPopupVisible ? 10 : 0)
            .navigationBarTitle(rover.rawValue)
            .navigationBarItems(trailing: filterButton)
            .overlay(popupView)
            .onAppear {
                viewModel.loadData(for: rover.rawValue)
            }
            .onDisappear {
                viewModel.isPopupVisible = false
                viewModel.isDropdownVisible = false
            }
        }
        .alert(isPresented: $viewModel.error) {
            Alert(title: Text(LocalizedKey.alert.string),
                  message: Text(viewModel.errorMessage ?? ""),
                  dismissButton: .default(Text(LocalizedKey.ok.string))
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
                        viewModel.isPopupVisible.toggle()
                        viewModel.selectedVehicle = photo
                    }
            }
        }
    }
    
    private var filterButton: some View {
        Menu {
            ForEach(CameraType.allCases, id: \.self) { camera in
                Button(action: {
                    self.viewModel.selectedCamera = camera
                    self.viewModel.loadFilteredData(for: rover.rawValue)
                    //                    if camera == .none {
                    //                        self.viewModel.currentPage = 1
                    //                        self.viewModel.totalPages = 1
                    //                        self.viewModel.photos.removeAll()
                    //                    }
                }) {
                    HStack {
                        Image(systemName: camera == viewModel.selectedCamera ? "checkmark.circle.fill" : "circle")
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
            viewModel.isDropdownVisible.toggle()
        }
    }
    
    private var popupView: some View {
        Group {
            if let vehicle = viewModel.selectedVehicle {
                VehiclePopupView(vehicle: vehicle, isPopupVisible: $viewModel.isPopupVisible)
                    .onTapGesture {
                        withAnimation {
                            viewModel.isPopupVisible = false
                        }
                    }
            } else {
                EmptyView()
            }
        }
    }
}
