//
//  GameViewModel.swift
//  TicTacToe
//
//  Created by Андрей  on 29.02.2024.
//

import SwiftUI

final class GameViewModel: ObservableObject {
    var columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    @Published var moves: [Move?] = Array(repeating: nil, count: 9)
    @Published var isGameBoardDisabled: Bool = false
    @Published var alertItem: AlertItem?
    
    
    // Functions
   
   func isSquareOccupied(in moves: [Move?], forIndex index: Int) -> Bool {
       return !moves.contains(where: { $0?.boardIndex == index})
   }
   
   
   // if AI can win it wins
   // if AI can't win, it blocks
   // if AI can't block, it takes the middle slot
   // if AI can't take the middle, it takes a random available slot
   func determineComputerMovePosition(in moves: [Move?]) -> Int  {
       
       // if AI can win, it wins
       let winPatterns: Set<Set<Int>> = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
       
       let computerMoves = moves.compactMap { $0 }.filter { $0.player == .computer }
       let computerPositions = Set(computerMoves.map({ $0.boardIndex }))
       
       for pattern in winPatterns {
           let winPositions = pattern.subtracting(computerPositions)
           
           if winPositions.count == 1 {
               let isAvailable = !isSquareOccupied(in: moves, forIndex: winPositions.first!)
               if isAvailable { return winPositions.first! }
           }
       }
       
       // if AI can't win, it blocks
       let humanMoves = moves.compactMap { $0 }.filter { $0.player == .human }
       let humanPositions = Set(humanMoves.map({ $0.boardIndex }))
       
       for pattern in winPatterns {
           let winPositions = pattern.subtracting(humanPositions)
           
           if winPositions.count == 1 {
               let isAvailable = !isSquareOccupied(in: moves, forIndex: winPositions.first!)
               if isAvailable { return winPositions.first! }
           }
       }
       // if AI can't block, it takes the middle slot
       let center = 4
       if !isSquareOccupied(in: moves, forIndex: 4) {
           return center
       }
       
       // if AI can't take the middle, it takes a random available slot
       
       var position = Int.random(in: 0..<9)
       while !isSquareOccupied(in: moves, forIndex: position) {
           position = Int.random(in: 0..<9)
       }
       return position
   }
   
   func checkWinCondition(for player: Player, in moves: [Move?]) -> Bool {
       
       let winPatterns: Set<Set<Int>> = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
       
       let playerMoves = moves.compactMap { $0 }.filter { $0.player == player }
       let playerPositions = Set(playerMoves.map { $0.boardIndex })
       
       for pattern in winPatterns where pattern.isSubset(of: playerPositions) { return true }
       
       return false
   }
   
   func checkForDraw(in moves: [Move?]) -> Bool {
       return moves.compactMap { $0 }.count == 9 && !checkWinCondition(for: .human, in: moves) && !checkWinCondition(for: .computer, in: moves)
   }
   
   func resetGame() {
       moves = Array(repeating: nil, count: 9)

   }
}
