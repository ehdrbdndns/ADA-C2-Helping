//
//  Header.swift
//  ADA-C2-Helping
//
//  Created by Donggyun Yang on 4/11/25.
//

import SwiftUI

struct Header: View {
    var body: some View {
        HStack {
            Image("logo")
            
            Spacer()
            
            Image("list-bullet")
        }
    }
}

#Preview {
    Header()
}
