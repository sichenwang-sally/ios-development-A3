//
//  BookingListView.swift
//  Booking App
//
import SwiftUI

struct BookingListView: View {
    @EnvironmentObject var store: BookingStore

    var body: some View {
        NavigationStack {
            ScrollView {
                if store.bookings.isEmpty {
                    emptyView
                } else {
                    VStack(spacing: 16) {
                        ForEach(store.bookings) { booking in
                            bookingCard(booking)
                        }
                    }
                    .padding()
                }
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("My Bookings")
        }
    }

    private var emptyView: some View {
        VStack(spacing: 16) {
            Image(systemName: "calendar.badge.plus")
                .font(.system(size: 70))
                .foregroundColor(.orange)

            Text("No Bookings Yet")
                .font(.title2.bold())

            Text("Your confirmed bookings will appear here.")
                .foregroundColor(.secondary)
        }
        .padding(.top, 120)
    }

    private func bookingCard(_ booking: BookingItem) -> some View {

        VStack(alignment: .leading, spacing: 12) {

            HStack {

                Text(booking.restaurant.name)
                    .font(.title3.bold())

                Spacer()

                Text("Confirmed")
                    .font(.caption.bold())
                    .foregroundColor(.white)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color.orange)
                    .cornerRadius(20)
            }

            Text(booking.restaurant.cuisine)
                .foregroundColor(.orange)

            Divider()

            Label(
                booking.date.formatted(date: .abbreviated, time: .omitted),
                systemImage: "calendar"
            )

            Label(
                booking.time,
                systemImage: "clock"
            )

            Label(
                booking.seats.joined(separator: ", "),
                systemImage: "chair.lounge.fill"
            )

            // MARK: Cancel Button

            Button {

                withAnimation {

                    store.removeBooking(booking)
                }

            } label: {

                Text("Cancel Booking")
                    .font(.headline)
                    .foregroundColor(.red)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(Color.red.opacity(0.1))
                    .cornerRadius(14)
            }
            .padding(.top, 6)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(22)
        .shadow(
            color: .black.opacity(0.06),
            radius: 8,
            y: 4
        )
    }
}
