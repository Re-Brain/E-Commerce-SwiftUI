//
//  Cart.swift
//  Final_Project
//
//  Created by Aritchai Hunnapachai on 30/12/2566 BE.
//

import SwiftUI

struct Cart: View {
    @ObservedObject var database: Database
    @State private var selectedTab: Int = 1
    @EnvironmentObject var tabSelectionViewModel: TabSelectionViewModel
    
    // Alert properties
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var total = 0
    
    var body: some View {
        GeometryReader { geometry in
            
            VStack{
                
                HStack
                {
                    Spacer()
                    Image(systemName: "cart.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                    Text("Shopping List")
                        .font(.custom("Roboto-bold", size: 25))
                    Spacer()
                }
                .padding()
                .background(Color("PrimaryColor"))
                
                ScrollView(.vertical, showsIndicators : false)
                {
                    VStack
                    {
                        SubHeaderText(value: "Item",  color: Color("SecondaryColor"))
                            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                        
                        VStack
                        {
                            
                                
                            ForEach(database.cartList.sorted(by: { $0.key < $1.key }).filter { $0.value > 0 }, id: \.key) { key, value in
                                
                                HStack
                                {
                                    Image(key)
                                        .resizable()
                                        .frame(width: 100, height: 100)
                                    
                                    VStack(alignment: .center)
                                    {
                                        Text(key)
                                            .foregroundColor(Color.black)
                                        Text("$\(Int(value) * 30)")
                                            .foregroundColor(Color.gray)
                                    }
                                    
                                    
                                    Spacer()
                                    
                                    HStack
                                    {
                                        Button
                                        {
                                            database.cartList[key] = value - 1
                                        }
                                    label:
                                        {
                                            Image(systemName: "minus.circle.fill")
                                                .resizable()
                                                .frame(width: 25, height: 25)
                                                .foregroundColor(Color.black) // Change the color here
                                        }
                                        
                                        Text(String(value))
                                        
                                        Button
                                        {
                                            database.cartList[key] = value + 1
                                        }
                                    label:
                                        {
                                            Image(systemName: "plus.circle.fill")
                                                .resizable()
                                                .frame(width: 25, height: 25)
                                                .foregroundColor(Color.black) // Change the color here
                                        }
                                    }
                                    .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                                    .background(Color("SecondaryColor"))
                                    .cornerRadius(20)
                                    
                                }
                                .padding()
                                
                            }
                        }
                        .frame(maxWidth: geometry.size.width , maxHeight: geometry.size.height / 2 )
                        .border(Color("PrimaryColor"), width: 3)
                        .cornerRadius(5)
                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                        
                        let total = database.cartList.reduce(0) { (accumulatedResult, element) in
                            // Combine the current accumulated result with the element (key-value pair)
                            return accumulatedResult + element.value * 30
                        }
                        
                        HStack
                        {
                            Text("Total: $\(total)")
                                .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
                                .font(.custom("Roboto-bold", size: 25))
                            Spacer()
                        }
                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                        
                        
                        SubHeaderText(value: "Location", color: Color("SecondaryColor"))
                            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                        
                        VStack
                        {
                            if (database.locations.isEmpty)
                            {
                                Button
                                {
                                    tabSelectionViewModel.selectedTab = 3
                                }
                            label: {
                                Text("Add Location")
                                    .frame(width: geometry.size.width / 2)
                                    .padding()
                                    .background(Color("PrimaryColor"))
                                    .foregroundColor(Color.black)
                            }
                            }
                            else
                            {
                                VStack(alignment: .leading)
                                {
                                    Text("User: \(database.locations[database.user].name)")
                                    Text("Address: \(database.locations[database.user].address)")
                                    Text("Phone: \(database.locations[database.user].phone)")
                                }
                                
                                Button
                                {
                                    tabSelectionViewModel.selectedTab = 3
                                }
                            label: {
                                Text("Change Location")
                                    .frame(width: geometry.size.width / 2)
                                    .padding()
                                    .background(Color("PrimaryColor"))
                                    .foregroundColor(Color.black)
                                    .cornerRadius(5)
                            }
                            }
                        }
                        .padding()
                        .frame(maxWidth: geometry.size.width)
                        .border(Color("PrimaryColor"), width: 3)
                        .cornerRadius(5)
                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                        
                        Button{
                            tabSelectionViewModel.selectedTab = 0
                        }
                    label: {
                        Text("Add More Item")
                            .frame(width: geometry.size.width / 1.2)
                            .padding()
                            .background(Color("PrimaryColor"))
                            .foregroundColor(Color.black)
                            .cornerRadius(5)
                    }
                        
                        Button
                        {
                            if (database.locations.isEmpty)
                            {
                                alertTitle = "Location not chosen"
                                alertMessage = "Please add location"
                            }
                            else if (database.cartList.isEmpty)
                            {
                                alertTitle = "No item chosen"
                                alertMessage = "Please add some item"
                            }
                            else
                            {
                                alertTitle = "Order placed"
                                alertMessage = "Please wait shortly"
                                
                                print("--- Start  ---")
                                print("User:")
                                print("Name: \(database.locations[database.user].name)")
                                print("Name: \(database.locations[database.user].address)")
                                print("Name: \(database.locations[database.user].phone)")
                                print("")
                                print("Item:")
                                for (item, amount) in database.cartList {
                                    print("Item: \(item), Amount: \(amount), Value: \(Int(amount) * 30)")
                                }
                                print("Total : $\(total)")
                                print("--- End ---")
                                database.emptyCarList()
                            }
                            showAlert = true
                        }
                    label:
                        {
                            Text("Place Order")
                                .frame(width: geometry.size.width / 1.2)
                                .padding()
                                .background(Color("PrimaryColor"))
                                .foregroundColor(Color.black)
                                .cornerRadius(5)
                        }
                        .alert(isPresented: $showAlert) {
                            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                        }
                        
                        Spacer()
                    }
                }
            }
        }
    }
}

#Preview {
    Cart(database: Database())
}
