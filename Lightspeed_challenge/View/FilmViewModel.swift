//
//  FilmViewModel.swift
//  Lightspeed_challenge
//
//  Created by Sheharyar Irfan on 2023-03-02.
//

import Foundation
import Lightspeed

class FilmViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var words: Int = 0
    @Published var isLoading = false
    @Published var error: String?
    
    init()  {
    }
    
    func set(film: Film) {
        print("set film to \(film.name)")
        DispatchQueue.main.async {
            self.name = film.name
            self.isLoading = false
            self.words = film.openingCrawl.wordCount()
        }
    }
    
    func set(error: String) {
        DispatchQueue.main.async {
            self.error = error
            self.isLoading = false
        }
    }
}
