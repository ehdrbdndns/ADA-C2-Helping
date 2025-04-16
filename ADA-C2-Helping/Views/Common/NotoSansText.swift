//
//  NotoSansFont.swift
//  ADA-C2-Helping
//
//  Created by Donggyun Yang on 4/13/25.
//

import SwiftUI

enum NotoSansFontStyle: String {
    case regular = "NotoSansKR-Regular"
    case medium = "NotoSansKR-Medium"
    case bold = "NotoSansKR-Bold"
}

struct NotoSansStyle {
    let fontStyle: NotoSansFontStyle
    let size: CGFloat
    let color: Color
    
    init(fontStyle: NotoSansFontStyle = .regular, size: CGFloat = 17, color: Color = .black) {
        self.fontStyle = fontStyle
        self.size = size
        self.color = color
    }
}

struct NotoSansText: View {
    let text: String
    let style: NotoSansStyle
    
    init(_ text: String, _ style: NotoSansStyle = NotoSansStyle()) {
        self.text = text
        self.style = style
    }
    
    var body: some View {
        Text(text)
            .font(Font.custom(style.fontStyle.rawValue, size: style.size))
            .foregroundColor(style.color)
    }
}

#Preview {
    let textStyle = NotoSansStyle(fontStyle: .medium, size: 24, color: .black)
    NotoSansText("hello", textStyle);
}
