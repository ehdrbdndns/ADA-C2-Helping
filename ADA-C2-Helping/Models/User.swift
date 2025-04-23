//
//  User.swift
//  ADA-C2-Helping
//
//  Created by Donggyun Yang on 4/21/25.
//

import Foundation

struct User: Codable {
    var id: String
    var name: String
    var profileImage: String
    var major: MajorType
    var writtenHelps: [String] // [Help_id]
    var helpingHelps: [String] // [Help_id]
    
    func toDictionary() -> [String: Any] {
        return [
            "name": name,
            "profileImage": profileImage,
            "major": major.rawValue,
            "writtenHelp": writtenHelps.reduce(into: [String: Bool]()) {
                $0[$1] = true
            },
            "helpingHelp": helpingHelps.reduce(into: [String: Bool]()) {
                $0[$1] = true
            }
        ]
    }
    
    // MARK: Firebase 데이터 담는 용도
    init(id: String, data: [String: Any]) {
        self.id = id
        self.name = data["name"] as? String ?? ""
        self.profileImage = data["profileImage"] as? String ?? ""
        self.major = MajorType(rawValue: data["major"] as? String ?? "") ?? .tech
        if let written = data["writtenHelp"] as? [String: Bool] {
            self.writtenHelps = Array(written.keys)
        } else {
            self.writtenHelps = []
        }
        if let helping = data["helpingHelp"] as? [String: Bool] {
            self.helpingHelps = Array(helping.keys)
        } else {
            self.helpingHelps = []
        }
    }
    
    // MARK: Test Default User
    init() {
        self.id = "-OORPrDSXHpRF3H-3ZqL"
        self.name = "pray"
        self.profileImage = "default-card"
        self.major = .tech
        self.writtenHelps = []
        self.helpingHelps = []
    }
}
