//
//  CacheAsyncImage.swift
//  My fridge
//
//  Created by Алексей Исаев on 04.12.2023.
//

import SwiftUI

struct CacheAsyncImage<Content>: View where Content: View {
    private let imageURL: String
    private let content: (AsyncImagePhase) -> Content
    
    init (
        imageURL: String,
        @ViewBuilder content: @escaping (AsyncImagePhase) -> Content
    ) {
        self.imageURL = imageURL
        self.content = content
    }
    
    var body: some View {
        if let cachedImage = ImageCacheManager[imageURL] {
            let _ = print("cached \(imageURL)")
            content(.success(cachedImage))
        } else {
            let _ = print("request \(imageURL)")
            AsyncImage(url: URL(string: imageURL)) { phase in
                cacheAndRender(phase: phase)
            }
        }
    }
    
    func cacheAndRender(phase: AsyncImagePhase) -> some View {
        if case .success(let image) = phase {
            ImageCacheManager[imageURL] = image
        }
        return content(phase)
    }
}

struct CacheAsyncImage_Previews: PreviewProvider {
    static var previews: some View {
        CacheAsyncImage(imageURL: "url..") {
            phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
            case .failure:
                Image(systemName: "xmark.shield")
            @unknown default:
                fatalError()
            }
        }
    }
}
