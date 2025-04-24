//
//  CardList.swift
//  ADA-C2-Helping
//
//  Created by Donggyun Yang on 4/14/25.
//

import SwiftUI

struct CardList: View {
    
    @ObservedObject var helpViewModel: HelpViewModel
    @ObservedObject var userViewModel: UserViewModel
    
    @Binding var cards: [CardModel]
    var canDeleteCard: Bool = false
    var onDetailViewTapped: (CardModel) -> Void
    
    var body: some View {
        VStack { // Todo Scroll View
            List {
                Section(footer: Spacer().frame(height: 80)) {
                    ForEach(cards) { card in
                        Card(model: card)
                            .resetRowStyle(
                                top: 6, leading: 16, bottom: 12, trailing: 16
                            )
                            .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                                Button(role: .destructive) {
                                    Task {
                                        await helpViewModel.deleteHelp(card.helpId)
                                        await userViewModel.fetchUser(id: userViewModel.user.id)
                                    }
                                } label: { Label("Delete", systemImage: "trash") }
                            }
                            .onTapGesture {
                                onDetailViewTapped(card)
                            }
                    }
                }
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
        }
    }
}
