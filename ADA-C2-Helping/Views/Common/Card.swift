//
//  Card.swift
//  ADA-C2-Helping
//
//  Created by Donggyun Yang on 4/13/25.
//

import SwiftUI

struct CardHeader: View {
    let text: String
    
    init(_ text: String) {
        self.text = text
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            NotoSansText(text, NotoSansStyle(fontStyle: .medium))
            Image("right-arrow")
        }
    }
}

struct CardFooter: View {
    let name: String
    let major: String
    
    var body: some View {
        // 사용자 이름
        HStack() {
            NotoSansText(name, NotoSansStyle(size: 13, color: Color("Gray888")))
            
            NotoSansText(" | ")
            
            NotoSansText(major, NotoSansStyle(fontStyle: .bold, size: 13, color: Color.accentColor))
        }
    }
}

struct Card: View {
    var image: String
    var text: String
    var name: String
    var major: String
    
    init(image: String = "default-card", text: String, name: String, major: String) {
        self.image = image
        self.text = text
        self.name = name
        self.major = major
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            // 기본 이미지
            Image(image)
                .resizable()
                .frame(width: 32, height: 32)
            
            VStack(alignment: .leading, spacing: 6) {
                CardHeader(text)
                
                CardFooter(name: name, major: major)
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white) // 또는 원하는 배경색
                .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
        )
    }
}

#Preview {
    Card(text: "나는 이런 도움이 필요해요. 근데 혼자서 해보려니까 잘 되지 않아요... 누가 좀 도와주세요!!!", name: "pray", major: "Tech")
}
