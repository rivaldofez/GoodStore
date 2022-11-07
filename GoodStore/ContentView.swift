//
//  ContentView.swift
//  GoodStore
//
//  Created by Rivaldo Fernandes on 07/11/22.
//

import SwiftUI
import CoreData
import CloudKit

struct ContentView: View {
    @StateObject private var vm: ItemListViewModel
    
    
    @State private var title: String = ""
    @State private var price: String = ""
    
    init(vm: ItemListViewModel){
        _vm = StateObject(wrappedValue: vm)
    }
    
    
    var body: some View {
        NavigationView{
            VStack {
                TextField("Enter title", text: $title)
                    .textFieldStyle(.roundedBorder)
                TextField("Enter price", text: $price)
                    .textFieldStyle(.roundedBorder)
                
                Button("Save"){
                    guard let price = try? Decimal(price, format: .number) else { return }
                    
                    vm.saveItem(title: title, price: price)
                    
                    self.title = ""
                    self.price = ""
                    
                }
                
                Spacer()
                
                List{
                    ForEach(vm.items, id: \.recordId){ item in
                        HStack {
                            Text(item.title)
                            Spacer()
                            Text("$" + String(describing: item.price))
                        }
                    }
                }
                    .navigationTitle("Good Store")
            }.padding()
                .onAppear{
                    vm.populateItems()
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(vm: ItemListViewModel(container: CKContainer.default()))
    }
}
