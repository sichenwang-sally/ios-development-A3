//
//  BookingApp.swift
//  Booking App
//
//

import SwiftUI

@main

struct BookingApp: App {
    @StateObject private var store = BookingStore()
    
    var body: some Scene{
        WindowGroup{
            ContentView()
                .environmentObject(store)
        }
    }
}

