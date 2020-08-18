//
//  ViewModelMockTests.swift
//  TwitterAppTests
//
//  Created by Abner Castro on 18/08/20.
//  Copyright © 2020 Abner Castro. All rights reserved.
//

import XCTest
@testable import TwitterApp

class TwitterAppTests: XCTestCase {
    
    var sut: FeedViewModel!
    var mockAPIService: MockFetcher<[Tweet]>!
    
    override func setUp() {
        super.setUp()
        mockAPIService = MockFetcher(tweets: [])
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
    
    func testViewModelTweetsVariableIsEmpty() {
        XCTAssertEqual(sut.tweetsCount, 0, "Varaible that contains tweets is not empty")
    }
    
    func testViewModelIsFetching() {
        sut.fetchTimeLine()
        XCTAssertTrue(sut.state.value == .fetching, "State is not error")
        
    }
    
    func testFetchingFailed() {
        
//        given
        let state: State = .error
        
//        when
        sut.fetchTimeLine()
        mockAPIService.fetchFail(error: .anError)
        
//        then
        XCTAssertEqual(sut.state.value, state, "Thist test wasn't an error value")
    }
    
    func testFetchingSuccess() {
        
//        given
        let state: State = .success
        
//        when
        sut.fetchTimeLine()
        mockAPIService.fetchWithSuccess()
        
//        then
        XCTAssertEqual(sut.state.value, state, "This test wasn't a success value")
        
    }
    
}
