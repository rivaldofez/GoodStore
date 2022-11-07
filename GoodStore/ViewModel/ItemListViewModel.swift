//
//  ItemListViewModel.swift
//  GoodStore
//
//  Created by Rivaldo Fernandes on 07/11/22.
//

import Foundation
import CloudKit


enum RecordType: String{
    case itemListing = "ItemListing"
}


class ItemListViewModel: ObservableObject {
    private var database: CKDatabase
    private var container: CKContainer
    
    init(container: CKContainer){
        self.container = container
        self.database = self.container.publicCloudDatabase
    }
    
    func saveItem(title: String, price: Decimal){
        let record = CKRecord(recordType: RecordType.itemListing.rawValue)
        let itemListing = ItemListing(title: title, price: price)
        record.setValuesForKeys(itemListing.toDictionary())
        
        //saving record to database
        self.database.save(record){ newRecord, error in
            if let error = error{
                print(error)
            }else{
                if let _ = newRecord{
                    print("SAVED")
                }
            }
            
        }
    }
}
