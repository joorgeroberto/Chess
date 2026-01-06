//
//  BoardViewModel.swift
//  Chess
//
//  Created by Jorge de Carvalho on 05/01/26.
//
import SwiftUI


@Observable
class BoardViewModel {
    var pieces: Set<Piece> = []
    var selectedPiece: Piece?

    init() {
        createPieces()
    }

    func getLetterFrom(number: Int) -> ColumnPosition {
        return ColumnPosition.allCases[number - 1]
    }

    func createPieces() {
        for columnIndex in 1...(ColumnPosition.allCases.count) {
            for rowIndex in 1...(RowPosition.allCases.count) {
                let rowPosition = RowPosition.allCases[columnIndex - 1]
                let columnPosition = ColumnPosition.allCases[rowIndex - 1]
                let piece = Piece(
                    rowPosition: rowPosition,
                    columnPosition: columnPosition
                )
                pieces.insert(piece)
            }
        }

    }

    func getPieceAt(_ column: Int, _ row: Int) -> Piece? {
        return pieces.first(where: {
            $0.boardPosition.row.rawValue == row &&
            $0.boardPosition.column.rawValue == getLetterFrom(number: column).rawValue
        })
    }

    func onTapSquare(_ column: Int, _ row: Int) {
        if let piece = getPieceAt(column, row) {
            selectedPiece = piece
        }
    }
}
