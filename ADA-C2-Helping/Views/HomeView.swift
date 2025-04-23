//
//  HomeView.swift
//  ADA-C2-Helping
//
//  Created by Donggyun Yang on 4/11/25.
//

import SwiftUI

enum AppRoute: Hashable {
    case my
    case detail(card: CardModel)
}

struct HomeView: View {
    
    @ObservedObject private var helpViewModel = HelpViewModel()
    @ObservedObject private var userViewModel = UserViewModel()
    
    @State private var cards: [CardModel] = []
    @State private var filteredCards: [CardModel] = []
    @State private var selectedCard: CardModel?
    @State private var showSheet: Bool = false
    
    @State private var routerPath: [AppRoute] = []
    
    var body: some View {
        NavigationStack(path: $routerPath) {
            VStack {
                Header(
                    cards: $cards
                    , selectedCard: $selectedCard
                    , user: userViewModel.user
                    , onMyViewTapped: { routerPath.append(.my) }
                    )
                    .padding(.bottom, 24)
                    .padding(.horizontal, 16)
                
                ZStack(alignment: .bottom) {
                    ListContent
                    
                    FAB
                }
            }
            .task {
                await helpViewModel.fetchHelps()
                await userViewModel.fetchUser(id: userViewModel.user.id)
            }
            .onChange(of: helpViewModel.isSuccess) { _, isSuccess in
                if isSuccess {
                    cards = helpViewModel.helps.map { help in
                        CardModel(
                            helpId: help.id,
                            helperId: help.helperId,
                            title: help.title,
                            text: help.content,
                            name: help.authorNickname,
                            major: help.major
                        )
                    }
                    
                    let filteredHelps = helpViewModel.helps.filter { help in
                        return help.authorId != userViewModel.user.id && help.isBeingHelped == false
                    }
                    
                    filteredCards = filteredHelps.map { help in
                        CardModel(
                            helpId: help.id,
                            helperId: help.helperId,
                            title: help.title,
                            text: help.content,
                            name: help.authorNickname,
                            major: help.major
                        )
                    }
                }
            }
            .navigationDestination(for: AppRoute.self) { route in
                switch(route) {
                case .my:
                    MyView(
                        helpViewModel: helpViewModel
                        , userViewModel: userViewModel
                        , cards: $cards
                        , user: userViewModel.user
                        , onDetailViewTapped: { card in
                            routerPath.append(.detail(card: card))}
                        , onBackToHome: {
                            routerPath.removeAll()
                        }
                    )
                case .detail(let card):
                    DetailView(
                        content: card
                        , helpViewModel: helpViewModel
                        , userViewModel: userViewModel
                        , onMyViewTapped: {
                            routerPath.append(.my)
                        }
                    )
                }
                
            }
        }
    }
    
    var ListContent: some View {
        VStack {
            HStack {
                NotoSansText("도움이 필요해요", NotoSansStyle(
                    fontStyle: .bold, size: 28
                ))
                Spacer()
                NotoSansText(String(cards.count), NotoSansStyle(
                    fontStyle: .bold, size: 16, color: .accent
                ))
            }
            .padding(.horizontal, 16)
            
            CardList(
                helpViewModel: helpViewModel
                , userViewModel: userViewModel
                , cards: $filteredCards
                , onDetailViewTapped: { card in
                    routerPath.append(.detail(card: card))
                }
            )
        }
    }
    
    var FAB: some View {
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
                CreateHelpView(helpViewModel: helpViewModel)
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

#Preview {
    HomeView()
}
