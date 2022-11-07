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
    
    static func fromRecord(_ record: CKRecord) -> ItemListing? {
        guard let title = record.value(forKey: "title") as? String, let price = record.value(forKey: "price") as? Double else {
            return nil
        }
        
        return ItemListing(recordId: record.recordID, title: title, price: Decimal(price))
    }
    
}
