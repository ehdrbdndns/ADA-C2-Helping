//
//  HomeView.swift
//  ADA-C2-Helping
//
//  Created by Donggyun Yang on 4/11/25.
//

import SwiftUI

struct FAB: View {
    @State private var showSheet = false
    
    var body: some View {
        VStack {
            // Button
            Button {
                
                showSheet = true
            } label: {
                Image(systemName: "plus")
            }
            .foregroundStyle(.white)
            .font(.system(size: 30))
            .frame(width: 80, height: 80)
            .background(.accent, in: RoundedRectangle(cornerRadius: 50))
            .sheet(isPresented: $showSheet) {
                CreateHelpView()
                    .presentationDragIndicator(.visible)
            }
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
    
    // TODO: 테스트 데이터 수정 예정
    @State private var cards: [CardModel]  = [MajorType.tech, .design, .domain].flatMap { majorType in
        (0..<3).map { i in
            CardModel(
                text: "나는 이런 도움이 필요해요. 근데 혼자서 해보려니까 잘 되지 않아요... 누가 좀 도와주세요!!! 예시 \(i+1)",
                name: "user\(i+1)",
                major: majorType
            )
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Header(cards: $cards)
                    .padding(.bottom, 24)
                    .padding(.horizontal, 16)
                
                ZStack(alignment: .bottom) {
                    ListContent(cards)
                    
                    FAB()
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
