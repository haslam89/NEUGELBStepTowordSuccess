//
//  MovieBadge.swift
//  MovieDB
//
//  Created by Hassan Jaffri on 14/11/2025.
//
import SwiftUI
struct MovieBadge: View {
    let text: String
    
    var body: some View {
        Text(text)
            .font(.caption)
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .padding(.vertical, 6)
            .padding(.horizontal, 12)
            .background(
                LinearGradient(colors: [.blue, .purple],
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
            )
            .clipShape(Capsule())
            .shadow(color: .black.opacity(0.2), radius: 3, x: 0, y: 2)
    }
}
