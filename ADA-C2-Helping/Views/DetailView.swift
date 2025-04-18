//
//  DetailView.swift
//  ADA-C2-Helping
//
//  Created by Donggyun Yang on 4/17/25.
//

import SwiftUI

struct DetailView: View {
    
    var content: CardModel
    
    var body: some View {
        VStack(spacing: 24) {
            // TODO: Profile
            HStack() {
                // Image
                Image(content.image)
                    .resizable()
                    .frame(width: 64, height: 64)
                    .aspectRatio(contentMode: .fit)
                
                VStack(alignment: .leading, spacing: 10) {
                    // nickname
                    NotoSansText(
                        "닉네임: \(content.name)"
                        , NotoSansStyle(size: 14)
                    )
                    
                    // major
                    NotoSansText(
                        "도움 요청 분야: \(content.major)"
                        , NotoSansStyle(size: 14)
                    )
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            // TODO: Content
            VStack(alignment: .leading, spacing: 12) {
                // title
                NotoSansText(
                    content.title
                    , NotoSansStyle(fontStyle: .bold, size: 20)
                )
                
                // content
                NotoSansText(
                    content.text
                )
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
            
            CustomButton(text: "도움 주기") {
                
            }
        }
        .padding(.top, 24)
        .padding(.horizontal, 16)
    }
}
