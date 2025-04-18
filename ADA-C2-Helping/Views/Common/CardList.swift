//
//  CardList.swift
//  ADA-C2-Helping
//
//  Created by Donggyun Yang on 4/14/25.
//

import SwiftUI

struct CardList: View {
    @Binding var cards: [CardModel]
    @Binding var selectedCard: CardModel?
    
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
                                    
                                } label: { Label("Delete", systemImage: "trash") }
                                
                                Button {
                                    
                                } label: { Label("Flag", systemImage: "flag") }
                            }
                            .onTapGesture {
                                selectedCard = card
                            }
                    }
                }
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
        }
    }
}
