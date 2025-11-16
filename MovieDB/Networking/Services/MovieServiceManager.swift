//
//  MovieServiceManager.swift
//  MovieDB
//
//  Created by Hassan Jaffri on 16/11/2025.
//
final class MovieServiceManager: MovieServiceProtocol {
    
    private let api: APIService
    
    init(api: APIService = .shared) {
        self.api = api
    }
    
    func getMoviesList(sortedBy: MovieSortOption, page: Int) async throws -> MoviesListResponse {
        try await api.request(
            MoviesAPIService.getMoviesList(sortedBy: sortedBy, page: page),
            responseType: MoviesListResponse.self
        )
    }
    
    func getMovieDetails(id: Int) async throws -> MovieDetails {
        try await api.request(
            MoviesAPIService.getMovieDetails(id: id),
            responseType: MovieDetails.self
        )
    }
    
    func getMovieTrailer(id: Int) async throws -> VideoTrailerResponse {
        try await api.request(
            MoviesAPIService.getMovieTrailer(id: id),
            responseType: VideoTrailerResponse.self
        )
    }
    
    func searchMovie(query: String, sortedBy: MovieSortOption, page: Int) async throws -> MoviesListResponse {
        try await api.request(
            MoviesAPIService.searchMovie(searchQuery: query, sortedBy: sortedBy, page: page),
            responseType: MoviesListResponse.self
        )
    }
}
