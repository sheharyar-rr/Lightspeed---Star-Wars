//
//  FilmViewModel.swift
//  Lightspeed_challenge
//
//  Created by Sheharyar Irfan on 2023-03-02.
//

import Foundation

class FilmViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var words: Int = 0
    @Published var openingCrawl: String = ""
    
    
    init(url: URL, client: HTTPClient)  {
        loadFilm(with: url, client: client)
    }
    
    func loadFilm(with url: URL, client: HTTPClient) {
        Task {
            async let result = RemoteFilmLoader(url: url, client: client).load()
            let film = try await result.get()
            DispatchQueue.main.async { [weak self] in
                self?.name = film.name
                self?.openingCrawl = film.openingCrawl
            }
        }
    }
}
