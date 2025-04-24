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
                Header
                
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
                print("onChangeHomeView", isSuccess)
                if isSuccess {
                    cards = helpViewModel.helps.map { help in
                        CardModel(
                            helpId: help.id,
                            helperId: help.helperId,
                            authorId: help.authorId,
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
                            authorId: help.authorId,
                            title: help.title,
                            text: help.content,
                            name: help.authorNickname,
                            major: help.major
                        )
                    }
                }
            }
            .onChange(of: helpViewModel.helps.count) { beforCount, newCount in
                print("onChangeHomeView", beforCount, newCount)
                if beforCount != newCount {
                    print("preview")
                    print(cards.count);
                    
                    cards = helpViewModel.helps.map { help in
                        CardModel(
                            helpId: help.id,
                            helperId: help.helperId,
                            authorId: help.authorId,
                            title: help.title,
                            text: help.content,
                            name: help.authorNickname,
                            major: help.major
                        )
                    }
                    
                    print("after")
                    print(cards.count)
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
    
    var Header: some View {
        HStack {
            Image("logo")
            
            Spacer()
            
            Button {
                routerPath.append(.my)
            } label: {
                Image("list-bullet")
            }
        }
        .padding(.bottom, 24)
        .padding(.horizontal, 16)
    }
    
    var ListContent: some View {
        VStack {
            HStack {
                NotoSansText("도움이 필요해요", NotoSansStyle(
                    fontStyle: .bold, size: 28
                ))
                Spacer()
                NotoSansText(String(filteredCards.count), NotoSansStyle(
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
