//
//  Header.swift
//  ADA-C2-Helping
//
//  Created by Donggyun Yang on 4/11/25.
//

import SwiftUI

struct Header: View {
    @Binding var cards: [CardModel]
    
    var body: some View {
        HStack {
            Image("logo")
            
            Spacer()
            
            NavigationLink {
                MyView(cards: $cards)
                    .navigationTitle("나의 기록")
            } label: {
                Image("list-bullet")
            }
        }
    }
}
