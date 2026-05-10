//
//  Models.swift
//  Booking App
//
//
import Foundation
import CoreLocation

struct Restaurant: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let cuisine: String
    let rating: Double
    let imageName: String
    let description: String
    let latitude: Double
    let longitude: Double

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

struct BookingItem: Identifiable {
    let id = UUID()
    let restaurant: Restaurant
    let guestName: String
    let selectedDateIndex: Int
    let date: Date
    let time: String
    let seats: [String]
}
