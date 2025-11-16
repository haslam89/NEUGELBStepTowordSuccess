//
//  MovieList.swift
//  MovieDB
//
//  Created by Hassan Jaffri on 14/11/2025.
//
import SwiftUI
struct MovieList: View {
    var movies: [Movie]
    var showEmptyState: Bool
    var searchQuery: String
    var loadAllAction: () -> Void
    var onMovieTap: (Movie) -> Void
    var onLastMovieAppear: (Movie) -> Void
    var onLoadAllPressed: () -> Void
    var body: some View {
        ScrollView {
            if showEmptyState {
                VStack(spacing: 16) {
                    NoMovieDataView(isEmpty: true, emptyMessage: "No movies found")
                    if !searchQuery.isEmpty {
                        LoadAllMoviesButton {
                            onLoadAllPressed() // Or call your function to load all movies
                    }
                    }
                }
                .padding()
            }

            LazyVStack {
                ForEach(movies, id: \.id) { movie in
                    Button {
                        onMovieTap(movie)
                    } label: {
                        MovieRowView(movie: movie)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .onAppear { onLastMovieAppear(movie) }
                }
            }
        }.scrollIndicators(.hidden)
    }
}
struct LoadAllMoviesButton: View {
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text("Load All Movies")
                .font(.subheadline)
                .foregroundColor(.blue)
                .padding(.vertical, 8)
                .frame(maxWidth: .infinity)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
        }
        .padding(.horizontal)
        .transition(.opacity)
    }
}

