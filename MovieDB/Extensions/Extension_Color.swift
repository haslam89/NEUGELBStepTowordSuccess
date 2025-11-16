//
//  Extension_Color.swift
//  MovieDB
//
//  Created by Hassan Jaffri on 16/11/2025.
//
import SwiftUI

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

