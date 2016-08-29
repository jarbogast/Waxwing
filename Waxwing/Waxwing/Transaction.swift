//
//  Transaction.swift
//  Waxwing
//
//  Created by Jonathan Arbogast on 8/14/16.
//  Copyright © 2016 Jonathan Arbogast. All rights reserved.
//

import Foundation

struct Transaction {
    let date: String
    let payee: String
    let checkNumber: String?
    let postings: [Posting]
}

extension Transaction {
    init?(transactionLines: [String]) {
        guard transactionLines.count >= 3 else { return nil }
        
        let firstLine = transactionLines.first!
        var tokens = firstLine.components(separatedBy: CharacterSet.whitespaces)
        tokens = tokens.filter { $0.characters.count > 0 }

        date = tokens[0]
        tokens.removeFirst()
        
        if tokens[0].hasPrefix("(") {
            checkNumber = tokens[0].trimmingCharacters(in: CharacterSet(charactersIn: "()"))
            tokens.removeFirst()
        } else {
            checkNumber = nil
        }
        
        payee = tokens.joined(separator: " ")
        
        var parsedPostings = [Posting]()
        for i in 1..<transactionLines.count {
            let string = transactionLines[i]
            if let posting = Posting(string: string) {
                parsedPostings.append(posting)
            } else {
                return nil
            }
        }
        
        let implicitAmountPostings = parsedPostings.filter { $0.amount == nil }
        let explicitAmountPostings = parsedPostings.filter { $0.amount != nil }
        if implicitAmountPostings.count == 1 {
            var explicitTotal: Int64 = 0;
            for posting in explicitAmountPostings {
                explicitTotal += posting.amount!
            }
            let explicitPosting = Posting(accountName: implicitAmountPostings[0].accountName, amount: -explicitTotal)
            postings = explicitAmountPostings + [explicitPosting]
        } else {
            postings = parsedPostings
        }
        
        var transactionTotal: Int64 = 0
        for posting in postings {
            if let amount = posting.amount {
                transactionTotal += amount
            }
        }
        
        guard transactionTotal == 0 else { return nil }
    }
}
