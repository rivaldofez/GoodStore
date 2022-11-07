//
//  GoodStoreApp.swift
//  GoodStore
//
//  Created by Rivaldo Fernandes on 07/11/22.
//

import SwiftUI
import CloudKit

@main
struct GoodStoreApp: App {
    
    
    //public container
    let container = CKContainer(identifier: "iCloud.com.rivaldofez.goodstores")

    var body: some Scene {
        WindowGroup {
            ContentView(vm: ItemListViewModel(container: container))
        }
    }
}
