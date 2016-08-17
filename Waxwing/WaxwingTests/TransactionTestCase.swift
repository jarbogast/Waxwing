//
//  TransactionTestCase.swift
//  Waxwing
//
//  Created by Jonathan Arbogast on 8/14/16.
//  Copyright © 2016 Jonathan Arbogast. All rights reserved.
//

import XCTest
@testable import Waxwing

class TransactionTestCase: XCTestCase {
    
    func testTransactionWithNoTransactions() {
        let transactionLines: [String] = ["9/29  My Employer"]
        let transaction = Transaction(transactionLines: transactionLines)
        
        XCTAssertEqual(transaction.date, "9/29")
        XCTAssertEqual(transaction.thirdPartyName, "My Employer")
    }
}
