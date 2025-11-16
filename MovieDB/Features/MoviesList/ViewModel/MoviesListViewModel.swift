//
//  MoviesListViewModel.swift
//  MovieDB
//
//  Created by Hassan Jaffri on 13/11/2025.
//
import Foundation
import Combine

@MainActor
final class MoviesListViewModel: ObservableObject {
    
    private let movieService: MovieServiceProtocol
    
    @Published var movies: [Movie] = []
    @Published var suggestions: [Movie] = []
    @Published var isLoading = false
    @Published var showEmptyState = false
    @Published var errorMessage: String?
    @Published var showSuggetions = true
    @Published var selectedSearchResult: String? = nil
    @Published var searchQuery: String = ""
    @Published var errorTrigger: Int = 0
    
    private var currentPage = 1
    private var totalPages = 1
    private var isFetching = false
    
    // Init with Dependency Injection
    init(movieService: MovieServiceProtocol) {
        self.movieService = movieService
    }
    
    convenience init() {
        self.init(movieService: MovieServiceManager())
    }
    
    func refreshMovies(sortedBy: MovieSortOption) async {
        guard checkConnectivity() else { return } // Stop if no internet
        resetPaging()
        suggestions = []
        showSuggetions = false
        await fetchMovies(reset: true, sortedBy: sortedBy)
    }
    
    func filterMovies(query: String) {
        movies = movies.filter {
            ($0.title ?? "").lowercased().contains(query.lowercased())
        }
    }
    
    func searchMovies(query: String, sortedBy: MovieSortOption) async {
        guard !query.isEmpty else {
            suggestions = []
            return
        }
        guard checkConnectivity() else { return } // Stop if no internet
        
        if query != selectedSearchResult {
            resetPaging()
        }
        
        await fetchSearchResults(query: query, sortedBy: sortedBy)
    }
    
    func fetchNextPageIfNeeded(currentItem movie: Movie, sortedBy: MovieSortOption = .releaseDate) async {
        guard checkConnectivity() else { return } // Stop if no internet
        guard isLastMovie(movie),
              currentPage <= totalPages,
              !isFetching
        else { return }
        
        if searchQuery.isEmpty {
            await fetchMovies(sortedBy: sortedBy)
        } else {
            await fetchSearchResults(query: searchQuery, sortedBy: sortedBy)
        }
    }
    func isLastMovie(_ movie: Movie) -> Bool {
        guard let last = movies.last else { return false }
        return last.id == movie.id
    }
    func isSelectedFromSuggestionBox() -> Bool {
        if let text = selectedSearchResult, !text.isEmpty { return false }
        return true
    }
}

extension MoviesListViewModel {
    func fetchMovies(reset: Bool = false, sortedBy: MovieSortOption) async {
        guard !isFetching, currentPage <= totalPages else { return }
        guard checkConnectivity() else { return } // Stop if no internet
        isFetching = true
        if currentPage == 1 && !reset { isLoading = true }
        
        defer {
            isFetching = false
            isLoading = false
        }
        
        do {
            let response = try await movieService.getMoviesList(
                sortedBy: sortedBy,
                page: currentPage
            )
            
            handleResponse(response, isSearch: false, isReset: reset)
        } catch {
            handleError(error)
        }
    }
}
extension MoviesListViewModel {
    private func fetchSearchResults(query: String, sortedBy: MovieSortOption) async {
        guard !isFetching, currentPage <= totalPages else { return }
        isFetching = true
        
        defer { isFetching = false }
        
        do {
            let response = try await movieService.searchMovie(
                query: query,
                sortedBy: sortedBy,
                page: currentPage
            )
            
            handleResponse(response, isSearch: true, isReset: currentPage == 1)
        } catch {
            handleError(error)
        }
    }
}

extension MoviesListViewModel {
    private func handleResponse(_ response: MoviesListResponse,
                                isSearch: Bool,
                                isReset: Bool) {
        
        let results = (response.results ?? []).filter {
            !($0.overview?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true)
        }
        
        totalPages = response.total_pages ?? 1
        
        if isReset {
            movies = results
            suggestions = isSearch ? results : []
        } else {
            let existingIDs = Set(movies.map { $0.id })
            let newMovies = results.filter { !existingIDs.contains($0.id) }
            movies.append(contentsOf: newMovies)
            if isSearch { suggestions = movies }
        }
        
        showSuggetions = isSearch ? isSelectedFromSuggestionBox() : false
        showEmptyState = movies.isEmpty
        
        currentPage += 1
    }
}

extension MoviesListViewModel {
    private func handleError(_ error: Error) {
        errorMessage = error.localizedDescription
        showEmptyState = movies.isEmpty
        errorTrigger += 1
    }
    private func resetPaging() {
        currentPage = 1
        totalPages = 1
    }
}
//  Connectivity Check
extension MoviesListViewModel {
    
    private func checkConnectivity() -> Bool {
        if !NetworkMonitor.shared.isConnected {
            errorMessage = "No internet connection. Please check your connection and try again."
            errorTrigger += 1
            return false
        }
        return true
    }
}


