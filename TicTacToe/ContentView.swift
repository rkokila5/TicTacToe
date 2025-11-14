//
//  ContentView.swift
//  TicTacToe
//
//  Created by Kokila on 14/11/25.
//

import SwiftUI

struct ContentView: View {
    @State private var board: [String] = Array(repeating: "", count: 9)
    @State private var currentPlayer: String = "X"
    @State private var winner: String? = nil
    @State private var moves = 0

    private let winPatterns: [[Int]] = [
        [0,1,2], [3,4,5], [6,7,8],
        [0,3,6], [1,4,7], [2,5,8],
        [0,4,8], [2,4,6]
    ]

    var body: some View {
        VStack(spacing: 20) {
            Text("Tic-Tac-Toe")
                .font(.title)
                .bold()

            Text(statusText)
                .font(.subheadline)

            VStack(spacing: 6) {
                ForEach(0..<3) { row in
                    HStack(spacing: 6) {
                        ForEach(0..<3) { col in
                            let index = row * 3 + col
                            Button(action: {
                                cellTapped(at: index)
                            }) {
                                Text(board[index])
                                    .font(.system(size: 36, weight: .bold))
                                    .frame(width: 80, height: 80)
                                    .background(Color(UIColor.secondarySystemBackground))
                                    .cornerRadius(8)
                            }
                            .disabled(board[index] != "" || winner != nil)
                        }
                    }
                }
            }

            Button("Reset") {
                resetGame()
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .background(Color(UIColor.systemGray5))
            .cornerRadius(8)

            Spacer()
        }
        .padding()
    }

    private var statusText: String {
        if let w = winner {
            return w == "Draw" ? "It's a draw." : "\(w) wins!"
        } else {
            return "Current: \(currentPlayer)"
        }
    }

    private func cellTapped(at index: Int) {
        guard board[index] == "" && winner == nil else { return }
        board[index] = currentPlayer
        moves += 1

        if let w = checkWinner() {
            winner = w
        } else if moves == 9 {
            winner = "Draw"
        } else {
            currentPlayer = (currentPlayer == "X") ? "O" : "X"
        }
    }

    private func checkWinner() -> String? {
        for pattern in winPatterns {
            let values = pattern.map { board[$0] }
            if values[0] != "" && values[0] == values[1] && values[1] == values[2] {
                return values[0]
            }
        }
        return nil
    }

    private func resetGame() {
        board = Array(repeating: "", count: 9)
        currentPlayer = "X"
        winner = nil
        moves = 0
    }
}

#Preview {
    ContentView()
}
