//
//  BoardToDeathUITests.swift
//  BoardToDeathUITests
//
//  Created by Özgün Yildiz on 19.04.21.
//  Copyright © 2021 Caleb Stultz. All rights reserved.
//

import XCTest
@testable import BoardToDeath

class BoardToDeathUITests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUpWithError() throws {
        app = XCUIApplication()
        continueAfterFailure = false
        app.launchArguments.append("--uitesting")
        
    }

    override func tearDownWithError() throws {
       app = nil
    }
    
    func testOnboarding_WhenSwiped_NextVCLoads() {
        app.launch()
        
        XCTAssertTrue(app.staticTexts["Welcome to BoardToDeath"].exists)
        
        app.swipeLeft()
        
        XCTAssertTrue(app.staticTexts["Custom Puppy Content"].exists)
    }
    
    func testTemp() {
        app.launch()
        app.swipeLeft()
        app.swipeLeft()
        app.buttons["Done"].tap()
    }

    
    func testOnboarding_WhenFinished_OnboardVCDismisses() {
        app.launch()
        
        XCTAssertTrue(app.isDisplayingOnboarding)
        
        app.swipeLeft()
        app.swipeLeft()
        app.buttons["Done"].tap()
        
        XCTAssertFalse(app.isDisplayingOnboarding)
    }
    
    func testInterfaceVC_AlertViewShows_WhenOnboardingComplete() {
        app.launch()
        app.swipeLeft()
        app.swipeLeft()
        app.buttons["Done"].tap()
        XCTAssertTrue(app.isDisplayingAlertVC, "Alert VC should show when onboarding dismisses")
    }
    
    
    func testEmailInput_WhenGivenEmail_FillsTextField() {
        app.launch()
        app.swipeLeft()
        app.swipeLeft()
        app.buttons["Done"].tap()

        let emailTextField = app.textFields["Email"]
        emailTextField.tap()
        emailTextField.typeText("oz@hotmail.de")
        
        XCTAssertTrue(app.textFields["oz@hotmail.de"].exists)
    }
    
    func testPasswordInput_WhenGivenPassword_FillsTextField() {
        app.launch()
        app.swipeLeft()
        app.swipeLeft()
        app.buttons["Done"].tap()

        let emailTextField = app.textFields["Password"]
        emailTextField.tap()
        emailTextField.typeText("I am a non-real user typing this")
        
        XCTAssertTrue(app.textFields["I am a non-real user typing this"].exists)
    }
    
    
}

extension XCUIApplication {
    var isDisplayingOnboarding: Bool {
        return otherElements["onboardingView"].exists
    }
    
    var isDisplayingAlertVC: Bool {
        return alerts["You did it!"].exists
    }
}
