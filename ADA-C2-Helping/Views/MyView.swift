//
//  MyView.swift
//  ADA-C2-Helping
//
//  Created by Donggyun Yang on 4/17/25.
//

import SwiftUI

enum TabMode {
    case myHelp
    case giveHelp
}

struct Tab: View {
    @Binding var tabMode: TabMode
    
    var body: some View {
        HStack() {
            Button {
                tabMode = .myHelp
            } label: {
                NotoSansText(
                    "내가 작성한 글"
                    , NotoSansStyle(fontStyle: .bold, size: 17, color: tabMode == .myHelp ? .black : .customGray)
                )
                .background(
                    tabMode == .myHelp ?
                        GeometryReader { geometry in
                            Rectangle()
                                .fill(.accent)
                                .frame(width: geometry.size.width, height: 2)
                                .offset(y: geometry.size.height + 4)
                        } : nil
                )
            }
            .frame(maxWidth: 180)
            
            Spacer()
            
            Button {
                tabMode = .giveHelp
            } label: {
                NotoSansText(
                    "도움을 주고 있어요"
                    , NotoSansStyle(fontStyle: .bold, size: 17, color: tabMode == .giveHelp ? .black : .customGray)
                )
                .background(
                    tabMode == .giveHelp ?
                        GeometryReader { geometry in
                            Rectangle()
                                .fill(.accent)
                                .frame(width: geometry.size.width, height: 2)
                                .offset(y: geometry.size.height + 4)
                        } : nil
                )
            }
            .frame(maxWidth: 180)
        }
    }
}

struct MyView: View {
    @State private var tabMode: TabMode = .myHelp
    
    @Binding var cards: [CardModel]
    @Binding var selectedCard: CardModel?
    
    var body: some View {
        VStack {
            Tab(tabMode: $tabMode)
                .padding(.top, 24)
            
            CardList(cards: $cards, selectedCard: $selectedCard)
        }
        .padding(.horizontal, 16)
    }
}
