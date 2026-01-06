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

enum RowPosition: String, CaseIterable {
    case A, B, C, D, E, F, G, H
}

enum ColumnPosition: Int, CaseIterable {
    case one = 1
    case two
    case three
    case four
    case five
    case six
    case seven
    case eight
}

class Piece: Hashable, Equatable {
    let id: UUID
    var rowPosition: RowPosition
    var columnPosition: ColumnPosition
    var color: PieceColor
    var type: PieceType = .empty

    init(id: UUID = UUID(), rowPosition: RowPosition, columnPosition: ColumnPosition, color: PieceColor) {
        self.id = id
        self.rowPosition = rowPosition
        self.columnPosition = columnPosition
        self.color = color
        self.type = getPieceTypeWithInitialPosition(rowPosition: rowPosition, columnPosition: columnPosition)
    }

    static func == (lhs: Piece, rhs: Piece) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    func getPieceTypeWithInitialPosition(rowPosition: RowPosition, columnPosition: ColumnPosition) -> PieceType {
        switch (rowPosition, columnPosition) {

            // Rooks
        case (.A, .one), (.A, .eight),
            (.H, .one), (.H, .eight):
            return .rook

            // Knights
        case (.B, .one), (.B, .eight),
            (.G, .one), (.G, .eight):
            return .knight

            // Bishops
        case (.C, .one), (.C, .eight),
            (.F, .one), (.F, .eight):
            return .bishop

            // Queen
        case (.D, .one), (.D, .eight):
            return .queen

            // King
        case (.E, .one), (.E, .eight):
            return .king

            // Pawns
        case (_, .two), (_, .seven):
            return .pawn

        default:
            return .empty
        }
    }
}
