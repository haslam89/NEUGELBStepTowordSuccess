//
//  SplashScreenView.swift
//  MovieDB
//
//  Created by Hassan Jaffri on 13/11/2025.
//
import SwiftUI
struct SplashScreenView: View {
    @State private var animate = false
    @State private var isActive = false

    var body: some View {
        ZStack {
            // Main content
            MoviesListMainView(viewModel: MoviesListViewModel(movieService: MovieServiceManager()))
                .opacity(isActive ? 1 : 0)
            
            AnimatedUI(animate: $animate)
                .opacity(isActive ? 0 : 1)
                .animation(.easeOut(duration: 1), value: isActive)
        }
        .onAppear {
            animate = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
                isActive = true
            }
        }
    }
}
struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
