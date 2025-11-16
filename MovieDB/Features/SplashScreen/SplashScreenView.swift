//
//  SplashScreenView.swift
//  MovieDB
//
//  Created by Hassan Jaffri on 13/11/2025.
//
import SwiftUI
struct SplashScreenView: View {
    @State private var animate = false
    @State private var isActive = false

    var body: some View {
        ZStack {
            // Main content
            MoviesListView(viewModel: MoviesListViewModel(movieService: MovieServiceManager()))
                .opacity(isActive ? 1 : 0)
            
            // Splash screen overlay
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color.theme, Color.animationColor]),
                    startPoint: animate ? .topLeading : .bottomTrailing,
                    endPoint: animate ? .bottomTrailing : .topLeading
                )
                .ignoresSafeArea()
                .animation(.linear(duration: 3).repeatForever(autoreverses: true), value: animate)
                
                VStack(spacing: 20) {
                    Image("appstore")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 120)
                        .foregroundColor(.yellow)
                        .scaleEffect(animate ? 1.3 : 0.7)
                        .rotationEffect(.degrees(animate ? 360 : 0))
                        .opacity(animate ? 1 : 0.5)
                        .offset(y: animate ? -10 : 10)
                        .animation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true), value: animate)
                    
                    Text("Movie Zone")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(.yellow)
                        .opacity(animate ? 1 : 0)
                }
            }
            // Fade out splash smoothly
            .opacity(isActive ? 0 : 1)
            .animation(.easeOut(duration: 1), value: isActive)
        }
        .onAppear {
            animate = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
                isActive = true
            }
        }
    }
}
struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
extension Color {
    static var theme: Color {
        Color(UIColor { traitCollection in
            traitCollection.userInterfaceStyle == .dark ? .black : .white
        })
    }
    static var animationColor: Color {
            Color(UIColor { traitCollection in
                if traitCollection.userInterfaceStyle == .dark {
                    // Dark mode → gold
                    return UIColor(red: 1.0, green: 0.843, blue: 0.0, alpha: 0.3)
                } else {
                    // Light mode → purple
                    return UIColor(red: 0.5, green: 0.0, blue: 0.5, alpha: 0.3)
                }
            })
        }
}
