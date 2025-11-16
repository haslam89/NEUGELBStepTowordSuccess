//
//  MovieMetaInfoSection.swift
//  MovieDB
//
//  Created by Hassan Jaffri on 14/11/2025.
//
import SwiftUI
struct MovieMetaInfoSection: View {
    let rating: Double?
    let releaseDate: String
    
    var body: some View {
        HStack {
            Label("\(Int((rating ?? 0) * 10))%", systemImage: "star.fill")
                .foregroundColor(.orange)
                .font(.subheadline)
            
            Spacer()
            
            Text(releaseDate)
                .font(.caption2)
                .foregroundColor(.secondary)
        }
    }
}
