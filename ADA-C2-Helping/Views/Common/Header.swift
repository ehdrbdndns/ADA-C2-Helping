//
//  Header.swift
//  ADA-C2-Helping
//
//  Created by Donggyun Yang on 4/11/25.
//

import SwiftUI

struct Header: View {
    @Binding var cards: [CardModel]
    @Binding var selectedCard: CardModel?
    var user: User
    var onMyViewTapped: () -> Void
    
    var body: some View {
        HStack {
            Image("logo")
            
            Spacer()
            
            Button {
                onMyViewTapped()
            } label: {
                Image("list-bullet")
            }
        }
    }
}
