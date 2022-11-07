//
//  ItemListing.swift
//  GoodStore
//
//  Created by Rivaldo Fernandes on 07/11/22.
//

import Foundation
import SwiftUI
import CloudKit

struct ItemListing{
    var recordId: CKRecord.ID?
    let title: String
    let price: Decimal
    
    init(recordId: CKRecord.ID? = nil, title: String, price: Decimal) {
        self.recordId = recordId
        self.title = title
        self.price = price
    }
    
    func toDictionary() -> [String: Any]{
        return ["title": title, "price": price]
    }
    
}
