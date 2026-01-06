//
//  Board.swift
//  Chess
//
//  Created by Jorge de Carvalho on 05/01/26.
//


import SwiftUI

struct Board: View {
    @State var viewModel = BoardViewModel()

    var body: some View {
        GeometryReader { geometry in
            let squareWidth = geometry.size.width > 0 ? geometry.size.width - 20 : geometry.size.width
            let squareHeight = geometry.size.height
            let squareSize = min(squareWidth, squareHeight) / 8

            // Preciso Guardar o Board pra poder fazer a movimentação
            VStack(spacing: 0) {
                ForEach((1...RowPosition.allCases.count), id: \.self) { row in
                    HStack(spacing: 0) {
                        Text("\(row)")
                            .padding(.trailing, 10)
                        ForEach(1...ColumnPosition.allCases.count, id: \.self) { column in
                            ZStack {
                                Rectangle()
                                    .fill((row + column) % 2 == 0 ? Color.white : Color.gray)
                                    .frame(width: squareSize, height: squareSize)
                                if let piece = viewModel.getPieceAt(column, row), piece.type != .empty {
                                    if piece.color == .white {
                                        Text(verbatim: "W\(piece.type.rawValue)")
                                    } else {
                                        Text(verbatim: "B\(piece.type.rawValue)")
                                    }
                                }
                                //                                if let selectedPiece = viewModel.selectedPiece {
                                //                                    selectedPiece.possibleMoves
                                //                                }
                            }
                            .onTapGesture {
                                viewModel.onTapSquare(column, row)
                            }
                        }
                    }
                }

                columnsLabel(squareSize: squareSize)
            }
        }
    }

    @ViewBuilder
    func columnsLabel(squareSize: CGFloat) -> some View {
        HStack(spacing: 0) {
            ForEach((1...ColumnPosition.allCases.count), id: \.self) { column in
                Text(verbatim: "\(viewModel.getLetterFrom(number: column))")
                    .frame(maxWidth: .infinity)
            }
        }
        .padding(.leading, squareSize / 3)
        .padding(.top, 10)
    }
}

#Preview {
    Board()
}
