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
    
    @Published var items: [ItemViewModel] = []
    
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
                if let newRecord = newRecord{
                    if let itemListing = ItemListing.fromRecord(newRecord){
                        DispatchQueue.main.async {
                            self.items.append(ItemViewModel(itemListing: itemListing))
                        }
                    }
                }
            }
            
        }
    }
    
    func populateItems() {
        let query = CKQuery(recordType: RecordType.itemListing.rawValue, predicate: NSPredicate(value: true))
        var items: [ItemListing] = []
        
        database.fetch(withQuery: query, completionHandler: { result in
            switch result {
                case .success(let result):
                    print(result.matchResults)
                    result.matchResults.compactMap{$0.1}
                        .forEach {
                            switch $0 {
                            case .success(let record):
                                if let itemListing = ItemListing.fromRecord(record){
                                    items.append(itemListing)
                                }
                                
                                print(record)
                            case .failure(let error):
                                print(error)
                            }
                        }
                DispatchQueue.main.async {
                    self.items = items.map(ItemViewModel.init)
                }
                case .failure(let error):
                    print(error)
            }
        })
    }
}

struct ItemViewModel {
    let itemListing: ItemListing
    
    var recordId: CKRecord.ID? {
        itemListing.recordId
    }
    
    var title: String {
        itemListing.title
    }
    
    var price: Decimal {
        itemListing.price
    }
}
