//
//  PokemonDetailView.swift
//  shakespearemon-sdk
//
//  Created by Fabrizio Scarano on 02/05/25.
//

import SwiftUI
import NukeUI

/// A built-in UI component to show the details of a Pokémon.
public struct PokemonDetailView: View {
    private let imageURL: URL
    private let description: String
    
    /// Creates a new detail view.
    ///
    /// - Parameters:
    ///     - imageURL: The URL of the image to load in the component.
    ///     - description: the description to show in the component.
    public init(imageURL: URL, description: String) {
        self.imageURL = imageURL
        self.description = description
    }
    
    public var body: some View {
        VStack() {
            imageView
            Text(description)
                .layoutPriority(1)
        }
        .padding()
        .overlay {
            RoundedRectangle(cornerRadius: 16)
                .stroke()
        }
    }
    
    var imageView: some View {
        // An handy view to lazily load images from a given URL.
        LazyImage(url: imageURL) { state in
            if let image = state.image {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else if let result = state.result,
                      case .failure = result {
                Text("Sprite is unavailable")
            } else {
                ProgressView("Loading sprite...")
            }
        }
        .frame(maxHeight: 250, alignment: .center)
    }
}

#Preview {
    PokemonDetailView(
        imageURL: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/6.png")!,
        description: "Spits fire that is hot enough to melt boulders. Known to cause forest fires unintentionally."
    )
}
