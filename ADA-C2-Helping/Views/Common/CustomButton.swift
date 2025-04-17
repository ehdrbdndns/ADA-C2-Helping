//
//  Button.swift
//  ADA-C2-Helping
//
//  Created by Donggyun Yang on 4/16/25.
//

import SwiftUI

struct CustomButton: View {
    let text: String
    let action: () -> Void

    var body: some View {
        VStack {
            Button(action: action) {
                NotoSansText(
                    text
                    , NotoSansStyle(fontStyle: .medium, size: 17, color: .white
                    )
                )
            }
            .padding(.vertical, 18)
            .frame(maxWidth: .infinity)
            .background(.accent, in: RoundedRectangle(cornerRadius: 12))
            .shadow(color: Color.black.opacity(0.1), radius: 6, x: 0, y: 2)
        }
    }
}

#Preview {
    CustomButton(text: "글 작성하기") {
            
    }
    .padding(.horizontal, 30)
}
