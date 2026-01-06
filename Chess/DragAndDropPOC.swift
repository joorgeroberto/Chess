//
//  DragAndDropPOC.swift
//  Chess
//
//  Created by Jorge de Carvalho on 05/01/26.
//

import Playgrounds
import SwiftUI
import UniformTypeIdentifiers // Needed for UTType

struct DraggableView: View {
    var body: some View {
        Text("Drag Me")
            .draggable("The text payload to be transferred") //
    }
}

struct DropDestinationView: View {
    @State private var receivedText: String = "Drop Text Here"
    @State private var isTargeted = false // For visual feedback

    var body: some View {
        Rectangle()
            .fill(isTargeted ? Color.green.opacity(0.5) : Color.blue.opacity(0.5))
            .frame(width: 200, height: 200)
            .overlay(Text(receivedText).padding())
            .dropDestination(for: String.self) { items, location in
                // Action to perform when an item is dropped
                if let firstItem = items.first {
                    receivedText = firstItem
                    return true // Indicate successful drop
                }
                return false
            } isTargeted: { targeted in
                // Closure for visual feedback when an item is hovered over the destination
                isTargeted = targeted
            }
    }
}

struct Example5View: View {
    @State private var image = Image(systemName: "photo")

    var body: some View {
        DraggableView()
        DropDestinationView()
    }
}

// 1. Extend UTType for a custom type
extension UTType {
    static let character = UTType("com.yourapp.character")! //
}

// 2. Make your model conform to Transferable and Codable/Identifiable
struct Character: Codable, Identifiable, Transferable, Equatable {
    var id: String { name } // Using name as ID for simplicity
    let name: String
    let rank: Int

    // 3. Define the transfer representation
    static var transferRepresentation: some TransferRepresentation {
        CodableRepresentation(contentType: .character) //
    }
}

struct Example1View: View {
    @State private var message = ""

    var body: some View {
        Canvas { context, size in
            let formattedText = Text(message).font(.largeTitle).foregroundStyle(.red)
            context.draw(formattedText, in: CGRect(origin: .zero, size: size))
        }
        .dropDestination(for: String.self) { items, location in
            message = items.first ?? ""
            return true
        }
    }
}

struct Example2View: View {
    @State private var image = Image(systemName: "photo")

    var body: some View {
        image
            .resizable()
            .scaledToFit()
            .frame(width: 300, height: 300)
            .dropDestination(for: Data.self) { items, location in
                guard let item = items.first else { return false }
                guard let uiImage = UIImage(data: item) else { return false }
                image = Image(uiImage: uiImage)
                return true
            }

    }
}

struct Example3View: View {
    @State private var images = [Image]()

    var body: some View {
        ScrollView {
            VStack {
                ForEach(0..<images.count, id: \.self) { i in
                    images[i]
                        .resizable()
                        .scaledToFit()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .dropDestination(for: Data.self) { items, location in
            images = items.compactMap {
                UIImage(data: $0).map(Image.init)
            }

            return true
        }
    }
}

struct Example4View: View {
    let sports = ["figure.badminton", "figure.cricket", "figure.fencing"]
    @State private var dropImage = Image(systemName: "photo")

    var body: some View {
        VStack {
            HStack {
                ForEach(sports, id: \.self) { sport in
                    Image(systemName: sport)
                        .frame(minWidth: 50, minHeight: 50)
                        .background(.red)
                        .foregroundStyle(.white)
                        .draggable(Image(systemName: sport)) {
                            Image(systemName: sport)
                                .frame(width: 100, height: 100)
                        }
                }
            }
            .frame(minWidth: 300, minHeight: 70)
            .background(.gray)

            dropImage
                .frame(width: 150, height: 150)
                .background(.green)
                .foregroundStyle(.white)
                .dropDestination(for: Image.self) { items, location in
                    dropImage = items.first ?? Image(systemName: "photo")
                    return true
                }
        }
    }
}

#Preview {
    Example4View()
}
