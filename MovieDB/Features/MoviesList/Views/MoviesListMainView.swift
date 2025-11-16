//
//  MoviesListMainView.swift
//  MovieDB
//
//  Created by Hassan Jaffri on 13/11/2025.
//
import SwiftUI
import Combine
struct MoviesListMainView: View {
    @StateObject var viewModel: MoviesListViewModel
    @State private var showMovieDetails: Movie? = nil
    @State private var selectedSortOption: MovieSortOption = .releaseDate
    @State private var showAlert = false
    @State private var searchCancellable: AnyCancellable?
    @FocusState private var isSearchFocused: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                
                MovieSearchBar(
                    text: $viewModel.searchQuery,
                    isFocused: $isSearchFocused,
                    onDebouncedChange: handleSearchChange
                )
                .padding(.horizontal, 15)
                
                if viewModel.showSuggetions && !viewModel.suggestions.isEmpty {
                    SuggestionsDropdown(
                        suggestions: viewModel.suggestions,
                        onSelect: handleSuggestionSelection
                    )
                }
                
                MovieList(
                    movies: viewModel.movies,
                    showEmptyState: viewModel.showEmptyState,
                    searchQuery: viewModel.searchQuery,
                    loadAllAction: { viewModel.searchQuery = "" },
                    onMovieTap: {
                        
                        isSearchFocused = false
                        showMovieDetails = $0
                    },
                    onLastMovieAppear: { movie in
                        if viewModel.isLastMovie(movie){
                            Task {
                                await viewModel.fetchNextPageIfNeeded(
                                    currentItem: movie,
                                    sortedBy: selectedSortOption
                                )
                            }
                        }
                        
                    }, onLoadAllPressed: {
                        viewModel.searchQuery = ""
                    }
                )
            }
            .navigationTitle("Movies")
            .toolbar { sortingMenu }
            .fullScreenCover(item: $showMovieDetails) { movie in
                let detailsVM = MovieDetailsViewModel(movieID: movie.id, service: MovieServiceManager())
                NavigationView { MovieDetailsView(viewModel: detailsVM) }
            }
            .alert("Error", isPresented: $showAlert) {
                Button("OK", role: .cancel) { showAlert = false }
            } message: { Text(viewModel.errorMessage ?? "") }
                .task { await viewModel.fetchMovies(reset: true, sortedBy: selectedSortOption) }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onTapGesture { isSearchFocused = false }
        .onChange(of: viewModel.errorTrigger) { _ in showAlert = true }
    }
}
extension MoviesListMainView {
    
    private var sortingMenu: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Menu {
                ForEach(MovieSortOption.allCases) { option in
                    Button(option.displayName) {
                        Task {
                            selectedSortOption = option
                            viewModel.searchQuery = ""
                            isSearchFocused = false
                            await viewModel.refreshMovies(sortedBy: option)
                        }
                    }
                }
            } label: {
                HStack {
                    Text(selectedSortOption.displayName)
                    Image(systemName: "arrow.up.arrow.down")
                }
                .padding(6)
                .cornerRadius(6)
            }
        }
    }
}
extension MoviesListMainView {
    @ViewBuilder
    private func SuggestionsDropdown(
        suggestions: [Movie],
        onSelect: @escaping (Movie) -> Void
    ) -> some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                ForEach(suggestions) { movie in
                    Button {
                        onSelect(movie)
                    } label: {
                        Text(movie.title ?? "")
                            .foregroundColor(.primary)
                            .font(.system(size: 16, weight: .medium))
                    }
                    .padding(.vertical, 8)
                    .padding(.horizontal, 12)
                    
                    Divider()
                }
            }
        }
        .frame(maxHeight: 200)
        .cornerRadius(8)
        .padding(.horizontal)
        .padding(.top, 3)
    }
    
    private func handleSuggestionSelection(_ movie: Movie) {
        let title = movie.title ?? ""
        viewModel.selectedSearchResult = title
        viewModel.searchQuery = title
        viewModel.showSuggetions = false
    }
}
extension MoviesListMainView {
    
    private func handleSearchChange(_ text: String) {
        Task { await performSearch(for: text) }
    }
    
    private func performSearch(for text: String) async {
        if !text.isEmpty,
           text == viewModel.selectedSearchResult
        {
            viewModel.filterMovies(query: text)
            return
        }

        viewModel.selectedSearchResult = nil
        
        if text.isEmpty {
            await viewModel.refreshMovies(sortedBy: selectedSortOption)
        } else {
            await viewModel.searchMovies(
                query: text,
                sortedBy: selectedSortOption
            )
        }
    }
}
struct MoviesListMainView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesListMainView(viewModel: MoviesListViewModel(movieService: MovieServiceManager()))
    }
}
