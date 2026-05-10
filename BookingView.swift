//
//  BookingView.swift
//  Booking App
import SwiftUI

struct BookingView: View {

    let restaurant: Restaurant

    @EnvironmentObject var store: BookingStore
    @Environment(\.dismiss) private var dismiss

    // MARK: Selection State

    @State private var selectedDate = 0
    @State private var selectedTime = "7:00 PM"

    @State private var selectedSeats: [String] = []

    // MARK: Dates

    let dates = [
        "Mon\n12",
        "Tue\n13",
        "Wed\n14",
        "Thu\n15",
        "Fri\n16"
    ]

    // MARK: Times

    let times = [
        "5:00 PM",
        "6:00 PM",
        "7:00 PM",
        "8:00 PM"
    ]

    // MARK: Seat Layout

    let seats = [
        ["A1","A2","A3","A4","A5"],
        ["B1","B2","B3","B4","B5"],
        ["C1","C2","C3","C4","C5"],
        ["D1","D2","D3","D4","D5"]
    ]
    
    private var reservedSeats: [String] {
        store.reservedSeats(for: restaurant, date: selectedDate, time: selectedTime)
    }

    var body: some View {

        VStack(spacing: 20) {

            // MARK: Header

            VStack(alignment: .leading, spacing: 6) {

                Text(restaurant.name)
                    .font(.largeTitle.bold())

                Text(restaurant.cuisine)
                    .foregroundColor(.orange)

            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)

            // MARK: Date Picker

            ScrollView(.horizontal, showsIndicators: false) {

                HStack(spacing: 14) {

                    ForEach(dates.indices, id: \.self) { index in

                        Button {

                            withAnimation {
                                selectedDate = index
                            }

                        } label: {

                            Text(dates[index])
                                .multilineTextAlignment(.center)
                                .font(.headline)
                                .frame(width: 70, height: 80)
                                .background(
                                    selectedDate == index
                                    ? Color.orange
                                    : Color(.systemGray6)
                                )
                                .foregroundColor(
                                    selectedDate == index
                                    ? .white
                                    : .primary
                                )
                                .cornerRadius(20)
                        }
                    }
                }
                .padding(.horizontal)
            }

            // MARK: Time Picker

            VStack(alignment: .leading, spacing: 12) {

                Text("Select Time")
                    .font(.headline)

                ScrollView(.horizontal, showsIndicators: false) {

                    HStack(spacing: 12) {

                        ForEach(times, id: \.self) { time in

                            Button {

                                withAnimation {
                                    selectedTime = time
                                }

                            } label: {

                                Text(time)
                                    .font(.subheadline.bold())
                                    .padding(.horizontal, 18)
                                    .padding(.vertical, 12)
                                    .background(
                                        selectedTime == time
                                        ? Color.orange
                                        : Color(.systemGray6)
                                    )
                                    .foregroundColor(
                                        selectedTime == time
                                        ? .white
                                        : .primary
                                    )
                                    .cornerRadius(14)
                            }
                        }
                    }
                }
            }
            .padding(.horizontal)

            // MARK: Screen

            VStack(spacing: 10) {

                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.orange.opacity(0.15))
                    .frame(height: 45)
                    .overlay(
                        Text("Dining Area")
                            .font(.headline)
                    )

                Text("Select Your Seats")
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal)

            // MARK: Seat Grid

            VStack(spacing: 16) {

                ForEach(seats, id: \.self) { row in

                    HStack(spacing: 16) {

                        ForEach(row, id: \.self) { seat in

                            Button {

                                selectSeat(seat)

                            } label: {

                                RoundedRectangle(cornerRadius: 14)
                                    .fill(seatColor(seat))
                                    .frame(width: 56, height: 56)
                                    .overlay(

                                        Text(seat)
                                            .font(.caption.bold())
                                            .foregroundColor(
                                                selectedSeats.contains(seat)
                                                ? .white
                                                : .primary
                                            )
                                    )
                            }
                            .disabled(reservedSeats.contains(seat))
                        }
                    }
                }
            }

            // MARK: Legend

            HStack(spacing: 20) {

                legend(color: .orange, text: "Selected")

                legend(color: Color(.systemGray4), text: "Reserved")

                legend(color: Color(.systemGray6), text: "Available")
            }

            Spacer()

            // MARK: Bottom Bar

            VStack(spacing: 14) {

                HStack {

                    VStack(alignment: .leading, spacing: 4) {

                        Text("\(selectedSeats.count) Seats")
                            .font(.headline)

                        Text(selectedSeats.joined(separator: ", "))
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }

                    Spacer()

                    Text(selectedTime)
                        .font(.headline.bold())
                }

                Button {

                    let booking = BookingItem(
                        restaurant: restaurant,
                        guestName: "Sichen Wang",
                        selectedDateIndex: selectedDate,
                        date: Date(),
                        time: selectedTime,
                        seats: selectedSeats
                    )

                    store.addBooking(booking)

                    dismiss()

                } label: {

                    Text("Confirm Booking")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            selectedSeats.isEmpty
                            ? Color.gray
                            : Color.orange
                        )
                        .cornerRadius(22)
                }
                .disabled(selectedSeats.isEmpty)
            }
            .padding()
            .background(Color.white)
            .shadow(color: .black.opacity(0.08), radius: 10, y: -4)
        }
        .background(Color(.systemGroupedBackground))
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: Seat Color

    private func seatColor(_ seat: String) -> Color {

        if reservedSeats.contains(seat) {

            return Color(.systemGray4)

        } else if selectedSeats.contains(seat) {

            return .orange

        } else {

            return Color(.systemGray6)
        }
    }

    // MARK: Seat Selection

    private func selectSeat(_ seat: String) {

        if reservedSeats.contains(seat) {
            return
        }

        if selectedSeats.contains(seat) {

            selectedSeats.removeAll(where: { item in
                item == seat
            })

        } else {

            selectedSeats.append(seat)
        }
    }

    // MARK: Legend

    private func legend(color: Color, text: String) -> some View {

        HStack(spacing: 6) {

            Circle()
                .fill(color)
                .frame(width: 12, height: 12)

            Text(text)
                .font(.caption)
        }
    }
}
