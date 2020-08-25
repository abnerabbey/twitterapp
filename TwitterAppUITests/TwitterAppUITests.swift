//
//  TwitterAppUITests.swift
//  TwitterAppUITests
//
//  Created by Abner Castro on 14/08/20.
//  Copyright © 2020 Abner Castro. All rights reserved.
//

import XCTest
@testable import TwitterApp

class TwitterAppUITests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDown() {
        app = nil
        super.tearDown()
    }
    
    func testTextViewEmpty() {
        app.navigationBars["WizeTweet"].buttons["Add"].tap()
        let textView = app.textViews["textView"]
        
        XCTAssertEqual(textView.label, "")
    }
    
    func testCounterLabelInitalValue() {
        app.navigationBars["WizeTweet"].buttons["Add"].tap()
        
        let counterLabel = app.staticTexts["counterLabel"]
        
        XCTAssertEqual(counterLabel.label, "Characters remaining: 140")
    }
    
    func testLimitCharactersCounterLabel() {
        
        app.navigationBars["WizeTweet"].buttons["Add"].tap()
        let textView = app.textViews["textView"]
        textView.typeText("sdaSDJKAJDJSADH ASDOIADJAOSI AOID OQIWE. AS asdalskdasdasidjoicnas aspdopvoksdovksdov asdasodasdjosaijdosiajdasi asoidjasoidjsiisiaosidj dji")
        
        let counterLabel = app.staticTexts["counterLabel"]
        
        XCTAssertEqual(counterLabel.label, "Characters remaining: 0")
    }
    
    func testTextCounterLabelMoreThanCharsLimit() {
        
        let test = "sdaSDJKAJDJSADH ASDOIADJAOSI AOID OQIWE. AS asdalskdasdasidjoicnas aspdopvoksdovksdov asdasodasdjosaijdosiajdasi asoidjasoidjsiisiaosidj dij"
        XCTAssert(test.count == 140)
        
        app.navigationBars["WizeTweet"].buttons["Add"].tap()
        let textView = app.textViews["textView"]
        textView.typeText(test + "Esta cadena es para prueba. No tiene que aparecer en el textview y el counter label tiene que permancer en cero")
        
        let counterLabel = app.staticTexts["counterLabel"]
        
        XCTAssertEqual(counterLabel.label, "Characters remaining: 0")
        
    }
    
    func testTextMoreThanLimitCharacters() {
        let test = "sdaSDJKAJDJSADH ASDOIADJAOSI AOID OQIWE. AS asdalskdasdasidjoicnas aspdopvoksdovksdov asdasodasdjosaijdosiajdasi asoidjasoidjsiisiaosidj dji"
        XCTAssertEqual(test.count, 140)
        
        app.navigationBars["WizeTweet"].buttons["Add"].tap()
        let textView = app.textViews["textView"]
        textView.typeText(test + "Hola esta cadena es más larga de los 140 y no aparecerá finalmente")
        
        let text = (textView.value as? String) ?? ""
        
        
        XCTAssertEqual(text, test)
    }
}
