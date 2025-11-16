//
//  AnimatedUI.swift
//  MovieDB
//
//  Created by Hassan Jaffri on 16/11/2025.
//
import SwiftUI
struct AnimatedUI: View {
    @Binding var animate: Bool

    var body: some View {
        ZStack {
            // Background gradient
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
                    .animation(.easeIn(duration: 1.5), value: animate)
            }
        }
    }
}
