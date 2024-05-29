//
//  WelcomeScreen.swift
//  HemnetAssignment
//
//  Created by Vincent Palma on 2024-05-25.
//
import SwiftUI

struct WelcomeScreen: View {
    @State private var isShowingNextView = false
    @State private var dragAmount = CGSize.zero
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                VStack {
                    Spacer().frame(height: 80)
                    Text("Hitta ditt")
                        .font(.custom("Epilogue-Medium", size: 28))
                        .multilineTextAlignment(.center)
                    Text("HYGGEBO")
                        .font(.custom("Epilogue-Bold", size: 38))
                        .padding()
                        .bold()
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                    PullTabView()
                        .padding(.trailing, -1)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .offset(x: dragAmount.width)
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    withAnimation {
                                        dragAmount = value.translation
                                    }
                                }
                                .onEnded { value in
                                    if value.translation.width < -150 {
                                        withAnimation {
                                            self.isShowingNextView = true
                                        }
                                    }
                                    withAnimation {
                                        dragAmount = CGSize.zero
                                    }
                                }
                        )
                }
                .navigationDestination(isPresented: $isShowingNextView) {
                    Home()
                }
            }
            .background {
                RemoteImage(urlString: API.startScreenImageURL)
                    .ignoresSafeArea()
                    .frame(alignment: .center)
                
            }
        }
    }
}

#Preview {
    WelcomeScreen()
}

struct PullTabView: View {
    var body: some View {
        HStack(spacing: 0) {
            RoundedRectangle(cornerRadius: 5)
                .frame(width: 80, height: 50)
                .foregroundColor(.white)
                .overlay {
                    Image(systemName: "arrow.left")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40)
                        .foregroundStyle(.black)
                        .bold()
                }
        }
        .padding(.bottom, 50)
    }
}


// Example on how to cache an image for the second startup
class ImageCache {
    static let shared = ImageCache()
    
    private let cache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    func set(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
    
    func get(forKey key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }
}

struct RemoteImage: View {
    @ObservedObject var imageLoader: ImageLoader
    
    init(urlString: String) {
        imageLoader = ImageLoader(url: urlString)
    }
    
    var body: some View {
        if let image = imageLoader.image {
            Image(uiImage: image)
                .resizable()
        } else {
            ProgressView()
        }
    }
}

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    
    private var url: String
    private var task: URLSessionDataTask?
    
    init(url: String) {
        self.url = url
        loadImage()
    }
    
    private func loadImage() {
        if let cachedImage = ImageCache.shared.get(forKey: url) {
            self.image = cachedImage
            return
        }
        
        guard let url = URL(string: url) else { return }
        
        task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self.image = image
                ImageCache.shared.set(image!, forKey: self.url)
            }
        }
        task?.resume()
    }
}
