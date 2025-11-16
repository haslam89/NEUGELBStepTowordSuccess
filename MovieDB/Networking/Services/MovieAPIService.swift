//
//  MovieAPIService.swift
//  MovieDB
//
//  Created by Hassan Jaffri on 13/11/2025.
//
import Foundation

enum MoviesAPIService {
    case getMoviesList(sortedBy: MovieSortOption, page: Int = 1)
    case getMovieDetails(id: Int)
    case getMovieTrailer(id: Int)
    case searchMovie(searchQuery: String, sortedBy: MovieSortOption, page: Int = 1)
}

enum MovieSortOption: CaseIterable, Identifiable {
    case popularity
    case releaseDate
    case voteAverage
    case revenue
    
    var id: String { displayName }          // For ForEach / Identifiable
    var displayName: String {               // User-friendly text for dropdown
        switch self {
        case .popularity: return "Popularity"
        case .releaseDate: return "Release Date"
        case .voteAverage: return "Vote Average"
        case .revenue: return "Revenue"
        }
    }
    
    var apiValue: String {                  // Value to pass to API
        switch self {
        case .popularity: return "popularity.desc"
        case .releaseDate: return "release_date.desc"
        case .voteAverage: return "vote_average.desc"
        case .revenue: return "revenue.desc"
        }
    }
}

extension MoviesAPIService: Endpoint {
    
    var baseURL: URL {
        URL(string: AppConstants.baseURl)!
    }
    
    var path: String {
        switch self {
        case .getMoviesList:
            return "discover/movie"
        case .getMovieDetails(let id):
            return "movie/\(id)"
        case .getMovieTrailer(let id):
            return "movie/\(id)/videos"
        case .searchMovie:
            return "search/movie"
        }
    }
    
    var method: HTTPMethod {
        .GET
    }
    
    var headers: [String : String]? {
        ["Accept": "application/json"]
    }
    
    var parameters: [String : Any]? {
        nil
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .getMoviesList(let sort, let page):
            return [
                URLQueryItem(name: "api_key", value: AppConstants.APIKey),
                URLQueryItem(name: "language", value: "en-US"),
                URLQueryItem(name: "sort_by", value: sort.apiValue),
                URLQueryItem(name: "include_adult", value: "false"),
                URLQueryItem(name: "include_video", value: "false"),
                URLQueryItem(name: "page", value: "\(page)")
            ]
            
        case .getMovieDetails:
            return [
                URLQueryItem(name: "api_key", value: AppConstants.APIKey),
                URLQueryItem(name: "language", value: "en-US")
            ]
        case .getMovieTrailer:
            return [
                URLQueryItem(name: "api_key", value: AppConstants.APIKey),
                URLQueryItem(name: "language", value: "en-US")
            ]
        case .searchMovie(let query, let sort, let page):
            return [
                URLQueryItem(name: "api_key", value: AppConstants.APIKey),
                URLQueryItem(name: "query", value: query),
                URLQueryItem(name: "language", value: "en-US"),
                URLQueryItem(name: "sort_by", value: sort.apiValue),
                URLQueryItem(name: "include_adult", value: "false"),
                URLQueryItem(name: "include_video", value: "false"),
                URLQueryItem(name: "page", value: "\(page)")
            ]
        }
    }
}
