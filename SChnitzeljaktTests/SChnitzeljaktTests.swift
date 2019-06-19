//
//  SChnitzeljaktTests.swift
//  SChnitzeljaktTests
//
//  Created by Harrison Weinerman on 10/14/18.
//  Copyright © 2018 SChnitzeljakt. All rights reserved.
//

import XCTest
@testable import SChnitzeljakt

class SChnitzeljaktTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testUpdateStatus() {
        let status = DataManager.shared.updateStatus(lat: 123.4, long: 146.7)
        XCTAssertEqual(status.progress, 100)
        XCTAssertNotNil(status.achievement)
    }
    
    func testUpdateStatusInvalidLocation() {
        let status = DataManager.shared.updateStatus(lat: 0, long: 0)
        XCTAssertLessThan(status.progress, 100)
        XCTAssertNil(status.achievement)
    }
    
    func testGoodLogin() {
        DataManager.shared.login(username: "testUser", password: "testPassword")
        XCTAssertNotNil(DataManager.shared.loggedInUser)
        XCTAssertEqual(DataManager.shared.loggedInUser?.name, "Test User")
    }
    
    func testbadLogin() {
        DataManager.shared.login(username: "notAUser", password: "badPassword")
        XCTAssertNil(DataManager.shared.loggedInUser)
    }
    
    func testLogout() {
        DataManager.shared.login(username: "testUser", password: "testPassword")
        XCTAssertNotNil(DataManager.shared.loggedInUser)
        DataManager.shared.logout()
        XCTAssertNil(DataManager.shared.loggedInUser)
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
