//
//  CustomSegmentedPicker.swift
//  ADA-C2-Helping
//
//  Created by Donggyun Yang on 4/16/25.
//

import SwiftUI

struct MajorSegmentedPicker: View {
    var datas: [MajorType]
    @Binding var selectedData: MajorType
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(datas, id: \.self) { data in
                Button {
                    selectedData = data
                } label: {
                    NotoSansText(
                        data.rawValue,
                        NotoSansStyle(
                            fontStyle: .medium
                            , size: 15
                            , color: data == selectedData
                                        ? .white
                                        : .gray666
                        )
                    )
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .background(
                        data == selectedData
                            ? data.color
                            : Color.clear
                    )
                }
            }
        }
        .frame(maxWidth: .infinity)
        .background(Color.empty, in: RoundedRectangle(cornerRadius: 8))
    }
}
