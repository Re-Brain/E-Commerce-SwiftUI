//
//  Search.swift
//  Final_Project
//
//  Created by Aritchai Hunnapachai on 31/12/2566 BE.
//

import SwiftUI

struct Search: View {
    
    @ObservedObject var database: Database // Declare database class as stateObject
    @State private var searchText = "" // The text that user input for searching
    
    var body: some View {
        VStack
        {
            NavigationView
            {
                
                List(database.filteredData, id: \.self) { item in
                    NavigationLink(destination: Item(value: item, database: database), label:
                    {
                        Text(item)
                    })
                    .listRowBackground(Color("PrimaryColor"))
                    .navigationBarTitleDisplayMode(.inline)
                }
                .scrollContentBackground(.hidden)
                .listStyle(InsetGroupedListStyle())
                .searchable(text : $searchText, prompt: "Find an item")
                .onChange(of: searchText)
                { newQuery in
                    database.searchItems(with : newQuery)
                }
                .onAppear()
                {
                    database.searchItems(with: "")
                    searchText = ""
                }
            }
        }
    }
}

#Preview {
    Search(database: Database())
}
