//
//  CustomSegmentedPicker.swift
//  ADA-C2-Helping
//
//  Created by Donggyun Yang on 4/16/25.
//

import SwiftUI

struct CustomSegmentedPicker: View {
    var datas: [MajorType]
    @Binding var selectedData: String
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(datas, id: \.self) { data in
                Button {
                    selectedData = data.rawValue
                } label: {
                    NotoSansText(
                        data.rawValue,
                        NotoSansStyle(
                            fontStyle: .medium
                            , size: 15
                            , color: data.rawValue == selectedData
                                        ? .white
                                        : .gray666
                        )
                    )
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .background(
                        data.rawValue == selectedData
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

struct CustomSegmentedPicker_Previews: View {
    @State private var selectedData: String = MajorType.allCases.first?.rawValue ?? ""

    var body: some View {
        CustomSegmentedPicker(
            datas: MajorType.allCases,
            selectedData: $selectedData
        )
        .padding(.horizontal, 50)
    }
}

#Preview {
    CustomSegmentedPicker_Previews()
}
