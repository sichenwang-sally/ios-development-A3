//
//  MapView.swift
//  Booking App
//
//
import SwiftUI
import MapKit

struct MapView: View {

    @State private var searchText = "restaurant"
    @State private var mapItems: [MKMapItem] = []
    @State private var selectedRestaurant: Restaurant?

    @State private var cameraPosition: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: -33.8688, longitude: 151.2093),
            span: MKCoordinateSpan(latitudeDelta: 0.04, longitudeDelta: 0.04)
        )
    )

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {

                searchBar
                    .padding()

                Map(position: $cameraPosition) {
                    ForEach(mapItems, id: \.self) { item in
                        if let coordinate = item.placemark.location?.coordinate {
                            Annotation(item.name ?? "Restaurant", coordinate: coordinate) {
                                Button {
                                    selectedRestaurant = makeRestaurant(from: item)
                                } label: {
                                    VStack(spacing: 4) {
                                        Image(systemName: "mappin.circle.fill")
                                            .font(.system(size: 34))
                                            .foregroundColor(.orange)

                                        VStack(spacing: 2) {
                                            Text(item.name ?? "Restaurant")
                                                .font(.caption.bold())

                                            Text(item.pointOfInterestCategory?.rawValue ?? "Restaurant")
                                                .font(.caption2)
                                                .foregroundColor(.secondary)
                                        }
                                        .padding(.horizontal, 10)
                                        .padding(.vertical, 6)
                                        .background(Color.white)
                                        .cornerRadius(12)
                                    }
                                }
                            }
                        }
                    }
                }

                restaurantCards
            }
            .navigationTitle("Map")
            .navigationBarTitleDisplayMode(.inline)
            .task {
                await searchRestaurants()
            }
            .sheet(item: $selectedRestaurant) { restaurant in
                RestaurantDetailView(restaurant: restaurant)
            }
        }
    }

    private var searchBar: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.secondary)

            TextField("Search restaurants", text: $searchText)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                .onSubmit {
                    Task {
                        await searchRestaurants()
                    }
                }

            Button("Search") {
                Task {
                    await searchRestaurants()
                }
            }
            .foregroundColor(.orange)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
    }

    private var restaurantCards: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 14) {
                ForEach(mapItems, id: \.self) { item in
                    Button {
                        selectedRestaurant = makeRestaurant(from: item)
                    } label: {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(item.name ?? "Restaurant")
                                .font(.headline)
                                .foregroundColor(.primary)

                            Text(item.placemark.title ?? "No address")
                                .font(.caption)
                                .foregroundColor(.secondary)
                                .lineLimit(2)

                            Text("View Details")
                                .font(.caption.bold())
                                .foregroundColor(.orange)
                        }
                        .frame(width: 220, alignment: .leading)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(18)
                        .shadow(color: .black.opacity(0.08), radius: 8, y: 4)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground))
    }

    private func searchRestaurants() async {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText.isEmpty ? "restaurant" : searchText
        request.resultTypes = .pointOfInterest

        request.region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: -33.8688, longitude: 151.2093),
            span: MKCoordinateSpan(latitudeDelta: 0.08, longitudeDelta: 0.08)
        )

        let search = MKLocalSearch(request: request)

        do {
            let response = try await search.start()
            mapItems = response.mapItems
        } catch {
            print("Map search failed: \(error.localizedDescription)")
        }
    }

    private func makeRestaurant(from item: MKMapItem) -> Restaurant {
        let coordinate = item.placemark.coordinate

        return Restaurant(
            name: item.name ?? "Restaurant",
            cuisine: "Restaurant",
            rating: 4.5,
            imageName: "fork.knife.circle.fill",
            description: item.placemark.title ?? "Restaurant found from Apple Maps.",
            latitude: coordinate.latitude,
            longitude: coordinate.longitude
        )
    }
}
