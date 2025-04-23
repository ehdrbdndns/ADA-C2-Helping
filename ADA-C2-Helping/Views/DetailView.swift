//
//  DetailView.swift
//  ADA-C2-Helping
//
//  Created by Donggyun Yang on 4/17/25.
//

import SwiftUI

struct DetailView: View {
    
    var content: CardModel
    var modalMessage: String = """
안녕! 나는 Pray이고 
앱을 통해 너가 도움을 요청한 걸 봤어.
내가 그 부분을 도와줄 수 있어서 연락해!
"""
    @ObservedObject var helpViewModel: HelpViewModel
    @ObservedObject var userViewModel: UserViewModel
    
    @State var isTeamsPresented: Bool = false;
    @State var isCompletedPresented: Bool = false;
    
    var onMyViewTapped: () -> Void
    
    var body: some View {
        ZStack {
            DetailView
            
            if(isTeamsPresented) {
                Button {
                    isTeamsPresented = false
                    isCompletedPresented = false
                } label: {
                    Color.black.opacity(0.5).ignoresSafeArea(edges: .all)
                }
                TeamsModal
            }
            
            if(isCompletedPresented) {
                Button {
                    isTeamsPresented = false
                    isCompletedPresented = false
                } label: {
                    Color.black.opacity(0.5).ignoresSafeArea(edges: .all)
                }
                CompleteModal
            }
        }
        .navigationTitle("도움이 필요해핑!")
    }
    
    var DetailView: some View {
        VStack(spacing: 24) {
            // TODO: Profile
            HStack() {
                // Image
                Image(content.image)
                    .resizable()
                    .frame(width: 64, height: 64)
                    .aspectRatio(contentMode: .fit)
                
                VStack(alignment: .leading, spacing: 10) {
                    // nickname
                    NotoSansText(
                        "닉네임: \(content.name)"
                        , NotoSansStyle(size: 14)
                    )
                    
                    // major
                    NotoSansText(
                        "도움 요청 분야: \(content.major)"
                        , NotoSansStyle(size: 14)
                    )
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            // TODO: Content
            VStack(alignment: .leading, spacing: 12) {
                // title
                NotoSansText(
                    content.title
                    , NotoSansStyle(fontStyle: .bold, size: 20)
                )
                
                // content
                NotoSansText(
                    content.text
                )
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
            
            CustomButton(text: "도움 주기") {
                isTeamsPresented.toggle()
            }
        }
        .padding(.top, 24)
        .padding(.horizontal, 16)
    }
    
    var TeamsModal: some View {
        VStack {
            VStack(alignment: .leading, spacing: 16) {
                // Title
                NotoSansText(
                    "도움을 전해주세요!"
                    , NotoSansStyle(fontStyle: .bold, color: .black)
                )
                
                // Content(can copy)
                VStack(spacing: 6) {
                    HStack(alignment: .top, spacing: 20) {
                        NotoSansText(
                            modalMessage
                            , NotoSansStyle(size: 15)
                        )
                        
                        Button {
                            UIPasteboard.general.string = modalMessage
                        } label: {
                            Image("document")
                        }
                    }
                    .padding(16)
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(.empty)
                    )
                    
                    NotoSansText(
                        "위 메세지를 복사해 팀즈에서 직접 연락해보세요."
                        , NotoSansStyle(fontStyle: .medium, size: 12)
                    )
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
                
                // button
                CustomButton(text: "팀즈 열기") {
                    if let url = URL(string: "msteams://") {
                        if UIApplication.shared.canOpenURL(url) {
                            UIApplication.shared.open(url, options: [:], completionHandler: nil)
                        } else {
                            print("❗️Teams 앱이 설치되어 있지 않습니다.")
                        }
                        
                        isTeamsPresented = false
                        isCompletedPresented = true
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(24)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(.white)
            )
        }
        .padding(.horizontal, 16)
    }
    
    var CompleteModal: some View {
        VStack {
            VStack(spacing: 16) {
                NotoSansText(
                    "도움을 전해줘서 고마워요!"
                    , NotoSansStyle(fontStyle: .bold)
                )
                CustomButton(text: "진행중인 도움 확인하기") {
                    Task {
                        onMyViewTapped()
                        await helpViewModel.updateHelperOfHelp(
                            userId: userViewModel.user.id
                            , helpId: content.helpId
                            , helperId: userViewModel.user.id
                            , isBeingHelped: true
                        )
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(24)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(.white)
            )
        }
        .padding(.horizontal, 16)
    }
}
