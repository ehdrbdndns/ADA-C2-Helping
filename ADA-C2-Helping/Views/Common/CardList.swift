//
//  CardList.swift
//  ADA-C2-Helping
//
//  Created by Donggyun Yang on 4/14/25.
//

import SwiftUI

struct CardList: View {
    var cardModels: [CardModel]
    
    var body: some View {
        VStack { // Todo Scroll View
            List(cardModels) { model in
                Card(model: model)
                    .listRowSeparator(.hidden)
                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                        Button(role: .destructive) {
                            
                        } label: { Label("Delete", systemImage: "trash") }
                        
                        Button {
                                
                        } label: { Label("Flag", systemImage: "flag") }
                    }
            }
            .listStyle(.plain)
        }
    }
}

#Preview {
    let testDatas: [CardModel] = [
        CardModel(text: "나는 이런 도움이 필요해요. 근데 혼자서 해보려니까 잘 되지 않아요... 누가 좀 도와주세요!!!", name: "pray", major: .tech),
        CardModel(text: "나는 이런 도움이 필요해요. 근데 혼자서 해보려니까 잘 되지 않아요... 누가 좀 도와주세요!!!", name: "pray", major: .design),
        CardModel(text: "나는 이런 도움이 필요해요. 근데 혼자서 해보려니까 잘 되지 않아요... 누가 좀 도와주세요!!!", name: "pray", major: .domain),
        CardModel(text: "나는 이런 도움이 필요해요. 근데 혼자서 해보려니까 잘 되지 않아요... 누가 좀 도와주세요!!!", name: "pray", major: .tech),
        CardModel(text: "나는 이런 도움이 필요해요. 근데 혼자서 해보려니까 잘 되지 않아요... 누가 좀 도와주세요!!!", name: "pray", major: .design),
        CardModel(text: "나는 이런 도움이 필요해요. 근데 혼자서 해보려니까 잘 되지 않아요... 누가 좀 도와주세요!!!", name: "pray", major: .domain),
        CardModel(text: "나는 이런 도움이 필요해요. 근데 혼자서 해보려니까 잘 되지 않아요... 누가 좀 도와주세요!!!", name: "pray", major: .tech),
        CardModel(text: "나는 이런 도움이 필요해요. 근데 혼자서 해보려니까 잘 되지 않아요... 누가 좀 도와주세요!!!", name: "pray", major: .design),
        CardModel(text: "나는 이런 도움이 필요해요. 근데 혼자서 해보려니까 잘 되지 않아요... 누가 좀 도와주세요!!!", name: "pray", major: .domain)
    ]
    CardList(cardModels: testDatas)
}
