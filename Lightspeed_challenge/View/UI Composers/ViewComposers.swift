//
//  ViewComposers.swift
//  Lightspeed_challenge
//
//  Created by Sheharyar Irfan on 2023-03-02.
//

import Foundation
import Lightspeed

public class MainViewComposer {
    public static func viewComposedWith(feedLoader: PersonFeedLoader) -> (view: PeopleView, viewModel:PeopleViewModel) {
        let viewModel = PeopleViewModel(feedLoader: feedLoader)
        let detailComposer = DetailViewComposer(client: URLSessionHTTPClient(session: .shared))
        let peopleView = PeopleView(viewModel: viewModel, personDetailComposer: detailComposer)
        return (peopleView, viewModel)
    }
}

class DetailViewComposer {
    let client: HTTPClient
    
    init(client: HTTPClient) {
        self.client = client
    }
    public func viewComposedWith(person: Person) -> PeopleDetail {
        return PeopleDetail(person: person, filmViewComposer: FilmViewComposer.shared)
    }
}

class FilmViewComposer {
    let client: HTTPClient
    public static var shared = FilmViewComposer(client: URLSessionHTTPClient(session: .shared))
    private init(client: HTTPClient) {
        self.client = client
        
    }
    private var tasks: [URL: (HTTPClientTask, RemoteFilmLoader)] = [:]

    public func viewComposedWith(url: URL) -> FilmView {
        let viewModel = FilmViewModel()
        if !isLoading(url: url) {
            viewModel.isLoading = true
            let taskx = load(url: url) { film in
                if let film = film {
                    viewModel.set(film: film)
                }
            }
            tasks.updateValue(taskx, forKey: url)
        } else {
            cancelTask(for: url)
            viewModel.isLoading = true
            let taskx = load(url: url) { film in
                if let film = film {
                    viewModel.set(film: film)
                }
            }
            tasks.updateValue(taskx, forKey: url)
        }
        
        return FilmView(viewModel: viewModel)
    }
    
    
    func load(url: URL, completion: @escaping ((Film?) -> Void)) -> (HTTPClientTask, RemoteFilmLoader) {
        let filmLoader = RemoteFilmLoader(url: url, client: client)
        return (filmLoader.load { result in
            switch result {
            case .success(let film):
                DispatchQueue.main.async {
                    completion(film)
                }
            case .failure(let error):
                completion(nil)
                print(error)
            }
        },filmLoader)
    }
    
    func cancelTask(for url: URL) {
        guard let task = tasks.first(where: {
            return url == $0.key
        }) else {
            return
        }
        task.value.0.cancel()
    }
    
    func isLoading(url: URL) -> Bool {
        guard let task = tasks.first(where: {
            return url == $0.key
        }) else {
            return false
        }
        return !task.value.0.isCompleted()
    }
}
