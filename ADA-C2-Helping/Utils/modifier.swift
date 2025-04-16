//
//  modifier.swift
//  ADA-C2-Helping
//
//  Created by Donggyun Yang on 4/15/25.
//
import SwiftUI

struct ResetRowStyle: ViewModifier {
    let top: CGFloat
    let leading: CGFloat
    let bottom: CGFloat
    let trailing: CGFloat
    
    func body(content: Content) -> some View {
        content
            .listRowInsets(EdgeInsets(top: top, leading: leading, bottom: bottom, trailing: trailing))
            .listRowSeparator(.hidden)
            .listRowBackground(Color.white)
    }
}

extension View {
    func resetRowStyle(
        top: CGFloat = 0,
        leading: CGFloat = 0,
        bottom: CGFloat = 0,
        trailing: CGFloat = 0
    ) -> some View {
        modifier(ResetRowStyle(
            top: top,
            leading: leading,
            bottom: bottom,
            trailing: trailing
        ))
    }
}
