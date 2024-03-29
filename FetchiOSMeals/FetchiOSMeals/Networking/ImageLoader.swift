//
//  ImageLoader.swift
//  FetchiOSMeals
//
//  Created by user on 3/28/24.
//

import SwiftUI
import Combine

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    private var cancellable: AnyCancellable?

    func load(fromURLString urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.image = $0 }
    }

    deinit {
        cancellable?.cancel()
    }
}

struct AsyncImageView: View {
    @StateObject private var loader = ImageLoader()
    let urlString: String

    var body: some View {
        Image(uiImage: loader.image ?? UIImage(systemName: "photo")!)
            .resizable()
            .onAppear { loader.load(fromURLString: urlString) }
    }
}
