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
    @StateObject var database = Database()
    @StateObject private var tabSelectionViewModel = TabSelectionViewModel()
    @State private var isLinkActive = false
    
//    init()
//    {
//        for familyName in UIFont.familyNames {
//            print(familyName)
//            
//            for fontName in UIFont.fontNames(forFamilyName: familyName){
//                print("-- \(fontName)")
//            }
//        }
//    }
    
    var body: some View {
        
        TabView(selection: $tabSelectionViewModel.selectedTab)
        {
            Main(database: database).tabItem {
                Image(systemName: "house.fill")
                Text("Home")
            }
            .tag(0)
            
            Search(database: database).tabItem
            {
                Image(systemName: "magnifyingglass")
                Text("Search")
            }
            .tag(1)
            
            Cart(database: database).tabItem
            {
                Image(systemName: "cart.fill")
                Text("Cart")
            }
            .tag(2)
            
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
