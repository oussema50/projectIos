//
//  LottieView.swift
//  food-app
//
//  Created by Tekup-mac-2 on 27/11/2024.
//

import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    let animationURL: String
    let loopMode: LottieLoopMode
    
    func makeUIView(context: Context) -> some UIView {
        let view = UIView(frame: .zero)
        let animationView = LottieAnimationView()
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = loopMode

        // Load Lottie animation from URL
        guard let url = URL(string: animationURL) else {
            print("Invalid URL")
            return view
        }
        
        // Use DefaultAnimationCache instead of LRUAnimationCache
        LottieAnimation.loadedFrom(url: url, closure: { animation in
            if let animation = animation {
                animationView.animation = animation
                animationView.play()
            } else {
                print("Failed to load animation from URL")
            }
        }, animationCache: DefaultAnimationCache.sharedCache)

        view.addSubview(animationView)
        animationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {}
}
