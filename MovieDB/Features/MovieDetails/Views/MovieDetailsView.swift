//
//  MovieDetailsView.swift
//  MovieDB
//
//  Created by Hassan Jaffri on 13/11/2025.
//
import SwiftUI
struct MovieDetailsView: View {
    @StateObject var viewModel: MovieDetailsViewModel
    @Environment(\.presentationMode) var presentation
    @State private var showAlert = false
    
    init(viewModel: MovieDetailsViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        LoadingView(isLoading: viewModel.isLoading) {
            VStack(spacing: 0) {
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 0) {
                        MoviePosterHeaderComponent(movie: viewModel.movieItem)
                        MoreAboutComponent(movie: viewModel.movieItem,
                                           videoAvailable: viewModel.videoTrailerAvailable(),
                                           videoAction: playTrailer)
                        .padding(.top, -30)
                    }
                }
            }
            .onChange(of: viewModel.errorTrigger)
            { newValue in
                showAlert = true
            }
            .alert("Error", isPresented: $showAlert) {
                Button("OK", role: .cancel) {
                    showAlert = false
                }
            } message: {
                Text(viewModel.errorMessage ?? "")
            }
            .task {
                await viewModel.fetchMovieDetails()
                await viewModel.fetchMovieTrailer()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar { backButton }
            .ignoresSafeArea(edges: .all)
            
        }
    }
}
private extension MovieDetailsView {
    var backButton: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Button(action: {
                presentation.wrappedValue.dismiss()
            }) {
                Image(systemName: "chevron.left")
                    .foregroundColor(.blue)
            }
        }
    }
}
private extension MovieDetailsView {
    func playTrailer() {
        guard let trailer = viewModel.video?.first else { return }
        if let appUrl = URL(string: "youtube://\(trailer.key)"),
           UIApplication.shared.canOpenURL(appUrl) {
            UIApplication.shared.open(appUrl)
        } else if let webUrl = URL(string: "https://www.youtube.com/watch?v=\(trailer.key)") {
            UIApplication.shared.open(webUrl)
        }
    }
}

struct MovieDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailsView(viewModel: MovieDetailsViewModel(movieID: 0))
    }
}
