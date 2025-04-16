//
//  MajorType.swift
//  ADA-C2-Helping
//
//  Created by Donggyun Yang on 4/16/25.
//
import SwiftUI

enum MajorType: String, CaseIterable, Identifiable {
    case tech = "Tech"
    case design = "Design"
    case domain = "Domain"
    
    var id: String {
        self.rawValue;
    }
    
    var color: Color {
        switch self {
        case .tech:
            return .accentColor
        case .design:
            return Color("DesignColor")
        case .domain:
            return Color("DomainColor")
        }
    }
}
