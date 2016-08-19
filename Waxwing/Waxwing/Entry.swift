//
//  Entry.swift
//  Waxwing
//
//  Created by Jonathan Arbogast on 8/17/16.
//  Copyright © 2016 Jonathan Arbogast. All rights reserved.
//

import Foundation

struct Entry {
    let payee: String
    let amount: Int64
}

extension Entry {
    init(string: String) {
        var tokens = string.components(separatedBy: CharacterSet.whitespaces)
        tokens = tokens.filter { $0.characters.count > 0 }
        payee = tokens[0]
        
        let amountString = tokens[1]
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.negativeFormat = numberFormatter.currencySymbol + "-#,##0.00"
        let amountNumber = numberFormatter.number(from: amountString)
        amount = Int64((amountNumber?.doubleValue)! * 100)
    }
}

extension Entry: Equatable {}

func ==(lhs: Entry, rhs: Entry) -> Bool {
    return lhs.payee == rhs.payee && lhs.amount == rhs.amount
}
