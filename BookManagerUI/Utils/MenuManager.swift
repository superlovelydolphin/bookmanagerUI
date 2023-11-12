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
        
    init() {
        resetMenu()
    }
    
    func resetMenu() {
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
        switch input {
        case "1":
            consoleText += "\n회원 관리 메뉴입니다.\n"
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
        consoleText += "명령을 입력하십시오: " // 다음 명령어 입력 안내
    }
}

