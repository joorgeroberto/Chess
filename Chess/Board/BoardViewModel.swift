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

    init() {
        createPieces(withColor: .white)
        createPieces(withColor: .black)
    }
    func getLetterFrom(number: Int) -> RowPosition {
        return RowPosition.allCases[number]
    }

    func createPieces(withColor color: PieceColor) {
        for columnIndex in 1...(ColumnPosition.allCases.count) {
            for rowIndex in 1...(RowPosition.allCases.count) {
                let rowPosition = RowPosition.allCases[rowIndex - 1]
                let columnPosition = ColumnPosition(rawValue: columnIndex)!
                let piece = Piece(
                    rowPosition: rowPosition,
                    columnPosition: columnPosition,
                    color: color
                )
                pieces.insert(piece)
            }
        }

    }

    func shouldRenderPiece(_ column: Int, _ row: Int) -> Piece? {
        return pieces.first(where: {
            $0.columnPosition.rawValue == column &&
            $0.rowPosition.rawValue == getLetterFrom(number: row).rawValue})
    }
}
