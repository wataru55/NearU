//
//  ProfileView.swift
//  InstagramTutorial
//
//  Created by  髙橋和 on 2024/04/30.
//

import SwiftUI

struct ProfileView: View {
    //MARK: - property
    let user: User //他人のユーザ情報
    let currentUser: User //自身のユーザ情報
    static let shared = AuthService()
    let GridItems : [GridItem] = Array(repeating: .init(.flexible(), spacing: 2), count: 3)

    var body: some View {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    //header
                    ProfileHeaderView(user: user)

                    Divider()
                    //post grid view

                    if !user.isPrivate || currentUser.connectList.contains(user.id){
                        LazyVGrid(columns: GridItems, spacing: 2, content: {
                            ForEach(0...15, id: \.self) { index in
                                Image("avengers")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 80, height: 80)
                                    .clipped()

                            }
                        })//lazyvgrid
                    } else {
                        Spacer()
                        Text("このユーザは非公開です")
                        Spacer()
                    }
                }//Vstack
            }//scrollView
            .navigationTitle(user.username)
            .navigationBarTitleDisplayMode(.inline)
    }//body
}//view

#Preview {
    ProfileView(user: User.MOCK_USERS[0], currentUser: User.MOCK_USERS[1])
}
