//
//  HomeView.swift
//  ADA-C2-Helping
//
//  Created by Donggyun Yang on 4/11/25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            // Header
            Header()
            
            // List Content
            Text("테스트입니다~")
                .font(Font.custom("NotoSansKR", size: 13))
            
            // FAB
            Spacer()
        }
    }
}

#Preview {
    HomeView()
}
