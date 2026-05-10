//
//  BookingStore.swift
//  Booking App
//
//
import Foundation
import SwiftUI
import Combine

final class BookingStore: ObservableObject{
    
    @Published var restaurants: [Restaurant] = [

        Restaurant(
            name: "Petit Bistro",
            cuisine: "Wine Bar",
            rating: 4.2,
            imageName: "fork.knife.circle.fill",
            description: "Some information for the restaurant...",
            latitude: -33.8688,
            longitude: 151.2093
        ),

        Restaurant(
            name: "Petit",
            cuisine: "Bar",
            rating: 3.8,
            imageName: "cup.and.saucer.fill",
            description: "A modern casual bar experience.",
            latitude: -33.8720,
            longitude: 151.2050
        ),

        Restaurant(
            name: "Bibimbar",
            cuisine: "Korean",
            rating: 4.1,
            imageName: "takeoutbag.and.cup.and.straw.fill",
            description: "Authentic Korean dishes and BBQ.",
            latitude: -33.8650,
            longitude: 151.2150
        )
    ]
    
    @Published var bookings: [BookingItem] = []
    
    func reservedSeats(for restaurant: Restaurant, date: Int, time: String) -> [String] {
        bookings
            .filter { item in
                item.restaurant.id == restaurant.id &&
                item.selectedDateIndex == date &&
                item.time == time
            }
            .flatMap { item in
                item.seats
            }
    }
    
    func addBooking(_ booking: BookingItem){
        bookings.append(booking)
    }
    
    func removeBooking(_ booking: BookingItem) {
        bookings.removeAll { item in
            item.id == booking.id
        }
    }
}
