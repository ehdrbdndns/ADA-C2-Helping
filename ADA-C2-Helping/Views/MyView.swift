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

struct MyView: View {
    @ObservedObject var helpViewModel: HelpViewModel
    @ObservedObject var userViewModel: UserViewModel
    @State private var tabMode: TabMode = .myHelp
    @State var filteredCards: [CardModel] = [];
    @Binding var cards: [CardModel]
    
    var user: User
    var onDetailViewTapped: (CardModel) -> Void
    var onBackToHome: () -> Void
    
    var body: some View {
        VStack {
            Tab
            
            CardList(
                helpViewModel: helpViewModel
                , userViewModel: userViewModel
                , cards: $filteredCards
                , onDetailViewTapped: onDetailViewTapped
            )
        }
        .padding(.horizontal, 16)
        .onAppear() {
            applyFilter()
        }
        .onChange(of: tabMode) {
            applyFilter()
        }
        .onChange(of: cards) {
            applyFilter()
        }
        .navigationBarBackButtonHidden(true) // 기본 백버튼 숨기고
        .navigationTitle("나의 기록")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("< 뒤로") {
                    onBackToHome()
                }
            }
        }
    }
    
    var Tab: some View {
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
        .padding(.top, 24)
    }
    
    private func applyFilter() {
        switch tabMode {
        case .myHelp:
            filteredCards = cards.filter { card in
                return user.writtenHelps.contains(card.helpId)
            }
        case .giveHelp:
            filteredCards = cards.filter { card in
                return card.helperId == user.id
            }
        }
    }
}
