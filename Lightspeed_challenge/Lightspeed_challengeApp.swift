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
        let detailLoader = RemoteFilmLoader(url: person.films.first!, client: client)
        let viewModel = PeopleDetailViewModel(detailLoader: detailLoader, person: person)
        return PeopleDetail(person: person, viewModel: viewModel)
    }
}
