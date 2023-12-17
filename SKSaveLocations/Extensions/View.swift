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
}
