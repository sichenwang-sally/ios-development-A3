# Booking App 

> Group Project · iOS Development · Assignment 3

A modern iOS restaurant reservation application built entirely with SwiftUI.

The application allows users to:
- Browse restaurants
- View restaurant details
- Search restaurants using Apple Maps
- Reserve dining seats with a cinema-style booking system
- Manage and cancel reservations
- Explore nearby restaurants directly from the map

---

# File Structure

| File | Responsibility |
|------|----------------|
| `BookingApp.swift` | Main app entry point, injects `BookingStore` into the environment |
| `Models.swift` | Defines `Restaurant` and `BookingItem` data models |
| `BookingStore.swift` | ObservableObject managing restaurants, bookings, and reserved seats |
| `ContentView.swift` | Root TabView navigation (`Hot`, `Map`, `Account`) |
| `RestaurantListView.swift` | Displays restaurant cards and navigation to detail pages |
| `RestaurantDetailView.swift` | Restaurant information and reservation entry point |
| `BookingView.swift` | Cinema-style seat reservation system with dynamic seat locking |
| `BookingListView.swift` | Displays booking history and cancellation functionality |
| `AccountView.swift` | User profile and account management page |
| `MapView.swift` | Apple Maps integration with restaurant search and dynamic annotations |

---

# Features

## Restaurant Discovery
- Browse popular restaurants
- Modern card-based interface
- Restaurant detail pages
- Cuisine and rating display

---

## Cinema-Style Reservation System
- Interactive seat selection
- Dynamic reserved seats
- Independent seat availability for different time slots
- Date and time selection
- Real-time seat locking system

---

## Booking Management
- View reservation history
- Cancel bookings
- Automatic reservation updates
- Persistent booking storage during runtime

---

## Apple Maps Integration
- Native Apple Maps support
- Dynamic restaurant annotations
- Automatic nearby restaurant search
- Search bar for restaurant discovery
- Tap map annotations to open restaurant details

---

# Technologies Used

- **SwiftUI** — declarative UI framework for building modern iOS interfaces
- **Combine** — reactive state management using `@Published`
- **Foundation** — handling dates, UUIDs, and core data types
- **MapKit** — native Apple Maps integration
- **CoreLocation** — restaurant coordinates and location handling

---

# UI Design

The application UI was inspired by:
- Cinema reservation systems
- Modern iOS applications
- Mobile booking platforms

Design highlights include:
- Rounded cards
- Interactive seat grid
- Dynamic map annotations
- Bottom booking confirmation bar
- Orange accent color system
- Smooth SwiftUI animations

---

# Seat Reservation Logic

The booking system dynamically stores reserved seats.

Reservations are separated by:
- Restaurant
- Date
- Time slot

Once a reservation is confirmed:
- Selected seats become unavailable
- Reserved seats are disabled
- Different time slots maintain independent seat availability
- Booking data is stored in `BookingStore`

---

# Map Search System

The application uses Apple Maps and `MKLocalSearch` to:
- Search nearby restaurants
- Automatically generate map annotations
- Display restaurant information dynamically
- Navigate directly to restaurant detail pages

---

# How to Run

1. Open the project in Xcode
2. Select an iPhone simulator
3. Press ▶ Run

Recommended:
- iOS 17+
- Xcode 16+

---

# GitHub
GitHub Link: 
