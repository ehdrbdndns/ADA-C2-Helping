//
//  HomeView.swift
//  ADA-C2-Helping
//
//  Created by Donggyun Yang on 4/11/25.
//

import SwiftUI

struct FAB: View {
    var body: some View {
        VStack {
            HStack {
                // Button
                Button {
                    
                } label: {
                    Image(systemName: "plus")
                }
                .foregroundStyle(.white)
                .font(.system(size: 30))
            }
            .frame(width: 80, height: 80)
            .background(.accent, in: RoundedRectangle(cornerRadius: 50))
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .padding(.top, 16)
        .background(
            LinearGradient(colors: [Color.white.opacity(0), .white], startPoint: .top, endPoint: UnitPoint(x: 0.5, y: 0.75))
        )
    }
}

struct ListContent: View {
    var cards: [CardModel]
    
    init(_ cards: [CardModel]) {
        self.cards = cards
    }
    
    var body: some View {
        VStack {
            HStack {
                NotoSansText("도움이 필요해요", NotoSansStyle(
                    fontStyle: .bold, size: 28
                ))
                Spacer()
                NotoSansText("32", NotoSansStyle(
                    fontStyle: .bold, size: 16, color: .accent
                ))
            }
            .padding(.horizontal, 16)
            
            CardList(cardModels: cards)
        }
        
    }
}

struct HomeView: View {
    let cards: [CardModel]
    
    var body: some View {
        VStack {
            Header()
                .padding(.bottom, 24)
                .padding(.horizontal, 16)
            
            ZStack(alignment: .bottom) {
                ListContent(cards)
                
                FAB()
            }
        }
    }
}

#Preview {
    let testDatas = [MajorType.tech, .design, .domain].flatMap { majorType in
        (0..<3).map { i in
            CardModel(
                text: "나는 이런 도움이 필요해요. 근데 혼자서 해보려니까 잘 되지 않아요... 누가 좀 도와주세요!!! 예시 \(i+1)",
                name: "user\(i+1)",
                major: majorType
            )
        }
    }
    
    HomeView(cards: testDatas)
}
