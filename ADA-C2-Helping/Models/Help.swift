//
//  Help.swift
//  ADA-C2-Helping
//
//  Created by Donggyun Yang on 4/21/25.
//

import Foundation

struct Help: Codable, Identifiable {
    var id: String
    var title: String
    var content: String
    var major: MajorType
    var isBeingHelped: Bool
    var helperId: String
    var authorId: String
    var authorNickname: String
    var authorProfileImage: String
    var createdAt: TimeInterval
    
    func toDictionary() -> [String: Any] {
        return [
            "title": title,
            "content": content,
            "major": major.rawValue,
            "isBeingHelped": isBeingHelped,
            "helperId": helperId,
            "authorId": authorId,
            "authorNickname": authorNickname,
            "authorProfileImage": authorProfileImage,
            "createdAt": createdAt
        ]
    }
    
    // MARK: - Firebase에서 읽어올 때 key값(id) 포함해서 생성
    init(id: String, data: [String: Any]) {
        self.id = id
        self.title = data["title"] as? String ?? ""
        self.content = data["content"] as? String ?? ""
        self.isBeingHelped = data["isBeingHelped"] as? Bool ?? false
        self.helperId = data["helperId"] as? String ?? ""
        self.authorId = data["authorId"] as? String ?? ""
        self.authorNickname = data["authorNickname"] as? String ?? ""
        self.authorProfileImage = data["authorProfileImage"] as? String ?? ""
        self.createdAt = data["createdAt"] as? TimeInterval ?? 0
        self.major = MajorType(rawValue: data["major"] as? String ?? "") ?? .tech
    }
    
    // MARK: - 새 글 생성용 (id는 자동 생성)
    init(authorId: String, nickname: String, profile: String, title: String, content: String, major: MajorType) {
        self.id = UUID().uuidString
        self.title = title
        self.content = content
        self.authorId = authorId
        self.authorNickname = nickname
        self.authorProfileImage = profile
        self.isBeingHelped = false
        self.helperId = ""
        self.createdAt = Date().timeIntervalSince1970
        self.major = major
    }
}
