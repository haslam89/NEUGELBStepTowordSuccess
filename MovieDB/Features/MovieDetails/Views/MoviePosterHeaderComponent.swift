//
//  MoviePosterHeaderComponent.swift
//  MovieDB
//
//  Created by Hassan Jaffri on 14/11/2025.
//
import SwiftUI
import Foundation
import Kingfisher
struct MoviePosterHeaderComponent: View {
    let movie: MovieDetails?
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            
            KFImage(URL(string: "\(AppConstants.imagesBaseUrl)\(movie?.posterPath ?? "")"))
                .placeholder {
                    posterPlaceholder
                }
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(radius: 3)
         
        
            VStack(alignment: .leading, spacing: 8) {
                Text(movie?.title ?? "")
                    .font(.title)
                    .bold()
                    .foregroundColor(.white)
                
                Text("Time Laps: \(movie?.formattedTime ?? "")")
                    .font(.subheadline)
                    .foregroundColor(.white)
            }
            .padding()
            .padding(.bottom, 30)
            .frame(maxWidth: .infinity, alignment: .leading) 
            .background(
                LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.8), Color.clear]),
                               startPoint: .bottom,
                               endPoint: .top)
                .frame(maxWidth: .infinity)
            )
        }
        .frame(maxWidth: .infinity)
    }
    private var posterPlaceholder: some View {
        Image(systemName: "film")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 60, height: 60)
            .foregroundColor(.gray.opacity(0.6))
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2)
            .background(Color.gray.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

