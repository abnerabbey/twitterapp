//
//  SearchViewModelMockTests.swift
//  TwitterAppTests
//
//  Created by Abner Castro on 02/09/20.
//  Copyright © 2020 Abner Castro. All rights reserved.
//

import Foundation
import XCTest
@testable import TwitterApp

class SearchViewModelMockTests: XCTestCase {

    var sut: SearchViewModel!
    var mockAPIService: MockFetcher<SearchResult>!
    
    override func setUp() {
        super.setUp()
        mockAPIService = MockFetcher(tweets: SearchResult(tweets: []))
        sut = SearchViewModel(fetcher: AnyFetcher(fetcher: mockAPIService))
    }
    
    override func tearDown() {
        sut = nil
        mockAPIService = nil
        super.tearDown()
    }
    
    func testFlowIsSearch() {
        let flowState = Flow.search
        XCTAssertEqual(sut.flow, flowState, "Flow state is not searching")
    }
    
    func testTweetsArrayIsEmpty() {
        XCTAssert(sut.tweetsCount == 0, "Tweets array is not empty")
    }
    
    func testStateVariableIsNotNil() {
        XCTAssertNotNil(sut.state)
    }
    
    func testViewModelIsFetching() {
//        given
        let aString = "aString"
        let state = State.fetching
        
//        when
        sut.fetchByHashTag(aString)
        
//        then
        XCTAssertEqual(sut.state.value, state, "The State is not fetching")
        
    }
    
    func testFetchingFailed() {
//        given
        let state = State.error
        let error = APIErrors.anError
        let aString = "aString"
        
//        when
        sut.fetchByHashTag(aString)
        mockAPIService.fetchFail(error: error)
        
//        then
        XCTAssertEqual(sut.state.value, state, "There wasn't an error in this test")
    }
    
    func testFetchingSuccess() {
//        given
        let state = State.success
        let aString = "aString"
        
//        when
        sut.fetchByHashTag(aString)
        mockAPIService.fetchWithSuccess()
        
        XCTAssertEqual(sut.state.value, state, "This test did't result in a success")
        
    }
}
