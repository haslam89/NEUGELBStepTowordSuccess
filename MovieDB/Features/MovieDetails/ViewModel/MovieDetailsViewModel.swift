//
//  MovieDetailsViewModel.swift
//  MovieDB
//
//  Created by Hassan Jaffri on 13/11/2025.
//
import Foundation
import SwiftUI
import Combine
@MainActor
class MovieDetailsViewModel: ObservableObject {
    
    private let service: MovieServiceProtocol
    private let movieID: Int
    
    @Published var movieItem: MovieDetails?
    @Published var video: [VideoTrailer]?
    
    @Published var isLoading = false
    @Published var showEmptyState = false
    @Published var errorMessage: String?
    @Published var errorTrigger = 0
    
    // Init with Dependency Injection
    init(movieID: Int, service: MovieServiceProtocol) {
        self.movieID = movieID
        self.service = service
    }

    convenience init(movieID: Int) {
        self.init(movieID: movieID, service: MovieServiceManager())
    }

    func videoTrailerAvailable() -> Bool {
        !(video?.isEmpty ?? true)
    }

    func fetchMovieDetails() async {
        guard checkConnectivity() else { return } // Stop if no internet
        isLoading = true
        showEmptyState = false
        errorMessage = nil
        
        do {
            movieItem = try await service.getMovieDetails(id: movieID)
        } catch {
            handleError(error)
        }
        
        isLoading = false
    }

    func fetchMovieTrailer() async {
        do {
            let response = try await service.getMovieTrailer(id: movieID)
            video = response.results
        } catch {
            handleError(error)
        }
    }
    
    private func handleError(_ error: Error) {
        errorMessage = error.localizedDescription
        showEmptyState = true
        errorTrigger += 1
    }
 
    func fetchMovieDetailsMockData() async {
        isLoading = true
        defer { isLoading = false }
        
        guard let path = Bundle.main.path(forResource: "MoviesDetails", ofType: "json"),
              let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
            handleError(NSError(domain: "Mock", code: -1,
                                userInfo: [NSLocalizedDescriptionKey: "Local JSON not found"]))
            return
        }
        
        do {
            movieItem = try JSONDecoder().decode(MovieDetails.self, from: data)
        } catch {
            handleError(error)
        }
    }
}
// Connectivity Check
extension MovieDetailsViewModel {
    private func checkConnectivity() -> Bool {
        if !NetworkMonitor.shared.isConnected {
            errorMessage = "No internet connection. Please check your connection and try again."
            errorTrigger += 1
            return false
        }
        return true
    }
}

