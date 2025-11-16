//
//  MovieOverviewSection.swift
//  MovieDB
//
//  Created by Hassan Jaffri on 14/11/2025.
//
import SwiftUI
struct MovieOverviewSection: View {
    let overview: String?
    
    var body: some View {
        Text(overview ?? "No overview available.")
            .font(.subheadline)
            .foregroundColor(.secondary)
            .lineLimit(4)
            .multilineTextAlignment(.leading)
    }
}
