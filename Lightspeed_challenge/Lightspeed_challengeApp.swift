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
