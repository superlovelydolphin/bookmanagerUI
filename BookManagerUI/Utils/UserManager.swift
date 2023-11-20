//
//  UserManager.swift
//  BookManagerUI
//
//  Created by vbflash on 11/20/23.
//

import Foundation


// 사용자 정보를 나타내는 클래스
class User {
    var name: String
    var age: Int
    var memberID: Int
    var phoneNumber: String
    var booksRented: Int

    init(name: String, age: Int, memberID: Int, phoneNumber: String, booksRented: Int) {
        self.name = name
        self.age = age
        self.memberID = memberID
        self.phoneNumber = phoneNumber
        self.booksRented = booksRented
    }
}

// 사용자 정보를 관리하는 클래스
class UserManager {
    var users: [Int: User] = [:] // 회원번호를 키로 사용하는 딕셔너리

    // 사용자 생성
    func createUser(name: String, age: Int, memberID: Int, phoneNumber: String, booksRented: Int) {
        let newUser = User(name: name, age: age, memberID: memberID, phoneNumber: phoneNumber, booksRented: booksRented)
        users[memberID] = newUser
    }
    
    // 사용자 정보 읽기
    func readUser(memberID: Int) -> User? {
        return users[memberID]
    }
    
    // 사용자 정보 갱신
    func updateUser(memberID: Int, name: String?, age: Int?, phoneNumber: String?, booksRented: Int?) {
        guard let user = users[memberID] else { return }
        
        if let name = name {
            user.name = name
        }
        if let age = age {
            user.age = age
        }
        if let phoneNumber = phoneNumber {
            user.phoneNumber = phoneNumber
        }
        if let booksRented = booksRented {
            user.booksRented = booksRented
        }
    }
    
    // 사용자 삭제
    func deleteUser(memberID: Int) {
        users.removeValue(forKey: memberID)
    }
    
    // 모든 사용자 정보 출력
    func printUsers() {
        for user in users.values {
            print("이름: \(user.name), 나이: \(user.age), 회원번호: \(user.memberID), 폰번호: \(user.phoneNumber), 대여도서: \(user.booksRented)")
        }
    }
    
    // 회원 목록
    func listUsers() -> [User] {
        return Array(users.values)
    }
    
    // 데이터 저장 (여기서는 단순화된 예로 표현합니다. 실제로는 파일 시스템이나 데이터베이스에 저장해야 합니다.)
    func saveData() {
        print("데이터 저장됨")
    }
}


/*
// 사용 예
let userManager = UserManager()

// 사용자 생성
userManager.createUser(name: "김지수", age: 25, memberID: 1001, phoneNumber: "010-1234-5678", booksRented: 3)
// 나머지 사용자도 이와 같이 생성할 수 있습니다.

// 사용자 정보 읽기
if let user = userManager.readUser(memberID: 1001) {
    print("사용자 정보: \(user.name)")
}

// 사용자 정보 갱신
userManager.updateUser(memberID: 1001, name: "김지수", age: 26, phoneNumber: nil, booksRented: nil)

// 사용자 삭제
userManager.deleteUser(memberID: 1001)

// 모든 사용자 정보 출력
userManager.printUsers()
*/
