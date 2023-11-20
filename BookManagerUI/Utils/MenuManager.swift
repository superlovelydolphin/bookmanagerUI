//
//  MenuManager.swift
//  BookManagerUI
//
//  Created by vbflash on 11/12/23.
//

import Foundation

class MenuManager: ObservableObject {
    @Published var consoleText: String = ""
    @Published var shouldTerminate: Bool = false
    @Published var currentMenu: String = "main"
    
    var userManager = UserManager() // UserManager 인스턴스
        
    
    // 추가: 회원 등록을 위한 상태 변수들
    enum RegistrationState {
        case idle
        case awaitingName
        case awaitingAge
        case awaitingMemberID
        case awaitingPhoneNumber
        case completed
    }
    
    @Published var registrationState: RegistrationState = .idle
    var newUser = User(name: "", age: 0, memberID: 0, phoneNumber: "", booksRented: 0)
       
    
    
    init() {
        resetMenu()
    }
    
    func resetMenu() {
        currentMenu = "main"
        consoleText = """
        Console Ready
        1. 회원 관리
        2. 도서 관리
        3. 도서 대여/반납 관리
        4. 검색
        5. 저장 & 종료
        6. 종료
        명령을 입력하십시오:
        """
    }
    
    func handleInput(_ input: String) {
        if currentMenu == "main" {
            switch input {
            case "1":
                currentMenu = "memberManagement"
                consoleText += "\n회원 관리 메뉴입니다.\n"
                showMemberManagementMenu()
            case "2":
                consoleText += "\n도서 관리 메뉴입니다.\n"
            case "3":
                consoleText += "\n도서 대여/반납 관리 메뉴입니다.\n"
            case "4":
                consoleText += "\n검색 메뉴입니다.\n"
            case "5":
                consoleText += "\n데이터를 저장하고 앱을 종료합니다.\n"
                // 데이터 저장 로직을 추가합니다.
                // 앱을 종료합니다.
                shouldTerminate = true
            case "6":
                consoleText += "\n앱을 종료합니다.\n"
                // 앱을 종료합니다.
                shouldTerminate = true
            default:
                consoleText += "\n알 수 없는 명령입니다. 다시 시도하십시오.\n"
            }
        } else if currentMenu == "memberManagement" {
            handleMemberManagementInput(input)
        }
        
        // consoleText += "명령을 입력하십시오: " // 다음 명령어 입력 안내
    }
    
    func showMemberManagementMenu() {
           consoleText += """
           \n회원 관리 메뉴
           1. 회원 등록
           2. 회원 검색
           3. 회원 목록보기
           4. 저장하기
           5. 상위메뉴 이동
           """
       }
       
    // 수정: 회원 관리 메뉴 입력 처리
    func handleMemberManagementInput(_ input: String) {
        switch input {
        case "1":
            consoleText += "\n회원 등록을 시작합니다.\n이름을 입력하세요:\n"
            registrationState = .awaitingName
        case "2":
            consoleText += "\n2"
            // 회원 검색
            /*
            if let user = userManager.readUser(memberID: userData.memberID) {
                consoleText += "\n검색된 회원 정보: 이름: \(user.name), 나이: \(user.age), 전화번호: \(user.phoneNumber), 대여도서 수: \(user.booksRented)\n"
            } else {
                consoleText += "\n회원번호 \(userData.memberID)에 해당하는 회원이 없습니다.\n"
            }*/
            
        case "3":
            // 회원 목록
            consoleText = "\n회원 목록:\n"
            for user in userManager.listUsers() {
                consoleText += "ID: \(user.memberID), 이름: \(user.name), 나이: \(user.age), 전화번호: \(user.phoneNumber), 대여도서 수: \(user.booksRented)\n"
            }
        case "4":
            // 데이터 저장
            userManager.saveData()
            consoleText += "\n데이터가 저장되었습니다.\n"
        case "5":
            resetMenu()
        default:
            if registrationState != .idle {
                handleRegistrationInput(input)
            } else {
                consoleText += "\n알 수 없는 명령입니다. 다시 시도하십시오.\n"
            }
        }
    }
    
    // 새로 추가: 회원 등록 과정을 처리하는 메소드
        func handleRegistrationInput(_ input: String) {
            switch registrationState {
            case .awaitingName:
                newUser.name = input
                consoleText += "나이를 입력하세요:\n"
                registrationState = .awaitingAge
            case .awaitingAge:
                if let age = Int(input), age > 0 {
                    newUser.age = age
                    consoleText += "회원번호를 입력하세요:\n"
                    registrationState = .awaitingMemberID
                } else {
                    consoleText += "유효한 나이를 입력하세요:\n"
                }
            case .awaitingMemberID:
                if let memberID = Int(input) {
                    newUser.memberID = memberID
                    consoleText += "전화번호를 입력하세요:\n"
                    registrationState = .awaitingPhoneNumber
                } else {
                    consoleText += "유효한 회원번호를 입력하세요:\n"
                }
            case .awaitingPhoneNumber:
                newUser.phoneNumber = input
                consoleText += "회원 등록이 완료되었습니다.\n"
                userManager.createUser(name: newUser.name, age: newUser.age, memberID: newUser.memberID, phoneNumber: newUser.phoneNumber, booksRented: newUser.booksRented)
                registrationState = .completed
                // 회원 등록 후 상위 메뉴로 돌아가거나 추가 동작을 수행할 수 있습니다.
                resetMenu()
            default:
                consoleText += "회원 등록 과정에 오류가 발생했습니다.\n"
                registrationState = .idle
            }
        }
}

