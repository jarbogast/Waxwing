//
//  Posting.swift
//  Waxwing
//
//  Created by Jonathan Arbogast on 8/17/16.
//  Copyright © 2016 Jonathan Arbogast. All rights reserved.
//

import Foundation

struct Posting {
    let accountName: String
    let amount: Int64?
}

extension Posting {
    init(string: String) {
        var tokens = string.components(separatedBy: CharacterSet.whitespaces)
        tokens = tokens.filter { $0.characters.count > 0 }
        accountName = tokens[0]
        
        if tokens.count > 1 {
            let amountString = tokens[1]
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .currency
            numberFormatter.negativeFormat = numberFormatter.currencySymbol + "-#,##0.00"
            let amountNumber = numberFormatter.number(from: amountString)
            amount = Int64((amountNumber?.doubleValue)! * 100)
        } else {
            amount = nil
        }
    }
}

extension Posting: Equatable {}

func ==(lhs: Posting, rhs: Posting) -> Bool {
    return lhs.accountName == rhs.accountName && lhs.amount == rhs.amount
}
