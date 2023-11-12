//
//  ContentView.swift
//  BookManagerUI
//
//  Created by vbflash on 11/12/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var menuManager = MenuManager()
      @State private var inputText: String = ""

       var body: some View {
           VStack {
               TextEditor(text: $menuManager.consoleText)
                   .frame(minWidth: 300, maxWidth: .infinity, minHeight: 300, maxHeight: .infinity)
                   .border(Color.gray, width: 1)
                   .padding()
               
               HStack {
                   TextField("명령을 입력하십시오", text: $inputText)
                       .textFieldStyle(RoundedBorderTextFieldStyle())
                       .onSubmit {
                           menuManager.handleInput(inputText)
                           inputText = "" // 입력 필드 초기화
                       }
                   
                   Button("Enter") {
                       menuManager.handleInput(inputText)
                       inputText = "" // 입력 필드 초기화
                   }
                   
                   Button("Clear") {
                       menuManager.resetMenu()
                   }
                   
               }.padding()
               
           }
           .onChange(of: menuManager.shouldTerminate) { shouldTerminate in
               if shouldTerminate {
                   NSApplication.shared.terminate(nil)
               }
           }
       }
    
}

#Preview {
    ContentView()
}
