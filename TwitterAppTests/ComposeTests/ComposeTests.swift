//
//  ComposeTests.swift
//  TwitterAppTests
//
//  Created by Abner Castro on 24/08/20.
//  Copyright © 2020 Abner Castro. All rights reserved.
//

import XCTest
@testable import TwitterApp

class ComposeTests: XCTestCase {
    
    var sut: ComposeViewModel!
    var mockAPIService: MockFetcher<PostTweetResponse>!
    
    override func setUp() {
        super.setUp()
        mockAPIService = MockFetcher(tweets: .init(code: "200", message: "success"))
        sut = ComposeViewModel(fetcher: AnyFetcher(fetcher: mockAPIService))
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testMaxCharLimit() {
        XCTAssertEqual(sut.totalChars, 140, "Limit number of chars is not 140")
    }
    
    func testPhotosGrantExists() {
        XCTAssertNotNil(sut.photosGrant)
    }
    
    func testPhotosGrantInitialValueIsNil() {
        XCTAssertNil(sut.photosGrant.value)
    }
    
    func testImageSelectedExists() {
        XCTAssertNotNil(sut.imageSelected)
    }
    
    func testImageSelectedInitialValueIsNil() {
        XCTAssertNil(sut.imageSelected.value)
    }
    
    func testStatusInitalValueIsEmpty() {
        XCTAssert(sut.status.isEmpty, "Status for tweet is not initially empty")
    }
    
    func testCharacterRemainingIsZero() {
//        given
        let test = "sdaSDJKAJDJSADH ASDOIADJAOSI AOID OQIWE. AS asdalskdasdasidjoicnas aspdopvoksdovksdov asdasodasdjosaijdosiajdasi asoidjasoidjsiisiaosidj dij"
        XCTAssertEqual(test.count, 140)
        
//        when
        let number = sut.charactersRemaining(text: test, range: .init(location: 0, length: test.count), inputText: "o")
        
//        then
        XCTAssertEqual(number, 1)
        
    }
    
    func testStateWhenPublishTweet() {
//        given
        let test = "Hola este es un tweet de prueba"
        sut.status = test
        let state: State = .fetching
        
//        when
        sut.publishTweet()
        
//        then
        XCTAssertEqual(state, sut.state.value, "Is not fetching")
    }
    
    func testFetchingSuccess() {
//        given
        let state: State = .success
        
//        when
        sut.publishTweet()
        mockAPIService.fetchWithSuccess()
        
//        then
        XCTAssertEqual(sut.state.value, state, "Is not success")
        
    }
    
    func testFetchingFailed() {
//        given
        let state: State = .error
        
//        when
        sut.publishTweet()
        mockAPIService.fetchFail(error: .anError)
        
//        then
        XCTAssertEqual(sut.state.value, state, "Is not failed")
        
    }
}
