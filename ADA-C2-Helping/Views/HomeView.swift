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
    @Binding var cards: [CardModel]
    @Binding var selectedCard: CardModel?
    
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
            
            CardList(cards: $cards, selectedCard: $selectedCard)
        }
        
    }
}

struct HomeView: View {
    
    // TODO: 테스트 데이터 수정 예정
    @State private var cards: [CardModel]  = [MajorType.tech, .design, .domain].flatMap { majorType in
        (0..<3).map { i in
            CardModel(
                title: "나는 이런 도움이 필요해요. 근데 혼자서 해보려니까 잘 되지 않아요... 누가 좀 도와주세요!!! 예시 \(i+1)",
                text: "지금 SwiftUI로 앱 개발을 처음 해보고 있어요. 유튜브랑 블로그 참고하면서 열심히 해보고 있는데, 막상 네비게이션 연결이나 뷰 전환 같은 기본적인 것들도 막히네요 ㅠㅠ 계속 혼자 고민하다가 지치기도 하고… 혹시 저처럼 처음 시작했을 때 어떻게 극복하셨는지, 팁이나 도와주실 수 있는 분 계실까요?",
                name: "user\(i+1)",
                major: majorType
            )
        }
    }
    @State private var selectedCard: CardModel?
    
    var body: some View {
        NavigationStack {
            VStack {
                Header(cards: $cards, selectedCard: $selectedCard)
                    .padding(.bottom, 24)
                    .padding(.horizontal, 16)
                
                ZStack(alignment: .bottom) {
                    ListContent(cards: $cards, selectedCard: $selectedCard)
                    
                    FAB()
                }
            }
            .navigationDestination(item: $selectedCard) { card in
                DetailView(content: card)
                    .navigationTitle("도움이 필요해핑!")
            }
        }
    }
}

#Preview {
    HomeView()
}
