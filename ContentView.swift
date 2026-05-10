//
//  ContentView.swift
//  Booking App
//
// by Sichen Wang
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            RestaurantListView()
                .tabItem {
                    Image(systemName: "flame.fill")
                    Text("Hot")
                }
            
            MapView()
                .tabItem{
                    Image(systemName: "map.fill")
                    Text("Map")
                }
            
            AccountView()
                .tabItem{
                    Image(systemName: "person.fill")
                    Text("Account")
                }
        }
        .tint(.orange)
    }
}

#Preview {
    AccountView()
        .environmentObject(BookingStore())
}
