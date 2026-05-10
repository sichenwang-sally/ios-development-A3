//
//  AccountView.swift
//  Booking App
//
import SwiftUI

struct AccountView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    profileCard
                    menuList
                }
                .padding()
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Account")
        }
    }

    private var profileCard: some View {
        VStack(spacing: 12) {
            Image(systemName: "person.crop.circle.fill")
                .font(.system(size: 90))
                .foregroundColor(.orange)

            Text("Sichen Wang")
                .font(.title2.bold())

            Text("Booking Member")
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(30)
        .background(Color.white)
        .cornerRadius(24)
        .shadow(color: .black.opacity(0.06), radius: 8, y: 4)
    }

    private var menuList: some View {
        VStack(spacing: 14) {
            NavigationLink {
                BookingListView()
            } label: {
                menuRow(icon: "calendar.badge.checkmark", title: "My Bookings")
            }

            menuRow(icon: "heart.fill", title: "Favourites")
            menuRow(icon: "creditcard.fill", title: "Payment Method")
            menuRow(icon: "questionmark.circle.fill", title: "Help Centre")
        }
    }

    private func menuRow(icon: String, title: String) -> some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.orange)
                .frame(width: 30)

            Text(title)
                .font(.headline)
                .foregroundColor(.primary)

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(18)
    }
}
