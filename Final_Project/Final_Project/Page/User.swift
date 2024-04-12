//
//  User.swift
//  Final_Project
//
//  Created by Aritchai Hunnapachai on 31/12/2566 BE.
//

import SwiftUI

struct User : View {
    @ObservedObject var database: Database // Declare database class as stateObject
    @EnvironmentObject var tabSelectionViewModel: TabSelectionViewModel // For tableview page selection
    
    var body: some View {
        
        NavigationView
        {
    
            VStack
            {
                // Header Section
                HStack
                {
                    Spacer()
                    Image(systemName: "person.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                    Text("User")
                        .font(.custom("Roboto-bold", size: 25))
                    Spacer()
                }
                .padding()
                .background(Color("PrimaryColor"))
                
                // Display all the location in the database
                GeometryReader { geometry in
                    
                    VStack
                    {
                        ScrollView(.vertical, showsIndicators: false)
                        {
                            ForEach(database.locations.indices, id: \.self) { index in
                                VStack
                                {
                                    Button
                                    {
                                        database.user = index
                                    }
                                    label :
                                    {
                                        VStack()
                                        {
                                            VStack(alignment: .leading)
                                            {
                                                HStack
                                                {
                                                    Text("User: \(database.locations[index].name)")
                                                        .multilineTextAlignment(.leading)
                                                        .foregroundStyle(Color.black)
                                                        .font(.custom("Roboto-regular", size: 20))
                                                    Spacer()
                                                }
                                                .padding(EdgeInsets(top: 0, leading: 5, bottom: 1, trailing: 5))
                                                
                                                VStack
                                                {
                                                    HStack
                                                    {
                                                        Text("Address:")
                                                            .multilineTextAlignment(.leading)

                                                            .foregroundStyle(Color.black)
                                                            .font(.custom("Roboto-regular", size: 20))
                                                        Spacer()
                                                    }
                                                    .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5))
                                                    
                                                    HStack
                                                    {
                                                        Text("\(database.locations[index].address)")
                                                            .multilineTextAlignment(.leading)
                                                            .lineLimit(nil)
                                                            .foregroundStyle(Color.black)
                                                            .font(.custom("Roboto-regular", size: 20))
                                                        Spacer()
                                                    }
                                                    .padding(EdgeInsets(top: 0, leading: 5, bottom: 1, trailing: 5))
                                                }
                                                
                                                HStack
                                                {
                                                    Text("Phone: \(database.locations[index].phone)")
                                                        .multilineTextAlignment(.leading)
                                                        .foregroundStyle(Color.black)
                                                        .font(.custom("Roboto-regular", size: 20))
                                                    Spacer()
                                                }
                                                .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5))
                                                
                                                Spacer()
                                                
                                                if(database.user == index)
                                                {
                                                    HStack
                                                    {
                                                        Spacer()
                                                        Text("Selected")
                                                            .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                                                            .background(Color.green)
                                                            .foregroundStyle(Color.black)
                                                            .cornerRadius(5)
                                                    }
                                                    
                                                }
                                            }
                                            
                                        }
                                        .padding()
            
                                    }
                                    
                                    
                                    HStack
                                    {
                                        // Edit the item
                                        HStack
                                        {
                                            Spacer()
                                            NavigationLink(destination: EditPage(database: database, id: index) , label:
                                            {
                                                Text("Edit")
                                                    .foregroundColor(.black)
                                            })
                                           
                                            Spacer()
                                        }
                                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                                        .background(Color.green)
                                        .cornerRadius(10)
                                        
                                        // Delete item
                                        HStack
                                        {
                                            Spacer()
                                            Button
                                            {
                                                database.removeUser(index: index)
                                                if(database.user != 0)
                                                {
                                                    database.user = database.user - 1
                                                }
                                            }
                                        label:
                                            {
                                                Text("Delete")
                                                    .foregroundColor(.black)
                                            }
                                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                                            
                                            Spacer()
                                        }
                                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                                        .background(Color.red)
                                        .cornerRadius(10)
                                    }
                                    .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                                    
                                    
                                }
                                .background(Color("PrimaryColor"))
                            }
                        }
                        .cornerRadius(10)
                        .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                       
                        // Add new user
                        HStack
                        {
                            Spacer()
                            
                            NavigationLink( destination: AddUser(database: database),
                                            label:{
                                Image(systemName: "plus.circle.fill")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(Color("PrimaryColor"))
                            })
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 10))
                        }
                        
                    }
                    .frame(maxWidth: geometry.size.width , maxHeight: geometry.size.height)
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                    
                }
            }
        }
    }
}

#Preview {
    User(database: Database())
}
