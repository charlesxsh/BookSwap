
let app = XCUIApplication()
let emailTextField = app.textFields["Email"]
emailTextField.tap()
emailTextField.typeText("sxia@pi")

let displayNameTextField = app.textFields["Display Name"]
displayNameTextField.tap()
displayNameTextField.tap()
displayNameTextField.typeText("sdfsdfsdf")

let passwordSecureTextField = app.secureTextFields["Password"]
passwordSecureTextField.tap()
passwordSecureTextField.tap()
passwordSecureTextField.typeText("asdf")

let confirmPasswordSecureTextField = app.secureTextFields["Confirm Password"]
confirmPasswordSecureTextField.tap()
confirmPasswordSecureTextField.tap()
confirmPasswordSecureTextField.typeText("asdf")
app.childrenMatchingType(.Window).elementBoundByIndex(0).childrenMatchingType(.Other).elementBoundByIndex(1).childrenMatchingType(.Other).element.childrenMatchingType(.Image).element.tap()
app.sheets["Choose from"].collectionViews.buttons["Library"].tap()
app.tables.buttons["Moments"].tap()
app.collectionViews.cells["Photo, Landscape, March 12, 2011, 7:17 PM"].tap()
app.buttons["Confirm"].tap()
//
//  BookSwapUITests.swift
//  BookSwapUITests
//
//  Created by Charles Xia on 1/22/16.
//  Copyright © 2016 Charles. All rights reserved.
//

import XCTest

class BookSwapUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
}
