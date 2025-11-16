//
//  MoreAboutComponent.swift
//  MovieDB
//
//  Created by Hassan Jaffri on 14/11/2025.
//
import SwiftUI
import Foundation
// Movie Info Section
struct MoreAboutComponent: View {
    let movie: MovieDetails?
    let videoAvailable: Bool
    let videoAction: () -> Void
    @Environment(\.colorScheme) private var colorScheme  // Detect light/dark mode
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            if let genres = movie?.genres, !genres.isEmpty {
                HStack(spacing: 8) {
                    ForEach(genres) { genre in
                        MovieBadge(text: genre.name)
                    }
                }
            }
            
            Text(movie?.overview ?? "")
                .font(.body)
            
            if let movie = movie {
                HStack(spacing: 20) {
                    Label("\(Int(movie.voteAverage * 10))%", systemImage: "star.fill")
                        .foregroundColor(.yellow)
                        .font(.subheadline)
                    
                    Label("\(movie.voteCount) Votes", systemImage: "person.3.fill")
                        .foregroundColor(.secondary)
                        .font(.subheadline)
                    
                    Label(String(format: "%.1f", movie.popularity), systemImage: "flame.fill")
                        .foregroundColor(.orange)
                        .font(.subheadline)
                }
            }
            
            Button(action: videoAction) {
                HStack {
                    Image(systemName: "play.fill")
                    Text(videoAvailable ? "Watch Trailer" : "Trailer not available")
                        .fontWeight(.semibold)
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, minHeight: 60)
                .background(
                    Group {
                        if videoAvailable {
                            LinearGradient(
                                colors: [Color.red, Color.red.opacity(0.7)],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        } else {
                            Color.gray.opacity(0.2)
                        }
                    }
                    .cornerRadius(8)
                )
            }
            .disabled(!videoAvailable) 
        }
        .padding()
        .background(
            colorScheme == .dark ? Color.black : Color.white
        )
    }
}

