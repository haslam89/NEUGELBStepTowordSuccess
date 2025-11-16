//
//  MovieServiceProtocol.swift
//  MovieDB
//
//  Created by Hassan Jaffri on 16/11/2025.
//
protocol MovieServiceProtocol {
    func getMoviesList(sortedBy: MovieSortOption, page: Int) async throws -> MoviesListResponse
    func getMovieDetails(id: Int) async throws -> MovieDetails
    func getMovieTrailer(id: Int) async throws -> VideoTrailerResponse
    func searchMovie(query: String, sortedBy: MovieSortOption, page: Int) async throws -> MoviesListResponse
}
