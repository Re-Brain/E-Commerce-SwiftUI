//
//  Item.swift
//  Final_Project
//
//  Created by Aritchai Hunnapachai on 30/12/2566 BE.
//

import SwiftUI

struct Item: View {
    let value : String // The item that this section will show
    @State private var counter = 1 // Amount of item that user want to put in
    @ObservedObject var database: Database // Declare database class as stateObject
    @Environment(\.presentationMode) var presentationMode // This page can be dismiss to return to the previous page without using the table view
   
    var body: some View {
        
        GeometryReader { geometry in
            
            VStack(alignment: .center)
            {
                // Display image of the item
                Image(value) // Replace "yourImageName" with the name of your image asset
                    .resizable()
                    .frame(width: geometry.size.width / 1.5 , height: geometry.size.height / 2 ) // Set the width of the image to the width of the screen
                    .clipped() // Clip the image to fit within the frame
                    .padding()
                
                // Display the detail of the item
                VStack
                {
                    HStack
                    {
                        Text(value)
                            .foregroundColor(Color.black)
                            .font(.system(size: 30))
                        
                        Spacer()
                    }
                    
                    HStack
                    {
                        Text("$30")
                            .foregroundColor(Color.gray)
                            .font(.system(size: 20))
                        
                        Spacer()
                    }
                   
                }
                .padding()
                
                // Adjust the amount of item that the user wants to put in the cart
                HStack
                {
                    Button
                    {
                        counter -= 1
                    }label: {
                        Image(systemName: "minus.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(Color("PrimaryColor"))
                    }
                    .disabled(counter == 1)
                    
                    Text(String(counter))
                    
                    Button
                    {
                        counter += 1
                    }label: {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(Color("PrimaryColor"))
                    }
                    .disabled(counter == 100)
                }
                .padding()
                
                // Add the item to the cart
                Button
                {
                    database.addToBasket(item: value, amount: counter)
                    presentationMode.wrappedValue.dismiss()
                }label: {
                    Text("Add Item")
                        .frame(width: geometry.size.width / 2)
                        .padding()
                        .background(Color("PrimaryColor"))
                        .foregroundColor(Color.black)
                       
                }
            
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .border(Color("PrimaryColor"), width: 3)
            .padding()
            .onAppear {
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}


