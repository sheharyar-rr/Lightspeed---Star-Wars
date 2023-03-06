//
//  SharedTestHelpers.swift
//  Lightspeed_challengeTests
//
//  Created by Sheharyar Irfan on 2023-03-06.
//

import Foundation

func anyNSError() -> NSError {
    return NSError(domain: "any error", code: 0)
}

func anyURL() -> URL {
    return URL(string: "https://any-url.com")!
}
