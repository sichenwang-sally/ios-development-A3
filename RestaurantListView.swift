//
//  RestaurantListView.swift
//  Booking App
//
//
import SwiftUI

struct RestaurantListView: View {
    @EnvironmentObject var store: BookingStore
    
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack(spacing: 20){
                    header
                    
                    ForEach(store.restaurants) { restaurant in
                        NavigationLink{
                            RestaurantDetailView(restaurant: restaurant)
                        }label: {
                            RestaurantCardView(restaurant: restaurant)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding()
            }
            .background(Color(.systemGroupedBackground))
        }
    }
    
    private var header: some View {
        HStack {
            VStack(alignment: .leading){
                Text("Popular Restaurants")
                    .font(.largeTitle.bold())
                
                Text("Find your favourite place")
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Image(systemName: "bell.fill")
                .foregroundColor(.orange)
        }
    }
}

struct RestaurantCardView: View {
    let restaurant: Restaurant

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {

            ZStack(alignment: .bottomLeading) {
                RoundedRectangle(cornerRadius: 24)
                    .fill(
                        LinearGradient(
                            colors: [.orange.opacity(0.9), .brown.opacity(0.7)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(height: 150)

                Image(systemName: restaurant.imageName)
                    .font(.system(size: 70))
                    .foregroundColor(.white.opacity(0.25))
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding()

                VStack(alignment: .leading, spacing: 6) {
                    Text(restaurant.name)
                        .font(.title2.bold())
                        .foregroundColor(.white)

                    Text(restaurant.cuisine)
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.85))
                }
                .padding()
            }

            HStack {
                Label(String(format: "%.1f", restaurant.rating), systemImage: "star.fill")
                    .foregroundColor(.orange)

                Spacer()

                Text("Book Now")
                    .font(.caption.bold())
                    .foregroundColor(.white)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 8)
                    .background(Color.orange)
                    .cornerRadius(20)
            }
            .padding()
            .background(Color.white)
        }
        .background(Color.white)
        .cornerRadius(24)
        .shadow(color: .black.opacity(0.08), radius: 10, x: 0, y: 5)
    }
}
