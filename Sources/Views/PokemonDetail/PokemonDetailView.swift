//
//  PokemonDetailView.swift
//  shakespearemon-sdk
//
//  Created by Fabrizio Scarano on 02/05/25.
//

import SwiftUI
import NukeUI

public struct PokemonDetailView: View {
    private let imageURL: URL
    private let description: String
    
    public init(imageURL: URL, description: String) {
        self.imageURL = imageURL
        self.description = description
    }
    
    public var body: some View {
        VStack() {
            imageView
            Text(description)
        }
        .padding()
        .overlay {
            RoundedRectangle(cornerRadius: 16)
                .stroke()
        }
    }
    
    var imageView: some View {
        LazyImage(url: imageURL) { state in
            if state.isLoading {
                ProgressView("Loading sprite...")
            } else if let result = state.result,
                      case .success = result,
                      let image = state.image {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else {
                Text("Sprite is unavailable")
            }
        }
        .frame(width: 250, height: 250, alignment: .center)
    }
}

#Preview {
    PokemonDetailView(
        imageURL: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/6.png")!,
        description: "Spits fire that is hot enough to melt boulders. Known to cause forest fires unintentionally."
    )
}
