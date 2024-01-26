//
//  ContentView.swift
//  TicTacToe
//
//  Created by Андрей  on 12.01.2024.
//

import SwiftUI

struct ContentView: View {
    private var columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    @State private var moves: [Move?] = Array(repeating: nil, count: 9)
    @State private var isGameBoardDisabled: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                LazyVGrid(columns: columns, spacing: 5) {
                    ForEach(0..<9) { i in
                        ZStack {
                            Circle()
                                .foregroundColor(.red.opacity(0.5))
                                .frame(width: geometry.size.width/3 - 15, height: geometry.size.width/3 - 15)
                            Image(systemName: moves[i]?.indicator ?? "")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .font(.headline)
                                .foregroundColor(.white)
                                
                        }
                        .onTapGesture {
                            if isSquareOccupied(in: moves, forIndex: i) {
                                moves[i] = Move(player: .human, boardIndex: i)
                                isGameBoardDisabled = true
                                
                                if checkWinCondition(for: .human, in: moves) {
                                    print("Human wins")
                                }
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    let position = determineComputerMovePosition(in: moves)
                                    print("Position for comp try is \(position)")
                                    moves[position] = Move(player: .computer, boardIndex: position)
                                    isGameBoardDisabled = false
                                    
                                    if checkWinCondition(for: .computer, in: moves) {
                                        print("Computer wins")
                                    }
                                }
                            }
                        }
                    }
                }
                Spacer()
            }
            .disabled(isGameBoardDisabled)
            .padding()
        }
    }
    
    
     // Functions
    
    func isSquareOccupied(in moves: [Move?], forIndex index: Int) -> Bool {
        return !moves.contains(where: { $0?.boardIndex == index})
    }
    
    func determineComputerMovePosition(in moves: [Move?]) -> Int  {
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
}


enum Player {
    case human, computer
}

struct Move {
    let player: Player
    let boardIndex: Int
    
    var indicator: String {
        return player == .human ? "xmark": "circle"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
