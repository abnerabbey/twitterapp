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
    
    override func setUp() {
        super.setUp()
        sut = ComposeViewModel()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
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
}
