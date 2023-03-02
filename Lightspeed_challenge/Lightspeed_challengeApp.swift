//
//  Lightspeed_challengeApp.swift
//  Lightspeed_challenge
//
//  Created by Sheharyar Irfan on 2023-03-01.
//

import SwiftUI

@main
struct Lightspeed_challengeApp: App {
    
    let BaseURL = URL(string: "https://swapi.dev/api/")!
    
    var body: some Scene {
        WindowGroup {
            MainViewComposer.viewComposedWith(feedLoader: RemotePersonLoader(url: PersonEndPoint.get.url(baseURL: BaseURL),
                                                                             client: URLSessionHTTPClient(session: .shared)))
        }
    }
}

class MainViewComposer {
    public static func viewComposedWith(feedLoader: FeedLoader) -> PeopleView {
        let viewModel = PeopleViewModel(feedLoader: feedLoader)
        let detailComposer = DetailViewComposer(client: URLSessionHTTPClient(session: .shared))
        let peopleView = PeopleView(viewModel: viewModel, personDetailComposer: detailComposer)
        return peopleView
    }
}

class DetailViewComposer {
    let client: HTTPClient
    
    init(client: HTTPClient) {
        self.client = client
    }
    public func viewComposedWith(person: Person) -> PeopleDetail {
        
        let viewModel = PeopleDetailViewModel(person: person)
        return PeopleDetail(person: person, viewModel: viewModel, filmViewComposer: FilmViewComposer(client: client))
    }
}

class FilmViewComposer {
    let client: HTTPClient
    
    init(client: HTTPClient) {
        self.client = client
    }
    public func viewComposedWith(url: URL) -> FilmView {
        
        let viewModel = FilmViewModel(url: url, client: client)
        return FilmView(viewModel: viewModel)
    }
}
