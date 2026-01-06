//
//  BoardViewModel.swift
//  Chess
//
//  Created by Jorge de Carvalho on 05/01/26.
//
import SwiftUI


@Observable
class BoardViewModel {
    var board: [[Piece]] = []
    var selectedPiece: Piece?

    init() {
        setupBoard()
    }


    func setupBoard() {
        board = RowPosition.allCases.map { row in
            ColumnPosition.allCases.map { column in
                Piece(
                    type: .pawn,
                    color: .white,
                    boardPosition: BoardPosition(row: row, column: column)
                )
            }
        }
    }

    func setupPieces() {
        // Rook
        board[0][0].type = .rook
        board[0][0].type = .rook
    }
}
