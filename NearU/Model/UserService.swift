//
//  UserService.swift
//  InstagramTutorial
//
//  Created by  髙橋和 on 2024/05/07.
//

import Foundation
import Firebase

struct UserService {
    static func fetchUser(withUid uid: String) async throws -> User {
        let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument() //ユーザidを使用してFirestoreDatabaseからドキュメントを取得
        return try snapshot.data(as: User.self) //snapshotからUser型にデータをデコードして値を返す
    }

    static func fetchAllUsers() async throws -> [User] {
        let snapshot = try await Firestore.firestore().collection("users").getDocuments() //usersコレクションのドキュメントを全て取得
        return snapshot.documents.compactMap({ try? $0.data(as: User.self) }) //compactMapメソッドによって一つずつドキュメントを取得し，User型に変換
    }


    static func fetchConnectedUsers(withUid userId: String) async throws -> [User] {
        // First, fetch the user to get their connectList
        let user = try await fetchUser(withUid: userId)
        let connectList = user.connectList

        // Fetch the connected users
        var connectedUsers: [User] = []
        for connectedUserId in connectList {
            let connectedUser = try await fetchUser(withUid: connectedUserId)
            connectedUsers.append(connectedUser)
        }

        return connectedUsers
    }
}
