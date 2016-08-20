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
    let entries: [Entry]
}

extension Transaction {
    init(transactionLines: [String]) {
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
        
        var parsedEntries = [Entry]()
        for i in 1..<transactionLines.count {
            let string = transactionLines[i]
            parsedEntries.append(Entry(string: string))
        }
        
        let implicitAmountEntries = parsedEntries.filter { $0.amount == nil }
        let explicitAmountEntries = parsedEntries.filter { $0.amount != nil }
        if implicitAmountEntries.count == 1 {
            var explicitTotal: Int64 = 0;
            for entry in explicitAmountEntries {
                explicitTotal += entry.amount!
            }
            let explicitEntry = Entry(accountName: implicitAmountEntries[0].accountName, amount: -explicitTotal)
            entries = explicitAmountEntries + [explicitEntry]
        } else {
            entries = parsedEntries
        }
    }
}
