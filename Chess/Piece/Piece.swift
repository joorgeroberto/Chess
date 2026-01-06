//
//  Piece.swift
//  Chess
//
//  Created by Jorge de Carvalho on 05/01/26.
//

import Foundation
import SwiftUI

enum PieceColor {
    case white
    case black
}

enum PieceType: String, CaseIterable {
    case king = "Ki"
    case queen = "Q"
    case rook = "R"
    case bishop = "B"
    case knight = "Kn"
    case pawn = "P"
    case empty = ""
}

enum ColumnPosition: String, CaseIterable {
    case A, B, C, D, E, F, G, H
}

enum RowPosition: Int, CaseIterable {
    case one = 1
    case two
    case three
    case four
    case five
    case six
    case seven
    case eight
}

struct BoardPosition: Hashable {
    let row: RowPosition
    let column: ColumnPosition
}

class Piece: Hashable, Equatable {
    let id: UUID
    var boardPosition: BoardPosition
    var color: PieceColor = .white
    var type: PieceType = .empty
    var possibleMoves: Set<BoardPosition> = []

    init(id: UUID = UUID(), rowPosition: RowPosition, columnPosition: ColumnPosition) {
        self.id = id
        self.boardPosition = BoardPosition(row: rowPosition, column: columnPosition)
        buildPieceColorAndType(boardPosition: boardPosition)
        self.possibleMoves = getPossiblePieceMoves()
    }

    static func == (lhs: Piece, rhs: Piece) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    func buildPieceColorAndType(boardPosition: BoardPosition) {
        switch (boardPosition.column, boardPosition.row) {

            // Rooks
        case (.A, .one), (.H, .one):
            type = .rook
            color = .white

        case (.A, .eight), (.H, .eight):
            type = .rook
            color = .black

            // Knights
        case (.B, .one), (.G, .one):
            type = .knight
            color = .white

        case (.B, .eight), (.G, .eight):
            type = .knight
            color = .black

            // Bishops
        case (.C, .one), (.F, .one):
            type = .bishop
            color = .white

        case (.C, .eight), (.F, .eight):
            type = .bishop
            color = .black

            // Queen
        case (.D, .one):
            type = .queen
            color = .white

        case (.D, .eight):
            type = .queen
            color = .black

            // King
        case (.E, .one):
            type = .king
            color = .white

        case (.E, .eight):
            type = .king
            color = .black

            // Pawns
        case (_, .two):
            type = .pawn
            color = .white

        case (_, .seven):
            type = .pawn
            color = .black

        default:
            type = .empty
        }
    }

    func getPossiblePieceMoves() -> Set<BoardPosition> {
        if self.type == .pawn && self.color == .black {
            if self.boardPosition.row.rawValue > 2 {
                return [
                    BoardPosition(
                        row: RowPosition.allCases[self.boardPosition.row.rawValue - 1],
                        column: self.boardPosition.column
                    ),
                    BoardPosition(
                        row: RowPosition.allCases[self.boardPosition.row.rawValue - 2],
                        column: self.boardPosition.column
                    )
                ]
            }
            if self.boardPosition.row.rawValue > 1 {
                return [
                    BoardPosition(
                        row: RowPosition.allCases[self.boardPosition.row.rawValue - 1],
                        column: self.boardPosition.column
                    )
                ]
            }
            return []
        }
        if self.type == .pawn && self.color == .white {
            if self.boardPosition.row.rawValue < 7 {
                return [
                    BoardPosition(
                        row: RowPosition.allCases[self.boardPosition.row.rawValue + 1],
                        column: self.boardPosition.column
                    ),
                    BoardPosition(
                        row: RowPosition.allCases[self.boardPosition.row.rawValue + 2],
                        column: self.boardPosition.column
                    )
                ]
            }
            if self.boardPosition.row.rawValue < 8 {
                return [
                    BoardPosition(
                        row: RowPosition.allCases[self.boardPosition.row.rawValue + 1],
                        column: self.boardPosition.column
                    )
                ]
            }
            return []
        }
        return []
    }
}
