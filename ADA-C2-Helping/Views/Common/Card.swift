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

enum MajorType: String {
    case tech = "Tech"
    case design = "Design"
    case domain = "Domain"
    
    var color: Color {
        switch self {
        case .tech:
            return .accentColor
        case .design:
            return Color("DesignColor")
        case .domain:
            return Color("DomainColor")
        }
    }
}

struct CardFooter: View {
    let name: String
    let major: MajorType
    
    var body: some View {
        // 사용자 이름
        HStack() {
            NotoSansText(name, NotoSansStyle(size: 13, color: Color("Gray888")))
            
            NotoSansText(" | ")
            
            NotoSansText(major.rawValue, NotoSansStyle(fontStyle: .bold, size: 13, color: major.color))
        }
    }
}

struct CardModel: Identifiable {
    let id = UUID()
    let image: String = "default-card"
    let text: String
    let name: String
    let major: MajorType
}

struct Card: View {
    var model: CardModel
    
    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            // 기본 이미지
            Image(model.image)
                .resizable()
                .frame(width: 32, height: 32)
            
            VStack(alignment: .leading, spacing: 6) {
                CardHeader(model.text)
                
                CardFooter(name: model.name, major: model.major)
            }
        }
        .padding(16)
        .frame(width: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
        )
    }
}

#Preview {
    Card(model: CardModel(text: "나는 이런 도움이 필요해요. 근데 혼자서 해보려니까 잘 되지 않아요... 누가 좀 도와주세요!!!", name: "pray", major: .tech))
}
