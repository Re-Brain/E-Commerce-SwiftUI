//
//  AddUser.swift
//  Final_Project
//
//  Created by Aritchai Hunnapachai on 31/12/2566 BE.
//

import SwiftUI
import Combine

struct AddUser: View {
    @ObservedObject var database: Database
    @Environment(\.presentationMode) var presentationMode
    @State private var name : String = ""
    @State private var phone : String = ""
    @State private var address : String = ""
    
    var body: some View {
        
        NavigationView
        {
            VStack
            {
               Text("Add User")
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
                        TextField("Enter Your Name", text: $name)
                            .foregroundColor(.black)
                    }
                    
                    Section(header : Text("Address")
                        .listRowInsets(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                        .foregroundColor(.black)
                        .font(.custom("Roboto-bold", size: 20))
                    )
                    {
                        TextField("Enter Your Address", text: $address)
                            .foregroundColor(.black)
                    }
                    
                    Section(header : Text("Phone")
                        .listRowInsets(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                        .foregroundColor(.black)
                        .font(.custom("Roboto-bold", size: 20))
                    )
                    {
                        TextField("Enter Your Phone (Number Only)", text: $phone)
                            .keyboardType(.numberPad)
                            .foregroundColor(.black)
                            .onReceive(Just(phone)) { newString in
                                let filtered = newString.filter { "0123456789".contains($0) }
                                if filtered != newString {
                                    self.phone = filtered
                                }
                            }
                    }
                   
                    
                    HStack
                    {
                        Spacer()
                        
                        Button
                        {
                            database.addUser(name: name, address: address, phone: phone)
                            presentationMode.wrappedValue.dismiss()
                        }
                        label:
                        {
                            Text("Submit")
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
    AddUser(database: Database())
}
