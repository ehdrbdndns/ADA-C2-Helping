//
//  CreateHelpView.swift
//  ADA-C2-Helping
//
//  Created by Donggyun Yang on 4/16/25.
//

import SwiftUI

struct FormSection<Content: View>: View {
    let title: String
    let content: () -> Content
    
    init(_ title: String, @ViewBuilder content: @escaping () -> Content) {
        self.title = title;
        self.content = content
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            // Title
            NotoSansText(
                title,
                NotoSansStyle(fontStyle: .medium, size: 15, color: Color.gray666)
            )
            
            // Content
            content()
        }
    }
}

struct CreateHelpView: View {
    @State private var selectedMajor: String = MajorType.tech.rawValue
    @State private var title: String = ""
    @State private var content: String = ""
    
    var body: some View {
        VStack(spacing: 16) {
            // 요청 분야
            FormSection("요청 분야") {
                MajorSegmentedPicker(datas: MajorType.allCases, selectedData: $selectedMajor)
            }
            
            // 제목
            FormSection("제목") {
                TextField(
                    "제목을 입력하세요",
                    text: $title
                )
                .font(.custom("NotoSansKR-Regular", size: 17))
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(.empty, in: RoundedRectangle(cornerRadius: 8))
            }
            
            // 내용
            FormSection("내용") {
                ZStack(alignment: .topLeading) {
                    TextEditor(
                        text: $content
                    )
                    .font(.custom("NotoSansKR-Regular", size: 17))
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .background(.empty, in: RoundedRectangle(cornerRadius: 8))
                    .scrollContentBackground(.hidden)
                    
                    if(content.isEmpty) {
                        NotoSansText(
                            "내용을 입력하세요"
                            , NotoSansStyle(fontStyle: .regular, size: 17, color: Color.gray.opacity(0.5))
                        )
                        .padding(.horizontal, 19)
                        .padding(.vertical, 20)
                    }
                }
            }
            
            CustomButton(text: "글 작성하기") {
                
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(24)
    }
}

#Preview {
    CreateHelpView()
}
