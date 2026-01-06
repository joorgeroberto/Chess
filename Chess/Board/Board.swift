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

            VStack(spacing: 0) {
                ForEach((1...ColumnPosition.allCases.count), id: \.self) { column in
                    HStack(spacing: 0) {
                        Text("\(column)")
                            .padding(.trailing, 10)
                        ForEach(1...RowPosition.allCases.count, id: \.self) { row in
                            ZStack {
                                Rectangle()
                                    .fill((row + column) % 2 == 0 ? Color.white : Color.gray)
                                    .frame(width: squareSize, height: squareSize)
                                if let piece = viewModel.shouldRenderPiece(column, row - 1) {
                                    Text(verbatim: "\(piece.type.rawValue)")
                                }
                            }
                        }
                    }
                }

                rowsLabel(squareSize: squareSize)
            }
        }
    }

    @ViewBuilder
    func rowsLabel(squareSize: CGFloat) -> some View {
        HStack(spacing: 0) {
            ForEach((1...RowPosition.allCases.count), id: \.self) { row in
                Text(verbatim: "\(viewModel.getLetterFrom(number: row - 1))")
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
