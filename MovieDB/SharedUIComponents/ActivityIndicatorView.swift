//
//  ActivityIndicatorView.swift
//  MovieDB
//
//  Created by Hassan Jaffri on 14/11/2025.
//
import SwiftUI

public struct ActivityIndicatorView: View {

     var isVisible: Bool

    public init(isVisibleE: Bool) {
        isVisible = isVisibleE
    }

    public var body: some View {
        if isVisible {
            indicator
        } else {
            EmptyView()
        }
    }
        
    private var indicator: some View {
        ZStack {
            GrowingArcIndicatorView(color: .blue, lineWidth: 4)
        }
    }
}


