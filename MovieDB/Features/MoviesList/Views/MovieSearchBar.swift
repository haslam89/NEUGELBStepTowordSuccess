//
//  MovieSearchBar.swift
//  MovieDB
//
//  Created by Hassan Jaffri on 14/11/2025.
//
import SwiftUI
import Combine
struct MovieSearchBar: View {
    @Binding var text: String
    @FocusState.Binding var isFocused: Bool
    var onDebouncedChange: (String) -> Void
    
    @State private var debounceCancellable: AnyCancellable?
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass").foregroundColor(.gray)
                .padding(.leading, 10)
            TextField("Search movies...", text: $text)
                .focused($isFocused)
                .padding(10)
                .onChange(of: text) { newValue in
                    debounceCancellable?.cancel()
                    debounceCancellable = Just(newValue)
                        .delay(for: .seconds(0.5), scheduler: DispatchQueue.main)
                        .sink { value in
                            onDebouncedChange(value)
                        }
                }
            
            if !text.isEmpty {
                Button {
                    text = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                        .padding(.trailing, 5)
                        .contentShape(Rectangle()) // ← ensures full tappable area
                }
                .buttonStyle(PlainButtonStyle())   // ← prevents long press animation
            }
        }
        .frame(height: 48)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(8)
    }
}
