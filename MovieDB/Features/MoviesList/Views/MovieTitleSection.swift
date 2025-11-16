//
//  MovieTitleSection.swift
//  MovieDB
//
//  Created by Hassan Jaffri on 14/11/2025.
//
import SwiftUI
struct MovieTitleSection: View {
    let title: String?
    let isUpcoming: Bool
    
    var body: some View {
        HStack(alignment: .top) {
            Text(title ?? "Unknown Title")
                .font(.headline)
                .lineLimit(2)
            
            Spacer()
            
            if isUpcoming {
                MovieBadge(text: "Coming Soon")
            }
        }
    }
}
