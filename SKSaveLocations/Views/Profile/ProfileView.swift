//
//  ProfileView.swift
//  SKSaveLocations
//
//  Created by Serhii Kalinichenko on 03.12.2023.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        if let user = viewModel.user {
            List {
                Section {
                    HStack {
                        Text(user.avatarText)
                            .font(.system(size: 25))
                            .fontWeight(.semibold)
                            .foregroundStyle(.mainBlue)
                            .frame(width: 70, height: 70)
                            .background(.gray)
                            .clipShape(Circle())
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
                Section("Account") {
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
            
        }

    }
}

#Preview {
    ProfileView()
}
