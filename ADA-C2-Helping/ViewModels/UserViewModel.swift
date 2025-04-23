//
//  UserViewModel.swift
//  ADA-C2-Helping
//
//  Created by Donggyun Yang on 4/22/25.
//

import Foundation

@MainActor
class UserViewModel: ObservableObject {
    @Published var isSuccess = false
    @Published var isLoading = false
    @Published var error: String?
    @Published var user: User = User()
    
    func initState() {
        self.isSuccess = false
        self.isLoading = false
        error = nil
    }
    
    func fetchUser(id: String) async {
        initState();
        
        self.isLoading = true
        
        do {
            self.user = try await UserService.shared.fetchUser(id: id)
            self.isSuccess = true
        } catch {
            self.error = error.localizedDescription
        }
        
        self.isLoading = false
    }
}
