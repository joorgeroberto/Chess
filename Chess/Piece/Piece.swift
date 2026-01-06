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

enum RowPosition: Int, CaseIterable { case a = 0, b, c, d, e, f, g, h }
enum ColumnPosition: Int, CaseIterable { case one = 0, two, three, four, five, six, seven, eight }

struct BoardPosition: Hashable {
    let row: RowPosition
    let column: ColumnPosition
}

struct Piece: Hashable, Equatable {
    let id: UUID
    var boardPosition: BoardPosition
    var color: PieceColor = .white
    var type: PieceType = .empty
//    var possibleMoves: Set<BoardPosition> = []

    init(id: UUID = UUID(), type: PieceType, color: PieceColor, boardPosition: BoardPosition) {
        self.id = id
        self.type = type
        self.color = color
        self.boardPosition = boardPosition
//        buildPieceColorAndType(boardPosition: boardPosition)
//        self.possibleMoves = getPossiblePieceMoves()
    }

    static func == (lhs: Piece, rhs: Piece) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

//    func buildPieceColorAndType(boardPosition: BoardPosition) {
//        switch (boardPosition.column, boardPosition.row) {
//
//            // Rooks
//        case (0, 0), (7, 0):
//            type = .rook
//            color = .white
//
//        case (0, 7), (7, 7):
//            type = .rook
//            color = .black
//
//            // Knights
//        case (1, 0), (6, 0):
//            type = .knight
//            color = .white
//
//        case (1, 7), (6, 7):
//            type = .knight
//            color = .black
//
//            // Bishops
//        case (2, 0), (5, 0):
//            type = .bishop
//            color = .white
//
//        case (2, 7), (5, 7):
//            type = .bishop
//            color = .black
//
//            // Queen
//        case (3, 0):
//            type = .queen
//            color = .white
//
//        case (3, 7):
//            type = .queen
//            color = .black
//
//            // King
//        case (4, 0):
//            type = .king
//            color = .white
//
//        case (4, 7):
//            type = .king
//            color = .black
//
//            // Pawns
//        case (_, 1):
//            type = .pawn
//            color = .white
//
//        case (_, 6):
//            type = .pawn
//            color = .black
//
//        default:
//            type = .empty
//        }
//    }
//
//    func getPossiblePieceMoves() -> Set<BoardPosition> {
//        if self.type == .pawn && self.color == .black {
//            if self.boardPosition.row > 2 {
//                return [
//                    BoardPosition(
//                        row: self.boardPosition.row - 1,
//                        column: self.boardPosition.column
//                    ),
//                    BoardPosition(
//                        row: self.boardPosition.row - 2,
//                        column: self.boardPosition.column
//                    )
//                ]
//            }
//            if self.boardPosition.row > 1 {
//                return [
//                    BoardPosition(
//                        row: self.boardPosition.row - 1,
//                        column: self.boardPosition.column
//                    )
//                ]
//            }
//            return []
//        }
//        if self.type == .pawn && self.color == .white {
//            if self.boardPosition.row < 7 {
//                return [
//                    BoardPosition(
//                        row: self.boardPosition.row + 1,
//                        column: self.boardPosition.column
//                    ),
//                    BoardPosition(
//                        row: self.boardPosition.row + 2,
//                        column: self.boardPosition.column
//                    )
//                ]
//            }
//            if self.boardPosition.row < 8 {
//                return [
//                    BoardPosition(
//                        row: self.boardPosition.row + 1,
//                        column: self.boardPosition.column
//                    )
//                ]
//            }
//            return []
//        }
//        return []
//    }
}
