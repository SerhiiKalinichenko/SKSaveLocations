//
//  View.swift
//  SKSaveLocations
//
//  Created by Serhii Kalinichenko on 10.12.2023.
//

import SwiftUI

extension View {
    func hiddenConditionally(isHidden: Bool) -> some View {
        isHidden ? AnyView(self.hidden()) : AnyView(self)
    }
    
    func showMessage(type: Binding<AlertType?>, title: LocalizedStringKey = "", buttonCaption: LocalizedStringKey = "ok") -> some View {
        let wrapped = type.wrappedValue
        return alert(Text(title), isPresented: .constant(wrapped != nil), presenting: wrapped) { _ in
            Button(buttonCaption) {
                type.wrappedValue = nil
            }
        } message: { alert in
            Text(alert.message)
        }
    }
}
