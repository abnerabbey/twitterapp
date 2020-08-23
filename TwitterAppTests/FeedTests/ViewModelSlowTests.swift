//
//  ViewModelSlowTests.swift
//  TwitterAppTests
//
//  Created by Abner Castro on 18/08/20.
//  Copyright © 2020 Abner Castro. All rights reserved.
//

import XCTest
@testable import TwitterApp

class ViewModelSlowTests: XCTestCase {
    
    var sut: FeedViewModel!
    var api: AnyFetcher<[Tweet]>!
    
    override func setUp() {
        super.setUp()
        api = AnyFetcher(fetcher: FetcherImplementation())
        sut = FeedViewModel(fetcher: api)
    }
    
    override func tearDown() {
        sut = nil
        api = nil
        super.tearDown()
    }
    
    func testTweetsArrayIsNotEmptyWithSuccessFetch() {
        
//        given
        let exp = expectation(description: "fetching expectation")
        var tweets = 0
        
//        when
        sut.fetchTimeLine()
        sut.state.bind { state in
            tweets = self.sut.tweetsCount
            exp.fulfill()
        }
        wait(for: [exp], timeout: 4)
        
//        then
        XCTAssertTrue(tweets > 0)
    }
    
    func testFetchingTweetsPerformance() {
        
        measure {
            self.sut.fetchTimeLine()
        }
        
    }
    
}
