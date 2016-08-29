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
    
    func testTransactionWithTwoPostings() {
        let transactionLines = ["2015/10/12  Exxon",
                                "   Expenses:Auto:Gas         $10.00",
                                "   Liabilities:MasterCard   $-10.00"]
        
        let expectedPosting1 = Posting(accountName: "Expenses:Auto:Gas", amount: 1000)
        let expectedPosting2 = Posting(accountName: "Liabilities:MasterCard", amount: -1000)
        let expectedPostings = [expectedPosting1, expectedPosting2]
        assert(transactionLines: transactionLines, resultInTransactionWithDate: "2015/10/12", payee: "Exxon", checkNumber: nil, postings: expectedPostings)
    }
    
    func testTransactionWithCheckNumber() {
        let transactionLines = ["9/29 (1023) Pacific Bell",
                                "Expenses:Utilities:Phone  $23.00",
                                "Assets:Checking  $-23.00"]
        
        let expectedPosting1 = Posting(accountName: "Expenses:Utilities:Phone", amount: 2300)
        let expectedPosting2 = Posting(accountName: "Assets:Checking", amount: -2300)
        let expectedPostings = [expectedPosting1, expectedPosting2]
        assert(transactionLines: transactionLines, resultInTransactionWithDate: "9/29", payee: "Pacific Bell", checkNumber: "1023", postings: expectedPostings)
    }
    
    func testTransactionWithImplicitAmount() {
        let transactionLines = ["9/29 (1023) Pacific Bell",
                                "Expenses:Utilities:Phone  $23.00",
                                "Expenses:Utilities:Cable  $35.00",
                                "Assets:Checking"]
        
        let expectedPosting1 = Posting(accountName: "Expenses:Utilities:Phone", amount: 2300)
        let expectedPosting2 = Posting(accountName: "Expenses:Utilities:Cable", amount: 3500)
        let expectedPosting3 = Posting(accountName: "Assets:Checking", amount: -5800)
        let expectedPostings = [expectedPosting1, expectedPosting2, expectedPosting3]
        assert(transactionLines: transactionLines, resultInTransactionWithDate: "9/29", payee: "Pacific Bell", checkNumber: "1023", postings: expectedPostings)
    }
    
    func testTransactionWithNoPostings() {
        assertTransactionLinesResultInInvalidTransaction(["9/29 (1023) Pacific Bell"])
    }
    
    func testTransactionWithInsufficientWhitespaceInPosting() {
        assertTransactionLinesResultInInvalidTransaction(["9/29 (1023) Pacific Bell",
                                                          "Expenses:Utilities:Phone  $23.00",
                                                          "Expenses:Utilities:Cable $35.00",
                                                          "Assets:Checking"])
    }
    
    func testTransactionWithUnequalPostings() {
        assertTransactionLinesResultInInvalidTransaction(["9/29 (1023) Pacific Bell",
                                                          "Expenses:Utilities:Phone  $23.00",
                                                          "Expenses:Utilities:Cable  $35.00",
                                                          "Assets:Checking           $-99.00"])
    }
    
    func assertTransactionLinesResultInInvalidTransaction(_ transactionLines: [String]) {
        let transaction = Transaction(transactionLines: transactionLines)
        XCTAssertNil(transaction)
    }
    
    func assert(transactionLines: [String], resultInTransactionWithDate date: String, payee: String, checkNumber: String?, postings: [Posting]) {
        if let transaction = Transaction(transactionLines: transactionLines) {
            XCTAssertEqual(transaction.date, date)
            XCTAssertEqual(transaction.payee, payee)
            XCTAssertEqual(transaction.checkNumber, checkNumber)
            XCTAssertEqual(transaction.postings, postings)
        } else {
            XCTFail("Invalid transaction")
        }
    }
}
