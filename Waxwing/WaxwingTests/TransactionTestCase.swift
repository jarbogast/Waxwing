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
    
    func testTransactionWithNoEntries() {
        let transactionLines: [String] = ["2015/10/12  Exxon"]
        let transaction = Transaction(transactionLines: transactionLines)
        
        XCTAssertEqual(transaction.date, "2015/10/12")
        XCTAssertEqual(transaction.payee, "Exxon")
    }
    
    func testTransactionWithTwoEntries() {
        let transactionLines: [String] = ["2015/10/12  Exxon",
                                          "   Expenses:Auto:Gas         $10.00",
                                          "   Liabilities:MasterCard   $-10.00"]
        let transaction = Transaction(transactionLines: transactionLines)
        
        let expectedEntry1 = Entry(accountName: "Expenses:Auto:Gas", amount: 1000)
        let expectedEntry2 = Entry(accountName: "Liabilities:MasterCard", amount: -1000)
        
        XCTAssertEqual(transaction.date, "2015/10/12")
        XCTAssertEqual(transaction.payee, "Exxon")
        XCTAssertEqual(transaction.entries, [expectedEntry1, expectedEntry2])
    }
}
