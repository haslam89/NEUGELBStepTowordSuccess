//
//  MoviesDBAppTests.swift
//  MovieDB
//
//  Created by Hassan Jaffri on 14/11/2025.
//
import XCTest
import Combine
@testable import MovieDB

// MARK: - Mock Service
final class MovieServiceMock: MovieServiceProtocol {

    private func loadJSON<T: Decodable>(fileName: String, type: T.Type) -> T {
        
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json"), let data = try? Data(contentsOf: url)  else {
            fatalError("Failed to load \(fileName).json")
        }
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            fatalError("Failed to decode \(fileName).json: \(error)")
        }
    }

    func getMoviesList(sortedBy: MovieSortOption, page: Int) async throws -> MoviesListResponse {
        loadJSON(fileName: "MoviesList", type: MoviesListResponse.self)
    }

    func searchMovie(query: String, sortedBy: MovieSortOption, page: Int) async throws -> MoviesListResponse {
        loadJSON(fileName: "MoviesList", type: MoviesListResponse.self)
    }

    func getMovieDetails(id: Int) async throws -> MovieDetails {
        loadJSON(fileName: "MoviesDetails", type: MovieDetails.self)
    }

    func getMovieTrailer(id: Int) async throws -> VideoTrailerResponse {
        loadJSON(fileName: "VideoTrailer", type: VideoTrailerResponse.self)
    }
}

// MARK: - Tests
@MainActor
final class MoviesListViewModelTests: XCTestCase {

    var viewModel: MoviesListViewModel!
    var service: MovieServiceMock!

    override func setUp() async throws {
        try await super.setUp()
        service = MovieServiceMock()
        viewModel = MoviesListViewModel(movieService: service)
    }

    override func tearDown() async throws {
        viewModel = nil
        service = nil
        try await super.tearDown()
    }

    func testFetchMovies_loadsMovies() async {
        await viewModel.fetchMovies(reset: true, sortedBy: .releaseDate)
        XCTAssertFalse(viewModel.movies.isEmpty, "Movies should be loaded")
        XCTAssertFalse(viewModel.showEmptyState)
        XCTAssertNil(viewModel.errorMessage)
    }

    func testFilterMovies_filtersCorrectly() async {
        await viewModel.fetchMovies(reset: true, sortedBy: .releaseDate)
        let firstMovieTitle = viewModel.movies.first!.title!
        viewModel.filterMovies(query: firstMovieTitle)
        XCTAssertEqual(viewModel.movies.count, 1)
    }

    func testIsSelectedFromSuggestionsBox_returnsTrueWhenEmpty() async {
        viewModel.selectedSearchResult = ""
        XCTAssertTrue(viewModel.isSelectedFromSuggestionBox())
    }

    func testIsSelectedFromSuggestionsBox_returnsFalseWhenNotEmpty() async {
        viewModel.selectedSearchResult = "Dummy"
        XCTAssertFalse(viewModel.isSelectedFromSuggestionBox())
    }

    func testIsLastMovieInList_detectsLastMovie() async {
        await viewModel.fetchMovies(reset: true, sortedBy: .releaseDate)
        let lastMovie = viewModel.movies.last!
        XCTAssertTrue(viewModel.isLastMovie(lastMovie))
    }

    func testIsLastMovieInList_returnsFalseForNonLastMovie() async {
        await viewModel.fetchMovies(reset: true, sortedBy: .releaseDate)
        let firstMovie = viewModel.movies.first!
        XCTAssertFalse(viewModel.isLastMovie(firstMovie))
    }

    func testSearchMovies_mockedResults() async {
        await viewModel.searchMovies(query: "Mock", sortedBy: .releaseDate)
        XCTAssertFalse(viewModel.movies.isEmpty)
        XCTAssertFalse(viewModel.suggestions.isEmpty)
    }

    func testFetchNextPageIfNeeded_updatesMovies() async {
        await viewModel.fetchMovies(reset: true, sortedBy: .releaseDate)
        let lastMovie = viewModel.movies.last!
        await viewModel.fetchNextPageIfNeeded(currentItem: lastMovie)
        XCTAssertFalse(viewModel.movies.isEmpty)
    }

    func testFetchMovieDetails_andTrailer() async {
        // Optionally, test MovieDetailsViewModel equivalent
        let details = try? await service.getMovieDetails(id: 550)
        XCTAssertEqual(details?.title, "Fight Club")
        let trailer = try? await service.getMovieTrailer(id: 550)
        XCTAssertEqual(trailer?.results.first?.type, "Trailer")
    }
}
