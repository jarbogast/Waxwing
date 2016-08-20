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
        let transactionLines = ["2015/10/12  Exxon"]
        let transaction = Transaction(transactionLines: transactionLines)
        
        XCTAssertEqual(transaction.date, "2015/10/12")
        XCTAssertEqual(transaction.payee, "Exxon")
        XCTAssertNil(transaction.checkNumber)
    }
    
    func testTransactionWithTwoEntries() {
        let transactionLines = ["2015/10/12  Exxon",
                                "   Expenses:Auto:Gas         $10.00",
                                "   Liabilities:MasterCard   $-10.00"]
        let transaction = Transaction(transactionLines: transactionLines)
        
        let expectedEntry1 = Entry(accountName: "Expenses:Auto:Gas", amount: 1000)
        let expectedEntry2 = Entry(accountName: "Liabilities:MasterCard", amount: -1000)
        
        XCTAssertEqual(transaction.date, "2015/10/12")
        XCTAssertEqual(transaction.payee, "Exxon")
        XCTAssertNil(transaction.checkNumber)
        XCTAssertEqual(transaction.entries, [expectedEntry1, expectedEntry2])
    }
    
    func testTransactionWithCheckNumber() {
        let transactionLines = ["9/29 (1023) Pacific Bell",
                                "Expenses:Utilities:Phone  $23.00",
                                "Assets:Checking  $-23.00"]
        let transaction = Transaction(transactionLines: transactionLines)
        
        let expectedEntry1 = Entry(accountName: "Expenses:Utilities:Phone", amount: 2300)
        let expectedEntry2 = Entry(accountName: "Assets:Checking", amount: -2300)
        
        XCTAssertEqual(transaction.date, "9/29")
        XCTAssertEqual(transaction.payee, "Pacific Bell")
        XCTAssertEqual(transaction.checkNumber, "1023")
        XCTAssertEqual(transaction.entries, [expectedEntry1, expectedEntry2])
    }
    
}
