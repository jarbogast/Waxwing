//
//  PostingTestCase.swift
//  Waxwing
//
//  Created by Jonathan Arbogast on 8/28/16.
//  Copyright © 2016 Jonathan Arbogast. All rights reserved.
//

import XCTest
@testable import Waxwing

class PostingTestCase: XCTestCase {
    
    func testNormalPosting() {
        let posting = Posting(string:"Expenses:Utilities:Cable  $35.00")
        let expectedPosting = Posting(accountName: "Expenses:Utilities:Cable", amount: 3500)
        XCTAssertEqual(posting, expectedPosting)
    }
    
    func testPostingWithInsufficientWhitespace() {
        let posting = Posting(string:"Expenses:Utilities:Cable $35.00")
        XCTAssertNil(posting)
    }
    
}
