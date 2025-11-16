#  Movie Zone(App Name) SwiftUI/Swift iOS Test Assignment

A SwiftUI-based iOS application to browse movies using The Movie Database (TMDb) API, featuring search, sorting, infinite scrolling, dark theme compatibility and cached image loading. Built with modern Swift concurrency and clean MVVM architecture.

⸻

# Features

    •    Browse popular and recent movies.
    •    Infinite scrolling with automatic pagination.
    •    Search movies with suggestions dropdown.
    •    Sort movies by:
            •    Popularity
            •    Release date
            •    Vote average
            •    Revenue
    •    Async image loading with caching using Kingfisher.
    •    Placeholder and empty state views for better UX.
    •    Mock JSON support for offline testing.
    •    Added error handing custom class.
    •    Dark theme compatibility
    •    Movie trailer if availble , it will open in youtube app or weblink
    •    Implemented protocol oriented programming for seperation of concern
    •    Added some Unit test cases on mock data
    •    Added Network connectivty check 
    •    Some Animation at start to make look and feel better.

⸻

# Architecture
    •    MVVM (Model-View-ViewModel) // we can also use MVVM-C 
    
    •    SwiftUI for declarative UI
    •    Combine for reactive state management (@Published)
    •    Async/Await for network calls
    •    Kingfisher (via Swift Package Manager) for cached image loading // For image loading , we can use SDWebImage or we can design out own
    
# Application Folder Structure

        #MovieDB/
        │
        ├── MovieDB
        │   ├── AppConstants/               # Global app constants & static values
        │   │
        │   ├── Features/                   # Feature-based modular architecture
        │   │   ├── MovieDetails/
        │   │   │   ├── Model/              # Data models for movie details
        │   │   │   ├── ViewModel/          # Business logic for movie details
        │   │   │   └── Views/              # UI screens for movie details
        │   │   │
        │   │   ├── MoviesList/
        │   │   │   ├── Model/              # Data models for movie list
        │   │   │   ├── ViewModel/          # Business logic for movie list
        │   │   │   └── Views/              # UI screens for movie list
        │   │   │
        │   │   └── SplashScreen/           # Splash screen module simple just added some animation before app starts
        │   │
        │   ├── Networking/                 # Network layer
        │   │   ├── CoreNetwork/            # Base networking setup 
        │   │   ├── MockData/               # Mock responses for testing
        │   │   ├── Monitoring/             # Monitoring network connectivity
        │   │   └── Services/               # API service protocol based interfaces & implementations
        │   │
        │   ├── SharedUIComponents/         # Reusable UI elements
        │   │               
        │   │
        │   ├── MovieDBApp/                 # Main application entry point
        │   └── README                      # Internal documentation
        │
        ├── MovieDBTests/                   # Unit tests added unit test cases with mock data
        │   ├── MoviesDBAppTests/
        │   └── MovieDBUITests/             # UI tests
        │
        └── Package Dependencies
            └── Kingfisher (8.6.1)          # Image loading & caching library
