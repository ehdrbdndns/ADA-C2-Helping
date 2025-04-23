//
//  HelpService.swift
//  ADA-C2-Helping
//
//  Created by Donggyun Yang on 4/21/25.
//

import Foundation
import FirebaseDatabase

final class HelpService {
    static let shared = HelpService()
    private let db = Database.database().reference()

    func fetchAllHelps() async throws -> [Help] {
        let helpRef = db.child("helps");
        
        return try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<[Help], Error>) in
            
            helpRef.keepSynced(false);
            helpRef.observeSingleEvent(of: .value, with: { snapshot in
                
                var helps: [Help] = [];
                
                if let dict = snapshot.value as? [String: [String: Any]] {
                    dict.forEach { (key, value) in
                        helps.append(Help(id: key, data: value))
                    }
                }
                
                continuation.resume(returning: helps)
            })
        }
    }
    
    func createHelp(_ help: Help) async throws -> String {
        let ref = self.db.child("helps").childByAutoId()
        let helpId = try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<String, Error>) in
            ref.setValue(help.toDictionary()) { error, _ in
                if let error = error {
                    continuation.resume(throwing: error)
                } else if let key = ref.key {
                    continuation.resume(returning: key)
                } else {
                    continuation.resume(throwing: NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "ID 생성 실패"]))
                }
            }
        }
        return helpId
    }

    func deleteHelp(_ helpId: String) async throws -> Void {
        let ref = self.db.child("helps")
        try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Void, Error>) in
            ref.child(helpId).removeValue { error, _ in
                if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume()
                }
            }
        }
    }
    
    func updateHelperOfHelp(helpId: String, helperId: String, isBeingHelped: Bool) async throws -> Void {
        let ref = self.db.child("helps").child(helpId);
        try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Void, Error>) in
            
            ref.observeSingleEvent(of: .value, with: { snapshot in
                if var value = snapshot.value as? [String: Any] {
                    value["helperId"] = helperId
                    value["isBeingHelped"] = isBeingHelped
                    
                    ref.setValue(value) { error, _ in
                        if let error = error {
                            continuation.resume(throwing: error)
                        } else {
                            continuation.resume()
                        }
                    }
                }
            })
        }
    }
    
}

