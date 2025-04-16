//
//  HomeView.swift
//  ADA-C2-Helping
//
//  Created by Donggyun Yang on 4/11/25.
//

import SwiftUI

struct HomeView: View {
    let cards: [CardModel];
    
    var body: some View {
        VStack {
            Header()
                .padding(.bottom, 24)
                .padding(.horizontal, 16)
            
            ZStack(alignment: .bottom) {
                // Todo: Content
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
                    
                    CardList(cardModels: cards)
                }
                
                // Todo: FAB
                VStack {
                    HStack {
                        // Button
                        Button {
                            
                        } label: {
                            Image(systemName: "plus")
                        }
                        .foregroundStyle(.white)
                        .font(.system(size: 30))
                    }
                    .frame(width: 80, height: 80)
                    .background(.accent, in: RoundedRectangle(cornerRadius: 50))
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.top, 16)
                .background(
                    LinearGradient(colors: [Color.white.opacity(0), .white], startPoint: .top, endPoint: UnitPoint(x: 0.5, y: 0.75))
                )
            }
        }
    }
}

#Preview {
    let testDatas: [CardModel] =  [
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
    
    HomeView(cards: testDatas)
}
