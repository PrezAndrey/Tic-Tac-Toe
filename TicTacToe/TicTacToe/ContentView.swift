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
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                LazyVGrid(columns: columns, spacing: 5) {
                    ForEach(1..<9) { elment in
                        ZStack {
                            Circle()
                                .foregroundColor(.red.opacity(0.5))
                                .frame(width: geometry.size.width/3 - 15, height: geometry.size.width/3 - 15)
                        }
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
