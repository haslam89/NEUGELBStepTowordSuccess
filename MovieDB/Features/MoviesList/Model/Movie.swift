//
//  Movie.swift
//  MovieDB
//
//  Created by Hassan Jaffri on 13/11/2025.
//
import Foundation
struct MoviesListResponse: Codable {
    var page: Int?
    var results: [Movie]?
    var total_results: Int?
    var total_pages: Int?
}

struct Movie: Identifiable, Codable, Equatable
{
    
    let adult: Bool?
    let backdropPath: String?
    let genreIds: [Int]?
    let id: Int
    let originalLanguage: String?
    let originalTitle: String?
    let overview: String?
    let popularity: Double?
    let posterPath: String?
    let releaseDate: String?
    let title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
    let runtime: Int?
    let genres: [Genre]?
    
    var formattedReleaseDate: String {
        guard let release_date = releaseDate else { return "N/A" }
        
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        if let date = inputFormatter.date(from: release_date) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "d MMMM yyyy" // 20 July 2025
            outputFormatter.locale = Locale(identifier: "en_US")
            return outputFormatter.string(from: date)
        }
        return "-"
    }
    var isUpcoming: Bool {
        guard let releaseDate = releaseDate else { return false }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        guard let date = formatter.date(from: releaseDate) else { return false }
        
        return date > Date() ? true : false
    }
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIds = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        
        // Detailed movie fields
        case runtime
        case genres
    }
}

struct Genre: Codable, Equatable {
    var id: Int?
    var name: String?
}

