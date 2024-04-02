//
//  Database.swift
//  Final_Project
//
//  Created by Aritchai Hunnapachai on 30/12/2566 BE.
//

import Foundation

struct Locations
{
    var name : String
    var address : String
    var phone : String
}

class Database: ObservableObject {
    @Published var snack: [String] = ["Lays", "Doritos", "Pringles", "Oreo", "Cheetos", "Kit Kat", "Goldfish", "Pocky", "Hershey", "Ruffles"]
    
    @Published var food: [String] = ["Chicken Wings", "Pork Fried Rice", "Takoyaki", "Rice", "Spring Rolls", "French Fries", "Pizza", "Pork Curry", "Ramen", "Noodle"]
    
    @Published var canjar: [String] = ["Bean", "Soup", "Salmon", "Pineapple", "Ham", "Strawberry Jam", "Honey", "Mayonnaise", "Ketchup", "Mustard"]
    
    @Published var baverage: [String] = ["Coke", "Pepsi", "Orange Juice", "Milk", "Apple Juice", "Yacult", "Gatorade", "Red Bull", "Sparkling Water", "Coffee"]
    
    @Published var household: [String] = ["Trash Bag", "Sponge", "Bleach", "Floor Cleaner", "Dishwash Detergent", "Laundry Detergent", "Paper Towels", "Car Refresher", "Disinfectant Wipes", "Air Refresher"]
    
    @Published var personalcare: [String] = ["Bar Soap", "Shampoo", "Liquid Soap", "Toothpaste", "Toothbrush", "Mouth Wash", "Razor", "Conditioner", "Hand Sanitizer", "Shaving Cream"]
    
    @Published var cartList: [String: Int] = [:]
    
    @Published var locations : [Locations] = []
    
    @Published var user : Int = 0
    
    @Published var filteredData : [String] = []
        
    init() 
    {
        // Initialize the locations array with an initial location
        let initialLocation = Locations(name: "Randy", address: "No. 1號, Section 2, Daxue Rd, Shoufeng Township, Hualien County, 974", phone: "0910125817")
        self.locations = [initialLocation]
    }
    
    func addToBasket(item : String , amount : Int)
    {
        if let existingAmount = cartList[item] {
            cartList[item] = existingAmount + amount
        } else {
            cartList[item] = amount
        }
    }
    
    func addUser(name : String, address : String, phone : String)
    {
        let newLocation = Locations(name : name, address: address, phone : phone)
        locations.append(newLocation)
    }
    
    func removeUser(index : Int)
    {
        locations.remove(at: index)
    }
    
    func emptyCarList()
    {
        cartList = [:]
    }
    
    func searchItems(with query: String){
        let allItems = snack + food + canjar + baverage + household + personalcare
        let filteredItems = query.isEmpty ? allItems : allItems.filter { $0.localizedCaseInsensitiveContains(query) }
        filteredData = filteredItems
    }
    
}
