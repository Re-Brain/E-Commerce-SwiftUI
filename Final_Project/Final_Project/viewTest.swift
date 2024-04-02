//
//  viewTest.swift
//  Final_Project
//
//  Created by Aritchai Hunnapachai on 30/12/2566 BE.
//

import SwiftUI

struct viewTest: View {
    @State private var isLinkActive = false

        var body: some View {
            TabView {
                FirstTabView(isLinkActive: $isLinkActive)
                    .tabItem {
                        Label("First", systemImage: "1.circle")
                    }
                
                SecondTabView()
                    .tabItem {
                        Label("Second", systemImage: "2.circle")
                    }
            }
        }
}

struct FirstTabView: View {
    @Binding var isLinkActive: Bool

    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(
                    "Go to Another Page",
                    destination: AnotherPageView(),
                    isActive: $isLinkActive
                )
            }
            .navigationTitle("First Tab View")
        }
    }
}

struct AnotherPageView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        Text("Another Page")
            .navigationTitle("Another Page")
            .onAppear {
                // Reset the navigation link's state when AnotherPageView appears
                presentationMode.wrappedValue.dismiss()
            }
    }
}

struct SecondTabView: View {
    var body: some View {
        Text("Second Tab View")
    }
}

#Preview {
    viewTest()
}
