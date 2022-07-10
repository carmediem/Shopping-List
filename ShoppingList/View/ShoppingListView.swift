//
//  ShoppingListView.swift
//  ShoppingList
//
//  Created by Carmen Chiu on 7/10/22.
//

import SwiftUI

struct ShoppingListView: View {
    
    var entry: Entry?
    
    @ObservedObject var entryViewModel = ShoppingListViewModel()
    @State private var itemName: String = ""
    @State private var quantity: String = ""
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 4) {
                Text("Item Name")
                    .bold()
                    .padding(.leading, 20)
                    
                TextField("Enter name", text: $itemName )
                    .padding(.leading, 20)

                
                Text("Item Quantity")
                    .bold()
                    .padding(.leading, 20)

                TextField("Item quantity", text: $quantity)
                    .padding(.leading, 20)
                    .padding(.bottom)
                
                List {
                    ForEach(entryViewModel.entries) { entry in
                        cellBody(entry: entry)
                    }
                    .onDelete(perform: entryViewModel.deleteEntry(at:))
                    .font(.system(size: 14))
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            entryViewModel.createEntry(Entry(itemName: itemName, quantity: quantity, isSelected: false))
                            itemName = ""
                            quantity = ""
                        } label: {
                            Text("Save")
                        }
                    }
                }
                .onAppear {
                    setupViews()
                }
            }
            .padding(.top, -20)
            .padding(.leading, 5)
            .padding(.trailing, 5)
        }
        .frame(alignment: .topLeading)
        .font(.system(size: 14))
    }
    
    func setupViews() {
        entryViewModel.loadFromPersistanceStore()
    }
} //end of struct


struct cellBody: View {
    var entry: Entry
    
    @State var isSelected: Bool = false
    
    var body: some View {
        HStack {
            Group {
                Toggle("", isOn: $isSelected)
                    .labelsHidden()
                    .toggleStyle(ToggleCheckboxStyle())
                    .font(.title)
                
            }
            VStack(alignment: .leading) {
                Text(entry.itemName)
                    .foregroundColor(.primary)
                    .font(.system(size: 14))
                    .bold()
                Text("\(entry.quantity)")
                    .foregroundColor(.primary)
                    .font(.system(size: 14))
            }
            .cornerRadius(8)
        }
    }
}

struct ToggleCheckboxStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            Button {
                configuration.isOn.toggle()
                
            } label: {
                Image(systemName: configuration.isOn ? "checkmark.square" : "square")
                    .font(.system(size: 16))
            }
            .tint(.black)
        }
    }
}


struct ShoppingListView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingListView()
    }
}
