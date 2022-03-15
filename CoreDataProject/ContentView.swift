//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Raymond Chen on 3/13/22.
//

import CoreData
import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var countries: FetchedResults<Country>
    
    @State private var selectedCountry = 0
    
    var availableCountries: [String] {
        var countriesArray:[String] = []
        for country in countries {
            countriesArray.append(country.wrappedShortName)
        }
        return countriesArray
    }
    
    var body: some View {
        VStack {
            FilteredList(filterKey: "shortName", filterPredicate: .beginsWith, filterValue: availableCountries[selectedCountry], sortDescriptors: [NSSortDescriptor(key: "shortName", ascending: true)]) { (country: Country) in
                    Section(country.wrappedFullName) {
                        ForEach(country.candyArray, id: \.self) { candy in
                            Text(candy.wrappedName)
                        }
                    }
                }
            
            Form {
                Section(header: Text("Countries ShortName")) {
                    Picker("Selection", selection: $selectedCountry) {
                        ForEach(0..<availableCountries.count) { i in
                            Text(availableCountries[i])
                        }
                    }
                    .pickerStyle(.segmented)
                }
            }
            
            Button("Add") {
                let candy1 = Candy(context: moc)
                candy1.name = "Mars"
                candy1.origin = Country(context: moc)
                candy1.origin?.shortName = "UK"
                candy1.origin?.fullName = "United Kingdom"
                
                let candy2 = Candy(context: moc)
                candy2.name = "KitKat"
                candy2.origin = Country(context: moc)
                candy2.origin?.shortName = "UK"
                candy2.origin?.fullName = "United Kingdom"
                
                let candy3 = Candy(context: moc)
                candy3.name = "Twix"
                candy3.origin = Country(context: moc)
                candy3.origin?.shortName = "UK"
                candy3.origin?.fullName = "United Kingdom"
                
                let candy4 = Candy(context: moc)
                candy4.name = "Toblerone"
                candy4.origin = Country(context: moc)
                candy4.origin?.shortName = "CH"
                candy4.origin?.fullName = "Switzerland"
                
                try? moc.save()
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
