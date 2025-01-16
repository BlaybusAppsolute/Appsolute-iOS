//
//  UserManager.swift
//  Appsolute
//
//  Created by 권민재 on 1/15/25.
//


class UserManager {
    @UserDefault(key: "currentUser", defaultValue: nil)
    private var currentUser: User?

    static let shared = UserManager()

    private init() {}

    // 저장 (로그인 시 호출)
    func saveUser(_ user: User) {
        currentUser = user
        print("✅ UserDefaults에 User 저장 완료: \(user)")
    }

    // 불러오기
    func getUser() -> User? {
        return currentUser
    }

    // 삭제 (로그아웃 시 호출)
    func deleteUser() {
        currentUser = nil
        print("✅ UserDefaults에서 User 삭제 완료")
    }
}
