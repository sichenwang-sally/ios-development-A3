//
//  RestaurantDetailView.swift
//  Booking App
//
import SwiftUI

struct RestaurantDetailView: View {
    let restaurant: Restaurant
    @State private var showBooking = false

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                ZStack(alignment: .bottomLeading) {
                    SwiftUI.LinearGradient(
                        colors: [.orange, .brown],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .frame(height: 280)

                    Image(systemName: restaurant.imageName)
                        .font(.system(size: 100))
                        .foregroundColor(.white.opacity(0.25))
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding()

                    VStack(alignment: .leading, spacing: 8) {
                        Text(restaurant.name)
                            .font(.largeTitle.bold())
                            .foregroundColor(.white)

                        Text(restaurant.cuisine)
                            .foregroundColor(.white.opacity(0.9))
                    }
                    .padding(24)
                }

                VStack(alignment: .leading, spacing: 16) {
                    Label(String(format: "%.1f Rating", restaurant.rating), systemImage: "star.fill")
                        .foregroundColor(.orange)

                    Text("Description")
                        .font(.title2.bold())

                    Text(restaurant.description)
                        .foregroundColor(.secondary)

                    Button {
                        showBooking = true
                    } label: {
                        Text("Reserve Now")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.orange)
                            .cornerRadius(20)
                    }
                    .padding(.top)
                }
                .padding()
            }
        }
        .ignoresSafeArea(edges: .top)
        .sheet(isPresented: $showBooking) {
            BookingView(restaurant: restaurant)
        }
    }
}

