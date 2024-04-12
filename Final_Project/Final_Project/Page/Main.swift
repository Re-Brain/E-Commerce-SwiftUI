//
//  Main.swift
//  Final_Project
//
//  Created by Aritchai Hunnapachai on 30/12/2566 BE.
//

import Foundation
import SwiftUI
import UIKit

struct Main: View {
    @ObservedObject var database: Database // Declare database class as stateObject
    @EnvironmentObject var tabSelectionViewModel: TabSelectionViewModel // For tableview page selection
    
    var body: some View {
        
        NavigationView
        {
            GeometryReader
            { geometry in
                
                // Header Logo
                VStack
                {
                    VStack
                    {
                        HStack(spacing: 0)
                        {
                            Spacer()
                            Image(systemName: "figure.walk.arrival")
                                .resizable()
                                .frame(width: 40, height: 40)
                            HeaderText(value : "Get & Go")
                            Image(systemName: "figure.walk.departure")
                                .resizable()
                                .frame(width: 40, height: 40)
                            Spacer()
                        }
                    }
                    .background(Color("PrimaryColor"))
                    
                    // Display all items in each different section
                    VStack
                    {
                        ScrollView(.vertical, showsIndicators: false)
                        {
                            // Snacks Section
                            VStack()
                            {
                                SubHeaderText(value: "Snacks", color: Color("SecondaryColor"))
                                ItemList(itemList: $database.snack, database: database)
                            }
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 25, trailing: 0))
                            
                            // Frozen Foods Section
                            VStack()
                            {
                                SubHeaderText(value: "Frozen Foods", color: Color("SecondaryColor"))
                                ItemList(itemList: $database.food, database: database)
                            }
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 25, trailing: 0))
                            
                            // Canned & Jarred Section
                            VStack()
                            {
                                SubHeaderText(value: "Canned & Jarred", color: Color("SecondaryColor"))
                                ItemList(itemList: $database.canjar, database: database)
                            }
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 25, trailing: 0))
                            
                            // Baverage Section
                            VStack()
                            {
                                SubHeaderText(value: "Baverage", color: Color("SecondaryColor"))
                                ItemList(itemList: $database.baverage, database: database)
                            }
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 25, trailing: 0))
                            
                            
                            // Household Section
                            VStack()
                            {
                                SubHeaderText(value: "Household", color: Color("SecondaryColor"))
                                ItemList(itemList: $database.household, database: database)
                            }
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 25, trailing: 0))
                            
                            // Personal Care Section
                            VStack()
                            {
                                SubHeaderText(value: "Personal Care", color: Color("SecondaryColor"))
                                ItemList(itemList: $database.personalcare, database: database)
                            }
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 25, trailing: 0))
                        }
                        
                    }
                    .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
                }
            }
           
        }
    }
}

// Display all the headers text of page
struct HeaderText: View {
    let value : String
    
    var body: some View {
        Text(value).font(.custom("Roboto-Bold", size: 40))
            .padding()
    }
}

// Display all the subheaders which is the header of each categories
struct SubHeaderText: View {
    let value : String
    let color : Color
    
    var body: some View {
        HStack()
        {
            Text(value)
                .font(.custom("Roboto-Bold", size: 30))
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
                .foregroundColor(.black)
            Spacer()
        }
        .background(color)
        .cornerRadius(5)
    }
}

// Display all the item of each categories
struct ItemList : View {
    @Binding var itemList: [String]
    @ObservedObject var database: Database
    
    var body : some View
    {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(itemList.indices, id: \.self) { index in
                    NavigationLink(
                        destination: Item(value : itemList[index], database: database),
                        label:{
                            VStack {
                                Image(itemList[index])
                                    .resizable()
                                    .frame(width: 90, height: 90)
                                
                                HStack
                                {
                                    Text(itemList[index])
                                        .foregroundColor(Color.black)
                                }
                                .frame(width: 150, height: 40)
                                .background(Color("PrimaryColor"))
                        }
                        .frame(width: 150, height: 150)
                        .border(Color("PrimaryColor"), width: 3)
                        
                    })
                    .navigationBarTitleDisplayMode(.inline)
                                    
                }
            }
        }
        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
    }
}

#Preview {
    Main(database: Database())
}
