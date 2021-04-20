//
//  LoadingView.swift
//  PixaGame
//
//  Created by Didik on 07/07/20.
//  Copyright © 2020 Codingtive. All rights reserved.
//

import SwiftUI

struct LoadingView: View {
    let isLoading: Bool
    let error: NSError?
    let retryAction: (() -> ())
    
    var body: some View {
        Group {
            if isLoading {
                HStack {
                    Spacer()
                    ActivityIndicatorView()
                    Spacer()
                }
            } else if error != nil {
                HStack {
                    Spacer()
                    VStack(alignment: .center, spacing: 4) {
                        Text(error?.localizedDescription ?? "")
                            .font(.headline)
                            .multilineTextAlignment(.center)
                            .lineLimit(4)
                            .padding(EdgeInsets(top: 0, leading: 24, bottom: 16, trailing: 24))
                        
                        Button(action: self.retryAction) {
                            Text("Retry")
                        }
                        .foregroundColor(Color.blue)
                        .buttonStyle(PlainButtonStyle())
                    }
                    Spacer()
                }
            }
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(isLoading: true, error: nil, retryAction: {})
    }
}
