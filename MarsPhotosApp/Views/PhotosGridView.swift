//
//  PhotosGridView.swift
//  MarsPhotosApp
//
//  Created by BrainX IOS Dev on 7/19/23.
//

import SwiftUI

struct PhotosGridView: View {
    
    @StateObject var viewModel = MarsPhotosViewModel()
    
    private let cellWidth = (UIScreen.main.bounds.width - 16 * 2 - 16 * 2) / 3
    private let cellHeight = (UIScreen.main.bounds.width - 16 * 2 - 16 * 2) / 3
    
    let rover: Tabs
    
    var body: some View {
        ZStack {
            if viewModel.isLoading {
                ProgressView(LocalizedKey.loading.string)
            } else {
                ScrollView {
                    grilView
                        .padding()
                }
                .overlay(alignment: .bottom) {
                    if viewModel.isFetching {
                        ProgressView()
                    }
                }
            }
        }
        .blur(radius: viewModel.isPopupVisible ? 10 : 0)
        .navigationBarItems(trailing: filterButton)
        .navigationBarTitle(rover.rawValue)
        .overlay(popupView)
        .onAppear {
            viewModel.reset()
            viewModel.loadData(for: rover.rawValue)
        }
        .onDisappear {
            viewModel.reset()
        }
        .onTapGesture {
            viewModel.reset()
        }
        .alert(isPresented: $viewModel.hasError) {
            Alert(title: Text(LocalizedKey.alert.string),
                  message: Text(viewModel.error?.errorDescription ?? ""),
                  dismissButton: .default(Text(LocalizedKey.ok.string))
            )
        }
        .embedInNavigation()
    }
    
    private var grilView: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 16) {
            ForEach(viewModel.photos, id: \.id) { photo in
//                GridImageCell(url: photo.imgSrc)
                GridImageCell(imageData: photo.imageData)
                    .frame(width: cellWidth, height: cellHeight)
                    .onAppear {
                        if viewModel.shouldLoadMoreData(photo) && !viewModel.isFetching {
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
                    viewModel.selectedCamera = camera
                    viewModel.reset()
                    if camera != .none {
                        viewModel.loadFilteredData(for: rover.rawValue)
                    } else {
                        viewModel.loadData(for: rover.rawValue)
                    }
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
        .disabled(viewModel.isPopupVisible)
        .menuStyle(BorderlessButtonMenuStyle())
        .onTapGesture {
            viewModel.isDropdownVisible.toggle()
        }
    }
    
    private var popupView: some View {
        Group {
            if let vehicle = viewModel.selectedVehicle {
                PhotoPopupView(vehicle: vehicle, isPopupVisible: $viewModel.isPopupVisible)
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
