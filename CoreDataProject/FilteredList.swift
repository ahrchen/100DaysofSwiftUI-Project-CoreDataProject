//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Raymond Chen on 3/14/22.
//

import CoreData
import SwiftUI

struct FilteredList<T: NSManagedObject, Content: View>: View {
    @FetchRequest var fetchRequest: FetchedResults<T>
    let content: (T) -> Content
    
    enum PredicateType: String {
        case beginsWith = "BEGINSWITH"
        case contains = "CONTAINS"
        case containsCI = "CONTAINS[c]"
    }
    
    var body: some View {
        List(fetchRequest, id: \.self) { item in
            self.content(item)
        }
    }
    
    init(filterKey: String,  filterPredicate: PredicateType, filterValue: String,sortDescriptors:[NSSortDescriptor], @ViewBuilder content: @escaping (T) -> Content) {
        _fetchRequest = FetchRequest<T>(sortDescriptors: sortDescriptors, predicate: NSPredicate(format: "%K \(filterPredicate.rawValue) %@", filterKey, filterValue))
        self.content = content
    }
}
