//
//  Lightspeed_challengeTests.swift
//  Lightspeed_challengeTests
//
//  Created by Sheharyar Irfan on 2023-03-01.
//

import XCTest
import Combine
import Lightspeed
@testable import Lightspeed_challenge

final class PeopleViewTests: XCTestCase {
    
    var cancellables: Set<AnyCancellable> = []

    func test_loadPeopleAction_requestFromLoader() {
        let (sut, loader) = makeSUT()
        XCTAssertEqual(loader.loadFeedCallCount, 0, "Expected no loading requests before view is loaded")
        
        sut.viewModel.loadPeople()
        XCTAssertEqual(loader.loadFeedCallCount, 1, "Expected a loading request once view is loaded")
    }
    
    func test_loadPeopleAction_errorFromLoader() {
        let (sut, loader) = makeSUT()
        
        sut.viewModel.loadPeople()
        loader.completeFeedLoadingWithError()
        print("Load feed count \(loader.loadFeedCallCount)")
        
        let expectation = expectation(description: "Error when loading")
        
        sut.viewModel.$error
            .receive(on: RunLoop.main)
            .sink { error in
                if error == anyNSError().localizedDescription {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        wait(for: [expectation], timeout: 1)
    }
    
    func test_loadPeopleCompletion_loadedAlphabetically() {
        let person1 = makePerson(name: "Adam", dateOfBirth: "xxx", phisicalAttributs: [makePhysicalAttributes(name: "non", value: "non")], films: [makeFilm(name: nil, openingCrawl: nil, url: anyURL())])
        let person2 = makePerson(name: "Bob", dateOfBirth: "xxx", phisicalAttributs: [makePhysicalAttributes(name: "non", value: "non")], films: [makeFilm(name: nil, openingCrawl: nil, url: anyURL())])
        let person3 = makePerson(name: "Carl", dateOfBirth: "xxx", phisicalAttributs: [makePhysicalAttributes(name: "non", value: "non")], films: [makeFilm(name: nil, openingCrawl: nil, url: anyURL())])
        let person4 = makePerson(name: "David", dateOfBirth: "xxx", phisicalAttributs: [makePhysicalAttributes(name: "non", value: "non")], films: [makeFilm(name: nil, openingCrawl: nil, url: anyURL())])
        
        let (sut, loader) = makeSUT()
        let expectation = expectation(description: "Loading people alphabetically")
        
        sut.viewModel.loadPeople()
        loader.completeFeedLoading(with: [person3, person1, person2, person4])
        
        sut.viewModel.$PeopleList
            .receive(on: RunLoop.main)
            .sink { people in
                if people == [person1, person2, person3, person4] {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 1)
    }
    
    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> (sut: (view: PeopleView, viewModel:PeopleViewModel), loader: LoaderSpy) {
        let loader = LoaderSpy()
        let sut = MainViewComposer.viewComposedWith(feedLoader: loader)
        trackForMemoryLeaks(loader, file: file, line: line)
        return (sut, loader)
    }
    
    private func makePerson(name: String, dateOfBirth: String, phisicalAttributs: [PhysicalAttribute], films: [Film]) -> Person {
        return Person(id: UUID(), name: name, dateOfBirth: dateOfBirth, physicalAttributes: phisicalAttributs, films: films)
    }
    
    private func makePhysicalAttributes(name: String, value: String) -> PhysicalAttribute {
        return PhysicalAttribute(attribute: name, value: value)
    }
    
    private func makeFilm(name: String?, openingCrawl: String?, url: URL) -> Film {
        return Film(name: name, openingCrawl: openingCrawl, url: url)
    }

}
