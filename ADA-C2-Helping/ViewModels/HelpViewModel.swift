//
//  HelpViewModel.swift
//  ADA-C2-Helping
//
//  Created by Donggyun Yang on 4/21/25.
//

import Foundation

@MainActor
class HelpViewModel: ObservableObject {
    @Published var isSuccess = false
    @Published var isLoading = false
    @Published var error: String?
    @Published var helps: [Help] = []
    
    func initState() {
        self.isSuccess = false
        self.isLoading = false
        self.error = nil
    }
    
    func fetchHelps() async {
        initState();
        
        self.isLoading = true
        
        do {
            let helps = try await HelpService.shared.fetchAllHelps();
            let sortedHelps = helps.sorted { $0.createdAt > $1.createdAt }
            self.helps = sortedHelps
            self.isSuccess = true
        } catch {
            self.error = error.localizedDescription
        }
        
        self.isLoading = false
    }
    
    func createHelp(title: String, content: String, major: MajorType, user: User) async {
        initState();
        
        self.isLoading = true
        
        let help = Help(authorId: user.id, nickname: user.name, profile: user.profileImage, title: title, content: content, major: major)
        
        do {
            let helpId = try await HelpService.shared.createHelp(help)
            try await UserService.shared.appendWrittenHelpFrom(user: user, helpId: helpId)
            self.isSuccess = true
            helps.insert(help, at: 0)
            
            await fetchHelps()
        } catch {
            self.error = error.localizedDescription
        }
        
        self.isLoading = false
    }
    
    func updateHelperOfHelp(userId: String, helpId: String, helperId: String, isBeingHelped: Bool) async {
        initState()
        
        self.isLoading = true
        
        do {
            try await HelpService.shared.updateHelperOfHelp(
                helpId: helpId
                , helperId: helperId
                , isBeingHelped: isBeingHelped
            )
            try await UserService.shared.appendHelpingFrom(userId: userId, helpId: helpId)
            self.isSuccess = true
            await fetchHelps()
        } catch {
            self.error = error.localizedDescription
        }
        
        self.isLoading = false
    }
    
    func deleteHelp(_ helpId: String) async {
        initState()
        
        self.isLoading = true
        
        do {
            try await HelpService.shared.deleteHelp(helpId)
            self.isSuccess = true
        } catch {
            self.error = error.localizedDescription
        }
        
        self.isLoading = false
    }
}
