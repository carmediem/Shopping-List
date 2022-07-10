//
//  ShoppingListViewModel.swift
//  ShoppingList
//
//  Created by Carmen Chiu on 7/10/22.
//

import SwiftUI

class ShoppingListViewModel: ObservableObject {
    
    @Published var entries: [Entry] = []
    
    static let shared = ShoppingListView.self
    
    func createEntry(_ entry: Entry) {
        entries.append(entry)
        saveToPersistanceStore()
    }
    
    func toggleIsSelected(entry: Entry) {
        saveToPersistanceStore()
    }
    
    func deleteEntry(at indexSet: IndexSet) {
        entries.remove(atOffsets: indexSet)
        saveToPersistanceStore()
    }
    
    
    
    //MARK: -- Persistance
    
    func createPersistanceStore() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = paths[0]
        let filename = "Entries.json"
        let fileURL = documentDirectory.appendingPathComponent(filename)
        return fileURL
    }
    
    func saveToPersistanceStore(){
        do {
            let data = try JSONEncoder().encode(entries)
            try data.write(to: createPersistanceStore())
        } catch {
            print("Error encoding our items")
        }
    }
    
    func loadFromPersistanceStore() {
        do {
            let data = try Data(contentsOf: createPersistanceStore())
            entries = try JSONDecoder().decode([Entry].self, from: data)
        } catch {
            print("Error decoding our data into items.")
        }
    }
}
