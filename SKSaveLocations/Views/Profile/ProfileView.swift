//
//  ProfileView.swift
//  SKSaveLocations
//
//  Created by Serhii Kalinichenko on 03.12.2023.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel: ProfileViewModel
    @State private var image: Image?
    @State private var showImagePicker = false
    @State private var addedImage: UIImage?
    
    var body: some View {
        if let user = viewModel.authService.user {
            List {
                Section {
                    HStack {
                        ProfileImageView(imageURL: user.avatarURL, image: image, name: user.name)
                            .onTapGesture {
                                showImagePicker = true
                            }
                        VStack(alignment: .leading, spacing: 5) {
                            Text(user.name)
                                .font(.system(size: 23))
                                .fontWeight(.semibold)
                            Text(verbatim: user.email)
                                .font(.system(size: 20))
                                .foregroundColor(.gray)
                        }
                    }
                }
                Section("account") {
                    RoundedButton(label: "logOut", icon: Image(systemName: "figure.walk.arrival")) {
                        viewModel.logOut()
                    }
                    .frame(height: 44)
                    .listRowSeparator(.hidden)
                    .shadow(radius: 4)
                    RoundedButton(label: "deleteAccount", icon: Image(systemName: "folder.badge.minus"), buttonColor: .red) {
                        viewModel.deleteAccount()
                    }
                    .frame(height: 44)
                    .shadow(radius: 4)
                }
            }
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(image: $addedImage)
            }
            .onChange(of: addedImage) {
                loadImage()
            }
        } else {
            ProgressView()
                .tint(.mainBlue)
        }
            
    }
        
    func loadImage() {
        guard let addedImage else {
            return
        }
        image = Image(uiImage: addedImage)
    }
}

#Preview {
    ProfileView(viewModel: ProfileViewModel(authService: AuthServiceMock()))
}
