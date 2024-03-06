//
//  AlertView.swift
//  SKSaveLocations
//
//  Created by Serhii Kalinichenko on 29.02.2024.
//

import SwiftUI

extension View {
    func showAlert(_ alert: Binding<AlertType?>, buttonCaption: LocalizedStringKey = "ok") -> some View {
        return self.modifier(AlertViewModifier(buttonCaption: buttonCaption, alert: alert))
    }
}

private struct AlertView: View {
    let buttonCaption: LocalizedStringKey
    @Binding var alert: AlertType?
    
    var body: some View {
        if let alert {
            ZStack {
                Color(.black)
                    .ignoresSafeArea()
                    .opacity(0.6)
                VStack {
                    AlertText(alert.title)
                        .font(.system(size: 16))
                        .padding(.top, 16)
                        .padding(.bottom, 8)
                    AlertText(alert.message)
                        .font(.system(size: 16))
                        .padding(.bottom, 16)
                    Divider()
                        .background(.gray)
                        .padding(.horizontal, 16)
                        
                    Button(action: {
                        self.alert = nil
                    }, label: {
                        Text(buttonCaption)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .frame(height: 44)
                            .background(.mainBlue)
                            .foregroundColor(.white)
                            .clipShape(Capsule())
                    })
                    .padding(16)
                }
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(16)
            }
            .contentShape(Rectangle())
        } else {
            EmptyView()
        }
    }
}

private struct AlertText: View {
    private let text: String
    
    init(_ text: String) {
        self.text = text
    }
    
    var body: some View {
        Text(text)
            .multilineTextAlignment(.center)
            .foregroundColor(.black)
            .padding(.horizontal, 16)
    }
}

private struct AlertViewModifier: ViewModifier {
    let buttonCaption: LocalizedStringKey
    @Binding var alert: AlertType?
    
    private var bindingAlert: Binding<AlertType?> {
        Binding {
            alert
        } set: {
            alert = $0
        }
    }
    
    func body(content: Content) -> some View {
        ZStack {
            content
            if bindingAlert.wrappedValue != nil {
                AlertView(buttonCaption: buttonCaption, alert: bindingAlert)
            }
        }
    }
}
