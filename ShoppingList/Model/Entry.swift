//
//  Entry.swift
//  ShoppingList
//
//  Created by Carmen Chiu on 7/10/22.
//

import SwiftUI

struct Entry: Identifiable, Equatable, Codable {
    var itemName: String
    var quantity: String
    var id: String = UUID().uuidString
    var isSelected: Bool

    
    static func == (lhs: Entry, rhs: Entry) -> Bool {
      lhs.id == rhs.id

    }
}
