//
//  ImageLoaderView.swift
//  PixaGame
//
//  Created by Didik on 20/07/20.
//  Copyright © 2020 Codingtive. All rights reserved.
//

import SwiftUI
import URLImage

struct ImageLoaderView: View {
    
    let imageURL: URL?
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.gray.opacity(0.3))
            
            if imageURL != nil {
                URLImage(imageURL!, placeholder: {
                    ProgressView($0) { _ in
                        ZStack {
                            ActivityIndicatorView()
                        }
                    }
                }, content:  {
                    $0.image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipped()
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                })
            } else {
                Text("No Image")
                    .foregroundColor(.gray)
            }
        }
    }
}

struct ImageLoaderView_Previews: PreviewProvider {
    static var previews: some View {
        ImageLoaderView(imageURL: Game.stubbedGame.backgroundURL)
    }
}
