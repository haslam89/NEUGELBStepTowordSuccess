//
//  NoMovieDataView.swift
//  MovieDB
//
//  Created by Hassan Jaffri on 14/11/2025.
//
import SwiftUI

struct NoMovieDataView: View {
    
    var isEmpty: Bool
    var emptyMessage: String = "No items found"
    var body: some View {
        ZStack {
          if isEmpty {
                VStack(spacing: 16) {
                    Image("Film")
                        .renderingMode(.template)       // allow tinting
                        .resizable()
                        .foregroundColor(.primary)
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .foregroundColor(.gray.opacity(0.6))
                    Text(emptyMessage)
                        .font(.headline)
                        .foregroundColor(.gray)
                    Text("Try adjusting your filters or search query.")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
                .padding()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
