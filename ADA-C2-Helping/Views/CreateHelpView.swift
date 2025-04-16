//
//  CreateHelpView.swift
//  ADA-C2-Helping
//
//  Created by Donggyun Yang on 4/16/25.
//

import SwiftUI

struct CreateHelpView: View {
    @State private var selectedMajor: MajorType = .tech
    
    var body: some View {
        VStack {
            // TODO: 요청 분야
            VStack(alignment: .leading) {
                // Title
                NotoSansText(
                    "요청 분야",
                    NotoSansStyle(fontStyle: .medium, size: 13, color: Color.gray666)
                )
                
                // Content
                Picker("", selection: $selectedMajor) {
                    ForEach(MajorType.allCases) { major in
                        NotoSansText(
                            major.rawValue,
                            NotoSansStyle(fontStyle: .medium, size: 15, color: Color.gray666)
                        ).tag(major)
                    }
                }
                .pickerStyle(.segmented)
                .foregroundStyle(Color.accentColor)
            }
            .frame(maxWidth: .infinity)
            
            // TODO: 제목
            
            // TODO: 내용
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(24)
        .border(.red, width: 2)
    }
}

#Preview {
    CreateHelpView()
}
