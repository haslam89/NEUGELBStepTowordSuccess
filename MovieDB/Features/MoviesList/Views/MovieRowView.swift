//
//  MovieRowView.swift
//  MovieDB
//
//  Created by Hassan Jaffri on 13/11/2025.
//

import SwiftUI

struct MovieRowView: View {
    let movie: Movie
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            
            MoviePosterView(url: movie.posterPath)
            VStack(alignment: .leading, spacing: 8) {
                
                MovieTitleSection(title: movie.title, isUpcoming: movie.isUpcoming)
                MovieOverviewSection(overview: movie.overview)
                Spacer(minLength: 6)
                MovieMetaInfoSection(
                    rating: movie.voteAverage,
                    releaseDate: movie.formattedReleaseDate
                )
            }
        }
        .padding(.vertical, 8)
        .padding(.horizontal)
        .background(Color(.systemBackground))
        .contentShape(Rectangle())
    }
}

