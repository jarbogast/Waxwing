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
    let thirdPartyName: String
}

extension Transaction {
    init(transactionLines: [String]) {
        let firstLine = transactionLines.first!
        var tokens = firstLine.components(separatedBy: CharacterSet.whitespaces)
        date = tokens[0]
        
        tokens.removeFirst()
        tokens = tokens.filter { $0.characters.count > 0 }
        thirdPartyName = tokens.joined(separator: " ")
    }
}
