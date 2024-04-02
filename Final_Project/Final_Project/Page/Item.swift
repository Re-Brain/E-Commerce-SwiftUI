//
//  Item.swift
//  Final_Project
//
//  Created by Aritchai Hunnapachai on 30/12/2566 BE.
//

import SwiftUI

struct Item: View {
    let value : String
    @State private var counter = 1
    @ObservedObject var database: Database
    @Environment(\.presentationMode) var presentationMode
   
    var body: some View {
        
        GeometryReader { geometry in
            
            VStack(alignment: .center)
            {
                Image(value) // Replace "yourImageName" with the name of your image asset
                    .resizable()
                    .frame(width: geometry.size.width / 1.5 , height: geometry.size.height / 2 ) // Set the width of the image to the width of the screen
                    .clipped() // Clip the image to fit within the frame
                    .padding()
                
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


