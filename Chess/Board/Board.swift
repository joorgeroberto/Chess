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
                ForEach((0..<viewModel.board.count).reversed(), id: \.self) { row in
                    HStack(spacing: 0) {
                        Text("\(row)")
                            .padding(.trailing, 10)
                        ForEach(0..<viewModel.board[row].count, id: \.self) { column in
                            ZStack {
                                Rectangle()
                                    .fill((row + column) % 2 == 0 ? Color.gray : Color.white)
                                    .frame(width: squareSize, height: squareSize)
                                Text(verbatim: "W\(viewModel.board[row][column].type.rawValue)")
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
            ForEach(Array("ABCDEFGH"), id: \.self) { column in
                Text(verbatim: "\(column)")//"\(viewModel.getLetterFrom(number: column))")
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
