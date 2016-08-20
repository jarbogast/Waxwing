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
    
    func testTransactionWithTwoEntries() {
        let transactionLines = ["2015/10/12  Exxon",
                                "   Expenses:Auto:Gas         $10.00",
                                "   Liabilities:MasterCard   $-10.00"]
        
        let expectedEntry1 = Entry(accountName: "Expenses:Auto:Gas", amount: 1000)
        let expectedEntry2 = Entry(accountName: "Liabilities:MasterCard", amount: -1000)
        let expectedEntries = [expectedEntry1, expectedEntry2]
        assert(transactionLines: transactionLines, resultInTransactionWithDate: "2015/10/12", payee: "Exxon", checkNumber: nil, entries: expectedEntries)
    }
    
    func testTransactionWithCheckNumber() {
        let transactionLines = ["9/29 (1023) Pacific Bell",
                                "Expenses:Utilities:Phone  $23.00",
                                "Assets:Checking  $-23.00"]
        
        let expectedEntry1 = Entry(accountName: "Expenses:Utilities:Phone", amount: 2300)
        let expectedEntry2 = Entry(accountName: "Assets:Checking", amount: -2300)
        let expectedEntries = [expectedEntry1, expectedEntry2]
        assert(transactionLines: transactionLines, resultInTransactionWithDate: "9/29", payee: "Pacific Bell", checkNumber: "1023", entries: expectedEntries)
    }
    
    func testTransactionWithImplicitAmount() {
        let transactionLines = ["9/29 (1023) Pacific Bell",
                                "Expenses:Utilities:Phone  $23.00",
                                "Assets:Checking"]
        
        let expectedEntry1 = Entry(accountName: "Expenses:Utilities:Phone", amount: 2300)
        let expectedEntry2 = Entry(accountName: "Assets:Checking", amount: -2300)
        let expectedEntries = [expectedEntry1, expectedEntry2]
        assert(transactionLines: transactionLines, resultInTransactionWithDate: "9/29", payee: "Pacific Bell", checkNumber: "1023", entries: expectedEntries)
    }
    
    func assert(transactionLines: [String], resultInTransactionWithDate date: String, payee: String, checkNumber: String?, entries: [Entry]) {
        let transaction = Transaction(transactionLines: transactionLines)
        
        XCTAssertEqual(transaction.date, date)
        XCTAssertEqual(transaction.payee, payee)
        XCTAssertEqual(transaction.checkNumber, checkNumber)
        XCTAssertEqual(transaction.entries, entries)
    }
}
