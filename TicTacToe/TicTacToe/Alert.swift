//
//  Alert.swift
//  TicTacToe
//
//  Created by Андрей  on 07.02.2024.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    var title: Text
    var message: Text
    var buttonTitle: Text
}

struct AlertContext {
    let humanWins = AlertItem(title: Text("You win!"),
                              message: Text("You are so smart! You beat your own AI"),
                              buttonTitle: Text("Hell yeah"))
    
    let computerWins = AlertItem(title: Text("You lost"),
                                 message: Text("You programmed a super smart AI"),
                                 buttonTitle: Text("Rematch"))
    
    let draw = AlertItem(title: Text("Draw"),
                         message: Text("What a battle"),
                         buttonTitle: Text("Try again"))
}
