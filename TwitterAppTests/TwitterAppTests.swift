//
//  TwitterAppTests.swift
//  TwitterAppTests
//
//  Created by Abner Castro on 14/08/20.
//  Copyright © 2020 Abner Castro. All rights reserved.
//

import XCTest
@testable import TwitterApp

class TwitterAppTests: XCTestCase {
    
    var sut: FeedViewModel!
    var mockAPIService: MockFetcher<[Tweet]>!
    
    override func setUp() {
        super.setUp()
        mockAPIService = MockFetcher()
        sut = FeedViewModel(fetcher: AnyFetcher(fetcher: mockAPIService))
    }
    
    override func tearDown() {
        sut = nil
        mockAPIService = nil
        super.tearDown()
    }
    
    func testViewModelStateNotNil() {
        XCTAssertNotNil(sut.state)
    }
    
    func testViewModelIsFetching() {
        sut.fetchTimeLine()
        XCTAssertTrue(sut.state.value == .fetching, "State is not error")
        
    }
    
    func testFetchingFailed() {
        
        let exp = expectation(description: "failing fetch")
        sut.fetchTimeLine()
        var stat: State? = sut.state.value
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.mockAPIService.fetchFail(error: .anError)
            stat = self.sut.state.value
            exp.fulfill()
        }
        wait(for: [exp], timeout: 2)
        XCTAssertTrue(stat == .error, "Not error in response")
    }
    
}
