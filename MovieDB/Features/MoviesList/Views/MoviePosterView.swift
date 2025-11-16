//
//  MoviePosterView.swift
//  MovieDB
//
//  Created by Hassan Jaffri on 14/11/2025.
//
import SwiftUI
import Kingfisher
struct MoviePosterView: View {
    let url: String?
    
    var body: some View {
        
        KFImage(URL(string: "\(AppConstants.imagesBaseUrl)\(url ?? "")"))
            .placeholder {  
                placeholder
            }
            .resizable()
            .scaledToFill()
            .frame(width: 100, height: 150)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(radius: 3)
    }
    
    private var placeholder: some View {
        Image(systemName: "film")
            .resizable()
            .scaledToFit()
            .frame(width: 60, height: 60)
            .foregroundColor(.gray.opacity(0.6))
            .frame(width: 100, height: 150)
            .background(Color.gray.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}
