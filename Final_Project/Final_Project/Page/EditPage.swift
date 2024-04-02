//
//  EditPage.swift
//  Final_Project
//
//  Created by Aritchai Hunnapachai on 1/1/2567 BE.
//

import SwiftUI
import Combine

struct EditPage: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var database: Database
    let id : Int
   
    var body: some View {
        NavigationView
        {
            VStack
            {
                Text("Edit User")
                    .padding()
                    .font(.custom("Roboto-bold", size: 35))
                
                Form
                {
                    Section(header : Text("Name")
                            .listRowInsets(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                            .foregroundColor(.black)
                            .font(.custom("Roboto-bold", size: 20))
                    )
                    {
                        TextField("Name", text: $database.locations[id].name)
                            .foregroundColor(.black)
                    }
                    
                    Section(header : Text("Address")
                        .listRowInsets(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                        .foregroundColor(.black)
                        .font(.custom("Roboto-bold", size: 20))
                    )
                    {
                        TextField("Address", text: $database.locations[id].address)
                            .foregroundColor(.black)
                    }
                    
                    Section(header : Text("Phone")
                        .listRowInsets(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                        .foregroundColor(.black)
                        .font(.custom("Roboto-bold", size: 20))
                    )
                    {
                        TextField("Phone", text: $database.locations[id].phone)
                            .foregroundColor(.black)
                            .keyboardType(.numberPad)
                            .foregroundColor(.black)
                            .onReceive(Just(database.locations[id].phone)) { newString in
                                let filtered = newString.filter { "0123456789".contains($0) }
                                if filtered != newString {
                                    self.database.locations[id].phone = filtered
                                }
                            }
                    }
                    
                    HStack
                    {
                        Spacer()
                        
                        Button
                        {
                            presentationMode.wrappedValue.dismiss()
                        }
                        label:
                        {
                            Text("Edit")
                                .foregroundColor(Color.black)
                        }
                        .buttonStyle(DefaultButtonStyle())
                        
                        
                        Spacer()
                    }
                    .listRowBackground(Color("PrimaryColor"))
                }
                
            }
            .padding()
            .background(Color("SecondaryColor"))
            .scrollContentBackground(.hidden)
            
        }
        .onAppear {
            // Reset the navigation link's state when AnotherPageView appears
            presentationMode.wrappedValue.dismiss()
        }
        
    }
}

#Preview {
    EditPage(database: Database(), id : 0)
}
