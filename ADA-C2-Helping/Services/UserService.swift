//
//  UserService.swift
//  ADA-C2-Helping
//
//  Created by Donggyun Yang on 4/22/25.
//

import Foundation
import FirebaseDatabase

final class UserService {
    static let shared = UserService()
    private let db = Database.database().reference()
    
    func fetchUser(id: String) async throws -> User {
        let ref = self.db.child("users").child(id)
        return try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<User, Error>) in
            ref.keepSynced(false)
            ref.observeSingleEvent(of: .value, with: {snapshot in
                if let user = snapshot.value as? [String: Any] {
                    continuation.resume(returning: User(id: id, data: user))
                } else {
                    continuation.resume(throwing: NSError(
                        domain: "Firebase",
                        code: -1,
                        userInfo: [NSLocalizedDescriptionKey: "사용자 정보를 불러오지 못했습니다."]
                    ))
                }
            })
        }
    }
    
    func createUser(user: User) async throws {
        let ref = self.db.child("users").childByAutoId()
        try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Void, Error>) in
            ref.setValue(user.toDictionary()) { error, _ in
                if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume()
                }
            }
        }
    }
    
    func appendWrittenHelpFrom(user: User, helpId: String) async throws {
        let ref = self.db.child("users").child(user.id).child("writtenHelp")
        try await withCheckedThrowingContinuation{ (continuation: CheckedContinuation<Void, Error>) in
            ref.observeSingleEvent(of: .value, with: { snapshot in
                var current = snapshot.value as? [String: Bool] ?? [:]
                current[helpId] = true;
                
                ref.setValue(current) { error, _ in
                    if let error = error {
                        continuation.resume(throwing: error)
                    } else {
                        continuation.resume()
                    }
                }
            })
        }
    }
    
    func appendHelpingFrom(userId: String, helpId: String) async throws {
        let ref = self.db.child("users").child(userId).child("helpingHelp")
        try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Void, Error>) in
            ref.observeSingleEvent(of: .value, with: {snapshot in
                var current = snapshot.value as? [String: Bool] ?? [:]
                current[helpId] = true
                
                ref.setValue(current) { error, _ in
                    if let error = error {
                        continuation.resume(throwing: error)
                    } else {
                        continuation.resume()
                    }
                }
            })
        }
    }
}
