//
//  ContentView.swift
//  Final_Project
//
//  Created by Aritchai Hunnapachai on 30/12/2566 BE.
//

import SwiftUI
import UIKit

class TabSelectionViewModel: ObservableObject {
    @Published var selectedTab: Int = 0
}

struct ContentView: View {
    @StateObject var database = Database() // Declare database class as stateObject
    @StateObject private var tabSelectionViewModel = TabSelectionViewModel() // Declare tableview stateObject for switching between each pages
//    @State private var isLinkActive = false
    
    var body: some View {
        
        // The container that containe all the display pages in the application
        TabView(selection: $tabSelectionViewModel.selectedTab)
        {
            // The main page which display all items in the appplication, and leads to page of each item
            Main(database: database).tabItem {
                Image(systemName: "house.fill")
                Text("Home")
            }
            .tag(0)
            
            // The search page for the user to search for a particular item in the application
            Search(database: database).tabItem
            {
                Image(systemName: "magnifyingglass")
                Text("Search")
            }
            .tag(1)
            
            // The cart page displays all the item we selected to purchase, and selected the location where the food will be drop off
            Cart(database: database).tabItem
            {
                Image(systemName: "cart.fill")
                Text("Cart")
            }
            .tag(2)
            
            // The user page displays all the locations where all the items can be submit.
            User(database: database).tabItem
            {
                Image(systemName: "person.fill")
                Text("User")
            }
            .tag(3)
            
        }
        .onAppear(){
            UITabBar.appearance().backgroundColor = .cyan
        }
        .environmentObject(tabSelectionViewModel)
        .accentColor(Color("PrimaryColor"))

    }
    
    
}

#Preview {
    ContentView()
}
