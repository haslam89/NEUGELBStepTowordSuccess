//
//  LoadingView.swift
//  MovieDB
//
//  Created by Hassan Jaffri on 14/11/2025.
//

import SwiftUI

struct LoadingView<Content: View>: View {
    let content: Content

    let isLoading: Bool

    private let blurRadius: CGFloat
    private let alignment: Alignment

    private let scaleEffect: CGFloat

    init(isLoading: Bool,
         scaleEffect: CGFloat = 2,
         blurRadius: CGFloat = 2,
         alignment: Alignment = .center,
         @ViewBuilder content: () -> Content) {

        self.content = content()
        self.isLoading = isLoading
        self.scaleEffect = scaleEffect
        self.blurRadius = blurRadius
        self.alignment = alignment
    }

    var body: some View {
        ZStack(alignment: alignment) {
            content
                .disabled(isLoading)
                .blur(radius: isLoading ? blurRadius : 0)
            if isLoading {
                ZStack {
                    EmptyView()
                        .disabled(isLoading)
                        .edgesIgnoringSafeArea(.all)
                    ActivityIndicatorView(isVisibleE: isLoading)
                        .frame(width: 50.0, height: 50.0)
                         .foregroundColor(.blue)
                         
                }
            }
        }
    }
}

extension View {
    @ViewBuilder func loadingView(isLoading: Bool,
                                  scaleEffect: CGFloat = 2) -> some View {
        ZStack {
            self.disabled(isLoading)
                .blur(radius: isLoading ? 2 : 0)
            if isLoading {
                ZStack {
                    EmptyView()
                        .disabled(isLoading)
                        .edgesIgnoringSafeArea(.all)
                    ProgressView()
                        .progressViewStyle(.circular)
                        .scaleEffect(scaleEffect)
                }
            }
        }
    }
}


